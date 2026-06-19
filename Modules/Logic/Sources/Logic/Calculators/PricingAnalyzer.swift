//  PricingAnalyzer.swift
//  Renta

import Foundation

public enum PricingAnalyzer: Sendable {

    // MARK: - Public methods
    public static func netCost(purchasePrice: Double, salePrice: Double?) -> Double? {
        salePrice.map { purchasePrice - $0 }
    }

    public static func netCostPerDay(
        purchasePrice: Double,
        salePrice: Double?,
        daysOwned: Int
    ) -> Double? {
        netCost(purchasePrice: purchasePrice, salePrice: salePrice)
            .map { $0 / max(Double(daysOwned), 1) }
    }

    public static func recoveryRate(purchasePrice: Double, salePrice: Double?) -> Double? {
        guard purchasePrice != 0 else { return nil }
        return salePrice.map { ($0 / purchasePrice) * 100 }
    }

    public static func snapshot(
        purchasePrice: Double,
        salePrice: Double?,
        daysOwned: Int
    ) -> PricingSnapshot {
        PricingSnapshot(
            netCost: netCost(purchasePrice: purchasePrice, salePrice: salePrice),
            netCostPerDay: netCostPerDay(
                purchasePrice: purchasePrice,
                salePrice: salePrice,
                daysOwned: daysOwned
            ),
            recoveryRate: recoveryRate(purchasePrice: purchasePrice, salePrice: salePrice)
        )
    }

}
