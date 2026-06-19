//  ProjectionCalculatorTests.swift
//  Renta

import Testing
import Foundation
@testable import Logic

@Suite("ProjectionCalculator")
struct ProjectionCalculatorTests {

    @Test func projectionAddsElapsedDays() {
        let today = Self.date(year: 2026, month: 1, day: 1)
        let oneYearLater = Self.date(year: 2027, month: 1, day: 1)
        let metrics = ProjectionCalculator.projectedAmortisation(
            purchasePrice: 3650,
            daysOwnedToday: 100,
            projectionDate: oneYearLater,
            today: today
        )
        // 100 today + 365 elapsed = 465 days owned
        #expect(metrics.daysOwned == 465)
    }

    @Test func projectionLowersCostPerDayOverTime() {
        let today = Self.date(year: 2026, month: 1, day: 1)
        let future = Self.date(year: 2027, month: 1, day: 1)
        let todayCost = AmortisationCalculator.costPerDay(purchasePrice: 3650, daysOwned: 100)
        let projected = ProjectionCalculator.projectedCostPerDay(
            purchasePrice: 3650,
            daysOwnedToday: 100,
            projectionDate: future,
            today: today
        )
        #expect(projected < todayCost)
    }

    @Test func pastProjectionDateDoesNotReduceOwnership() {
        let today = Self.date(year: 2026, month: 6, day: 1)
        let past = Self.date(year: 2026, month: 1, day: 1)
        let metrics = ProjectionCalculator.projectedAmortisation(
            purchasePrice: 1000,
            daysOwnedToday: 200,
            projectionDate: past,
            today: today
        )
        #expect(metrics.daysOwned == 200)
    }

    @Test func sameDayProjectionMatchesToday() {
        let today = Self.date(year: 2026, month: 6, day: 1)
        let metrics = ProjectionCalculator.projectedAmortisation(
            purchasePrice: 1000,
            daysOwnedToday: 100,
            projectionDate: today,
            today: today
        )
        #expect(metrics.daysOwned == 100)
        #expect(metrics.costPerDay == 10)
    }

    @Test func projectionTotalAmortizedEqualsPrice() {
        let today = Self.date(year: 2026, month: 1, day: 1)
        let future = Self.date(year: 2028, month: 1, day: 1)
        let metrics = ProjectionCalculator.projectedAmortisation(
            purchasePrice: 1000,
            daysOwnedToday: 50,
            projectionDate: future,
            today: today
        )
        #expect(abs(metrics.totalAmortized - 1000) < 0.0001)
    }

    @Test func costPerDayMonotonicallyDecreasesWithProjection() {
        let today = Self.date(year: 2026, month: 1, day: 1)
        let oneYear = Self.date(year: 2027, month: 1, day: 1)
        let twoYears = Self.date(year: 2028, month: 1, day: 1)
        let cost1 = ProjectionCalculator.projectedCostPerDay(
            purchasePrice: 1000, daysOwnedToday: 100, projectionDate: oneYear, today: today
        )
        let cost2 = ProjectionCalculator.projectedCostPerDay(
            purchasePrice: 1000, daysOwnedToday: 100, projectionDate: twoYears, today: today
        )
        #expect(cost2 < cost1)
    }

    @Test func zeroDaysTodayWithFutureProjectionIsPositive() {
        let today = Self.date(year: 2026, month: 1, day: 1)
        let future = Self.date(year: 2026, month: 4, day: 1)
        let cost = ProjectionCalculator.projectedCostPerDay(
            purchasePrice: 900, daysOwnedToday: 0, projectionDate: future, today: today
        )
        #expect(cost > 0)
        #expect(cost < 900)
    }

    @Test func projectedMetricsConsistentWithDirectMetrics() {
        let today = Self.date(year: 2026, month: 1, day: 1)
        let future = Self.date(year: 2027, month: 1, day: 1)
        let projected = ProjectionCalculator.projectedAmortisation(
            purchasePrice: 1000, daysOwnedToday: 100, projectionDate: future, today: today
        )
        let direct = AmortisationCalculator.metrics(
            purchasePrice: 1000, daysOwned: 465, reference: future
        )
        #expect(projected.costPerDay == direct.costPerDay)
    }

    @Test func longHorizonProjectionStaysFinite() {
        let today = Self.date(year: 2026, month: 1, day: 1)
        let farFuture = Self.date(year: 2046, month: 1, day: 1)
        let metrics = ProjectionCalculator.projectedAmortisation(
            purchasePrice: 1000, daysOwnedToday: 10, projectionDate: farFuture, today: today
        )
        #expect(metrics.daysOwned > 7000)
        #expect(metrics.costPerDay > 0)
    }

    @Test func projectionPreservesPurchasePriceCap() {
        let today = Self.date(year: 2026, month: 1, day: 1)
        let future = Self.date(year: 2030, month: 1, day: 1)
        let metrics = ProjectionCalculator.projectedAmortisation(
            purchasePrice: 500, daysOwnedToday: 10, projectionDate: future, today: today
        )
        #expect(metrics.costThisYear <= 500)
        #expect(metrics.costThisMonth <= 500)
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
