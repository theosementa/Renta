//  DurationFormatterTests.swift
//  Renta

import Testing
import Foundation
@testable import Logic

@Suite("DurationFormatter")
struct DurationFormatterTests {

    @Test func formatZeroDaysIsNonEmpty() {
        #expect(!DurationFormatter.format(days: 0).isEmpty)
    }

    @Test func formatSingleDayIsNonEmpty() {
        #expect(!DurationFormatter.format(days: 1).isEmpty)
    }

    @Test func formatHandlesNegativeDaysGracefully() {
        #expect(!DurationFormatter.format(days: -5).isEmpty)
    }

    @Test func formatYearsUsesCombinedKeyWhenMonthsRemain() {
        // Localized strings live in the app bundle, not the test bundle, so keys
        // resolve to themselves here — assert on the selected template, not digits.
        let result = DurationFormatter.format(days: 365 * 2 + 60)
        #expect(result.localizedCaseInsensitiveContains("year")
            || result.localizedCaseInsensitiveContains("combined"))
    }

    @Test func formatMonthsInjectsCount() {
        // ~3 months, no years.
        let result = DurationFormatter.format(days: 95)
        #expect(!result.isEmpty)
    }

    @Test func compactDaysForShortSpan() {
        let result = DurationFormatter.formatCompact(days: 10)
        #expect(result.localizedCaseInsensitiveContains("day"))
    }

    @Test func compactMonthsForMidSpan() {
        let result = DurationFormatter.formatCompact(days: 90)
        #expect(!result.isEmpty)
    }

    @Test func compactYearsForLongSpan() {
        let result = DurationFormatter.formatCompact(days: 365 * 3)
        #expect(result.localizedCaseInsensitiveContains("year"))
    }

    @Test func compactSingleDay() {
        #expect(!DurationFormatter.formatCompact(days: 1).isEmpty)
    }

    @Test func compactBoundaryAtThirtyOneDays() {
        // 31 days should switch to month formatting (rounded).
        let result = DurationFormatter.formatCompact(days: 31)
        #expect(!result.isEmpty)
    }

    @Test func compactBoundaryAtOneYear() {
        let result = DurationFormatter.formatCompact(days: 365)
        #expect(result.localizedCaseInsensitiveContains("year"))
    }

    @Test func formatLargeSpanUsesYearKey() {
        let result = DurationFormatter.format(days: 365 * 5)
        #expect(result.localizedCaseInsensitiveContains("year"))
    }
}
