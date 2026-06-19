//  DateCalculations.swift
//  Renta

import Foundation

public enum DateCalculations: Sendable {

    // MARK: - Public methods
    public static func daysSince(
        date: Date,
        to reference: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        calendar.dateComponents([.day], from: date, to: reference).day ?? 0
    }

    public static func dayOfMonth(
        reference: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        calendar.component(.day, from: reference)
    }

    public static func dayOfYear(
        reference: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        calendar.ordinality(of: .day, in: .year, for: reference) ?? 1
    }

    public static func daysThisMonth(
        daysOwned: Int,
        reference: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        min(daysOwned, dayOfMonth(reference: reference, calendar: calendar))
    }

    public static func daysThisYear(
        daysOwned: Int,
        reference: Date = .now,
        calendar: Calendar = .current
    ) -> Int {
        min(daysOwned, dayOfYear(reference: reference, calendar: calendar))
    }

}
