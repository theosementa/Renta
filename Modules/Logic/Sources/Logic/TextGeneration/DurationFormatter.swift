//  DurationFormatter.swift
//  Renta

import Foundation

public enum DurationFormatter: Sendable {

    private enum Constants {
        static let daysPerMonth: Double = 30.44
        static let daysPerYear: Double = 365
        static let monthCeilingInDays: Int = 31
        static let yearCeilingInDays: Int = 365
    }

    // MARK: - Public methods

    /// Localized long-form duration, e.g. "3 years, 2 months".
    /// Mirrors `ItemModelDomain.ownedForDisplay`, breaking a day span into the
    /// two most significant non-zero units.
    public static func format(days: Int) -> String {
        let (years, months, remainingDays) = breakdown(days: days)

        if years > 0 {
            let yearStr = yearString(years)
            guard months > 0 else { return yearStr }
            return combined(yearStr, monthString(months))
        }

        if months > 0 {
            let monthStr = monthString(months)
            guard remainingDays > 0 else { return monthStr }
            return combined(monthStr, dayString(remainingDays))
        }

        return remainingDays <= 1
            ? localized("item.owned.today")
            : String(format: localized("item.owned.days"), remainingDays)
    }

    /// Single most-significant-unit duration used by hint messages.
    /// Mirrors the private `formatDuration(_:)` in `ItemModelDomain+UI`.
    public static func formatCompact(days: Int) -> String {
        if days < Constants.monthCeilingInDays {
            return days == 1
                ? localized("item.owned.oneDay")
                : String(format: localized("item.owned.days"), days)
        } else if days < Constants.yearCeilingInDays {
            let months = Int((Double(days) / Constants.daysPerMonth).rounded(.toNearestOrAwayFromZero))
            return monthString(months)
        } else {
            let years = Int((Double(days) / Constants.daysPerYear).rounded(.toNearestOrAwayFromZero))
            return yearString(years)
        }
    }

    // MARK: - Private methods

    private static func breakdown(days: Int) -> (years: Int, months: Int, days: Int) {
        let safeDays = max(0, days)
        let years = safeDays / Constants.yearCeilingInDays
        let afterYears = safeDays % Constants.yearCeilingInDays
        let months = Int(Double(afterYears) / Constants.daysPerMonth)
        let remainingDays = afterYears - Int(Double(months) * Constants.daysPerMonth)
        return (years, months, max(0, remainingDays))
    }

    private static func yearString(_ years: Int) -> String {
        years == 1
            ? localized("item.owned.oneYear")
            : String(format: localized("item.owned.years"), years)
    }

    private static func monthString(_ months: Int) -> String {
        months == 1
            ? localized("item.owned.oneMonth")
            : String(format: localized("item.owned.months"), months)
    }

    private static func dayString(_ days: Int) -> String {
        days == 1
            ? localized("item.owned.oneDay")
            : String(format: localized("item.owned.days"), days)
    }

    private static func combined(_ first: String, _ second: String) -> String {
        String(format: localized("item.owned.combined"), first, second)
    }

    private static func localized(_ key: String) -> String {
        NSLocalizedString(key, bundle: .main, comment: "")
    }

}
