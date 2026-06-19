//  AmortisationCalculator.swift
//  Renta

import Foundation

public enum AmortisationCalculator: Sendable {

    private enum Constants {
        static let daysPerMonth: Double = 30.44
        static let daysPerYear: Double = 365
    }

    // MARK: - Public methods
    public static func daysOwned(
        from purchaseDate: Date,
        to reference: Date = .now
    ) -> Int {
        DateCalculations.daysSince(date: purchaseDate, to: reference)
    }

    public static func costPerDay(
        purchasePrice: Double,
        daysOwned: Int
    ) -> Double {
        daysOwned > 0 ? purchasePrice / Double(daysOwned) : purchasePrice
    }

    public static func costPerMonth(
        purchasePrice: Double,
        daysOwned: Int
    ) -> Double {
        costPerDay(purchasePrice: purchasePrice, daysOwned: daysOwned) * Constants.daysPerMonth
    }

    public static func costPerYear(
        purchasePrice: Double,
        daysOwned: Int
    ) -> Double {
        costPerDay(purchasePrice: purchasePrice, daysOwned: daysOwned) * Constants.daysPerYear
    }

    public static func totalAmortized(
        purchasePrice: Double,
        daysOwned: Int
    ) -> Double {
        costPerDay(purchasePrice: purchasePrice, daysOwned: daysOwned) * Double(daysOwned)
    }

    public static func costThisMonth(
        purchasePrice: Double,
        daysOwned: Int,
        reference: Date = .now
    ) -> Double {
        let daysThisMonth = DateCalculations.daysThisMonth(daysOwned: daysOwned, reference: reference)
        let perDay = costPerDay(purchasePrice: purchasePrice, daysOwned: daysOwned)
        return min(purchasePrice, perDay * Double(daysThisMonth))
    }

    public static func costThisYear(
        purchasePrice: Double,
        daysOwned: Int,
        reference: Date = .now
    ) -> Double {
        let daysThisYear = DateCalculations.daysThisYear(daysOwned: daysOwned, reference: reference)
        let perDay = costPerDay(purchasePrice: purchasePrice, daysOwned: daysOwned)
        return min(purchasePrice, perDay * Double(daysThisYear))
    }

    public static func metrics(
        purchasePrice: Double,
        daysOwned: Int,
        reference: Date = .now
    ) -> AmortisationMetrics {
        AmortisationMetrics(
            daysOwned: daysOwned,
            costPerDay: costPerDay(purchasePrice: purchasePrice, daysOwned: daysOwned),
            costPerMonth: costPerMonth(purchasePrice: purchasePrice, daysOwned: daysOwned),
            costPerYear: costPerYear(purchasePrice: purchasePrice, daysOwned: daysOwned),
            costThisMonth: costThisMonth(purchasePrice: purchasePrice, daysOwned: daysOwned, reference: reference),
            costThisYear: costThisYear(purchasePrice: purchasePrice, daysOwned: daysOwned, reference: reference),
            totalAmortized: totalAmortized(purchasePrice: purchasePrice, daysOwned: daysOwned)
        )
    }

}
