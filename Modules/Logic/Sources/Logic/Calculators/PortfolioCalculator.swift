//  PortfolioCalculator.swift
//  Renta

import Foundation
import Models

public enum PortfolioCalculator: Sendable {

    // MARK: - Public methods

    public static func totalCostPerDay(items: [ItemModelDomain]) -> Double {
        items.reduce(0) {
            $0 + AmortisationCalculator.costPerDay(
                purchasePrice: $1.purchasePrice,
                daysOwned: AmortisationCalculator.daysOwned(from: $1.purchaseDate)
            )
        }
    }

    public static func totalCostThisMonth(items: [ItemModelDomain]) -> Double {
        items.reduce(0) {
            $0 + AmortisationCalculator.costThisMonth(
                purchasePrice: $1.purchasePrice,
                daysOwned: AmortisationCalculator.daysOwned(from: $1.purchaseDate)
            )
        }
    }

    public static func totalCostThisYear(items: [ItemModelDomain]) -> Double {
        items.reduce(0) {
            $0 + AmortisationCalculator.costThisYear(
                purchasePrice: $1.purchasePrice,
                daysOwned: AmortisationCalculator.daysOwned(from: $1.purchaseDate)
            )
        }
    }

    public static func totalPurchaseValue(items: [ItemModelDomain]) -> Double {
        items.reduce(0) { $0 + $1.purchasePrice }
    }

}
