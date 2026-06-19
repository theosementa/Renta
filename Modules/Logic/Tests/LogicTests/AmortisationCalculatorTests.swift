//  AmortisationCalculatorTests.swift
//  Renta

import Testing
import Foundation
@testable import Logic

@Suite("AmortisationCalculator")
struct AmortisationCalculatorTests {

    @Test func costPerDayDividesPriceByDays() {
        #expect(AmortisationCalculator.costPerDay(purchasePrice: 1000, daysOwned: 100) == 10)
    }

    @Test func costPerDayReturnsPriceWhenZeroDays() {
        #expect(AmortisationCalculator.costPerDay(purchasePrice: 1000, daysOwned: 0) == 1000)
    }

    @Test func costPerDayReturnsPriceWhenNegativeDays() {
        #expect(AmortisationCalculator.costPerDay(purchasePrice: 500, daysOwned: -5) == 500)
    }

    @Test func costPerMonthMultipliesByDaysPerMonth() {
        let perDay = AmortisationCalculator.costPerDay(purchasePrice: 1000, daysOwned: 100)
        #expect(AmortisationCalculator.costPerMonth(purchasePrice: 1000, daysOwned: 100) == perDay * 30.44)
    }

    @Test func costPerYearMultipliesByThreeSixtyFive() {
        #expect(AmortisationCalculator.costPerYear(purchasePrice: 365, daysOwned: 365) == 365)
    }

    @Test func totalAmortizedEqualsPriceWhenDaysPositive() {
        #expect(AmortisationCalculator.totalAmortized(purchasePrice: 1000, daysOwned: 100) == 1000)
    }

    @Test func totalAmortizedIsZeroWhenZeroDays() {
        #expect(AmortisationCalculator.totalAmortized(purchasePrice: 1000, daysOwned: 0) == 0)
    }

    @Test func costThisMonthIsCappedAtPurchasePrice() {
        let reference = Self.date(year: 2026, month: 1, day: 15)
        let cost = AmortisationCalculator.costThisMonth(
            purchasePrice: 100,
            daysOwned: 1000,
            reference: reference
        )
        #expect(cost <= 100)
    }

    @Test func costThisYearIsCappedAtPurchasePrice() {
        let reference = Self.date(year: 2026, month: 12, day: 31)
        let cost = AmortisationCalculator.costThisYear(
            purchasePrice: 100,
            daysOwned: 5000,
            reference: reference
        )
        #expect(cost <= 100)
    }

    @Test func costThisMonthUsesElapsedDaysWhenOwnedLonger() {
        let reference = Self.date(year: 2026, month: 1, day: 10)
        // day-of-month = 10, daysOwned huge → daysThisMonth == 10
        let cost = AmortisationCalculator.costThisMonth(
            purchasePrice: 3650,
            daysOwned: 365,
            reference: reference
        )
        // costPerDay = 10 → 10 * 10 = 100
        #expect(cost == 100)
    }

    @Test func metricsAggregatesAllFields() {
        let reference = Self.date(year: 2026, month: 6, day: 15)
        let metrics = AmortisationCalculator.metrics(
            purchasePrice: 1000,
            daysOwned: 100,
            reference: reference
        )
        #expect(metrics.daysOwned == 100)
        #expect(metrics.costPerDay == 10)
        #expect(metrics.totalAmortized == 1000)
    }

    @Test func daysOwnedCountsCalendarDays() {
        let start = Self.date(year: 2026, month: 1, day: 1)
        let end = Self.date(year: 2026, month: 1, day: 31)
        #expect(AmortisationCalculator.daysOwned(from: start, to: end) == 30)
    }

    // MARK: - Helpers
    private static func date(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = 12
        return Calendar.current.date(from: components) ?? .now
    }
}
