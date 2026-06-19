//  ProjectionCalculator.swift
//  Renta

import Foundation

public enum ProjectionCalculator: Sendable {

    // MARK: - Public methods

    /// Projects amortisation metrics forward in time, as if the item were owned
    /// continuously until `projectionDate`.
    ///
    /// `daysOwnedToday` is the ownership count at `today`; the elapsed span between
    /// `today` and `projectionDate` is added to it. A projection date in the past
    /// never reduces ownership below `daysOwnedToday`.
    public static func projectedAmortisation(
        purchasePrice: Double,
        daysOwnedToday: Int,
        projectionDate: Date,
        today: Date = .now
    ) -> AmortisationMetrics {
        let additionalDays = max(0, DateCalculations.daysSince(date: today, to: projectionDate))
        let projectedDaysOwned = daysOwnedToday + additionalDays
        return AmortisationCalculator.metrics(
            purchasePrice: purchasePrice,
            daysOwned: projectedDaysOwned,
            reference: projectionDate
        )
    }

    public static func projectedCostPerDay(
        purchasePrice: Double,
        daysOwnedToday: Int,
        projectionDate: Date,
        today: Date = .now
    ) -> Double {
        let additionalDays = max(0, DateCalculations.daysSince(date: today, to: projectionDate))
        let projectedDaysOwned = daysOwnedToday + additionalDays
        return AmortisationCalculator.costPerDay(
            purchasePrice: purchasePrice,
            daysOwned: projectedDaysOwned
        )
    }

}
