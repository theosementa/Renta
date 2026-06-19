//  CostDescriptionGenerator.swift
//  Renta

import Foundation

public enum CostDescriptionGenerator: Sendable {

    public enum PerUnit: Sendable {
        case day
        case month
        case year

        fileprivate var localizationKey: String {
            switch self {
            case .day:   return "cost.perUnit.day"
            case .month: return "cost.perUnit.month"
            case .year:  return "cost.perUnit.year"
            }
        }
    }

    // MARK: - Public methods

    /// Locale-aware cost description, e.g. "12 €/day".
    public static func format(
        cost: Double,
        perUnit: PerUnit,
        currencyCode: String? = nil,
        locale: Locale = .current
    ) -> String {
        let amount = formattedCurrency(cost, currencyCode: currencyCode, locale: locale)
        let unit = NSLocalizedString(perUnit.localizationKey, bundle: .main, comment: "")
        return "\(amount)/\(unit)"
    }

    public static func formattedCurrency(
        _ amount: Double,
        currencyCode: String? = nil,
        locale: Locale = .current
    ) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        formatter.maximumFractionDigits = 0
        if let currencyCode {
            formatter.currencyCode = currencyCode
        }
        if let formatted = formatter.string(from: NSNumber(value: amount)) {
            return formatted
        }
        return String(format: "%.0f", amount)
    }

}
