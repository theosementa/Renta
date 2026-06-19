//  PricingAnalyzerTests.swift
//  Renta

import Testing
import Foundation
@testable import Logic

@Suite("PricingAnalyzer")
struct PricingAnalyzerTests {

    @Test func netCostIsNilWithoutSalePrice() {
        #expect(PricingAnalyzer.netCost(purchasePrice: 1000, salePrice: nil) == nil)
    }

    @Test func netCostIsPriceMinusSale() {
        #expect(PricingAnalyzer.netCost(purchasePrice: 1000, salePrice: 600) == 400)
    }

    @Test func netCostCanBeNegativeWhenSoldHigher() {
        #expect(PricingAnalyzer.netCost(purchasePrice: 1000, salePrice: 1200) == -200)
    }

    @Test func netCostPerDayIsNilWithoutSalePrice() {
        #expect(PricingAnalyzer.netCostPerDay(purchasePrice: 1000, salePrice: nil, daysOwned: 100) == nil)
    }

    @Test func netCostPerDayDividesByDays() {
        let value = PricingAnalyzer.netCostPerDay(purchasePrice: 1000, salePrice: 600, daysOwned: 100)
        #expect(value == 4)
    }

    @Test func netCostPerDayGuardsAgainstZeroDays() {
        let value = PricingAnalyzer.netCostPerDay(purchasePrice: 1000, salePrice: 600, daysOwned: 0)
        #expect(value == 400)
    }

    @Test func netCostPerDayGuardsAgainstNegativeDays() {
        let value = PricingAnalyzer.netCostPerDay(purchasePrice: 1000, salePrice: 600, daysOwned: -10)
        #expect(value == 400)
    }

    @Test func recoveryRateIsNilWithoutSalePrice() {
        #expect(PricingAnalyzer.recoveryRate(purchasePrice: 1000, salePrice: nil) == nil)
    }

    @Test func recoveryRateIsPercentage() {
        #expect(PricingAnalyzer.recoveryRate(purchasePrice: 1000, salePrice: 750) == 75)
    }

    @Test func recoveryRateIsNilWhenPurchasePriceZero() {
        #expect(PricingAnalyzer.recoveryRate(purchasePrice: 0, salePrice: 100) == nil)
    }

    @Test func snapshotAggregatesAllFields() {
        let snapshot = PricingAnalyzer.snapshot(purchasePrice: 1000, salePrice: 600, daysOwned: 100)
        #expect(snapshot.netCost == 400)
        #expect(snapshot.netCostPerDay == 4)
        #expect(snapshot.recoveryRate == 60)
    }

    @Test func snapshotAllNilWithoutSale() {
        let snapshot = PricingAnalyzer.snapshot(purchasePrice: 1000, salePrice: nil, daysOwned: 100)
        #expect(snapshot.netCost == nil)
        #expect(snapshot.netCostPerDay == nil)
        #expect(snapshot.recoveryRate == nil)
    }
}
