//  ScoreTransitionCalculatorTests.swift
//  Renta

import Testing
import Foundation
import Models
@testable import Logic

@Suite("ScoreTransitionCalculator")
struct ScoreTransitionCalculatorTests {

    @Test func nextBandFromHighIsCorrect() {
        #expect(ScoreTransitionCalculator.nextScoreBand(scoreBand: .high) == .correct)
    }

    @Test func nextBandFromCorrectIsExcellent() {
        #expect(ScoreTransitionCalculator.nextScoreBand(scoreBand: .correct) == .excellent)
    }

    @Test func nextBandFromExcellentIsNil() {
        #expect(ScoreTransitionCalculator.nextScoreBand(scoreBand: .excellent) == nil)
    }

    @Test func daysUntilNextBandIsZeroAtExcellent() {
        let days = ScoreTransitionCalculator.daysUntilNextBand(
            scoreBand: .excellent,
            daysOwned: 50,
            durationTarget: .oneToThreeYears
        )
        #expect(days == 0)
    }

    @Test func daysUntilNextBandFromCorrectTargetsExcellentThreshold() {
        let target = DurationTargetType.oneToThreeYears
        let days = ScoreTransitionCalculator.daysUntilNextBand(
            scoreBand: .correct,
            daysOwned: target.thresholdCorrect,
            durationTarget: target
        )
        #expect(days == target.thresholdExcellent - target.thresholdCorrect)
    }

    @Test func daysUntilNextBandFromHighTargetsCorrectThreshold() {
        let target = DurationTargetType.threeToFiveYears
        let days = ScoreTransitionCalculator.daysUntilNextBand(
            scoreBand: .high,
            daysOwned: 10,
            durationTarget: target
        )
        #expect(days == target.thresholdCorrect - 10)
    }

    @Test func daysUntilNextBandNeverNegative() {
        let target = DurationTargetType.lessThan6Months
        let days = ScoreTransitionCalculator.daysUntilNextBand(
            scoreBand: .high,
            daysOwned: target.targetDays + 100,
            durationTarget: target
        )
        #expect(days == 0)
    }

    @Test func snapshotIsConsistentForEarlyOwnership() {
        let snapshot = ScoreTransitionCalculator.snapshot(
            daysOwned: 10,
            durationTarget: .sevenYearsOrMore
        )
        #expect(snapshot.scoreBand == .high)
        #expect(snapshot.nextBand == .correct)
        #expect(snapshot.isVisible)
        #expect(snapshot.daysUntilNextBand > 0)
    }

    @Test func snapshotNotVisibleBelowThreshold() {
        let snapshot = ScoreTransitionCalculator.snapshot(
            daysOwned: 3,
            durationTarget: .oneToThreeYears
        )
        #expect(!snapshot.isVisible)
        #expect(snapshot.scoreValue == 0)
    }

    @Test func snapshotExcellentHasNoNextBand() {
        let target = DurationTargetType.lessThan6Months
        let snapshot = ScoreTransitionCalculator.snapshot(
            daysOwned: target.targetDays,
            durationTarget: target
        )
        #expect(snapshot.scoreBand == .excellent)
        #expect(snapshot.nextBand == nil)
        #expect(snapshot.daysUntilNextBand == 0)
    }

    @Test func primitiveAndDomainOverloadsAgree() {
        let target = DurationTargetType.fiveToSevenYears
        let viaDomain = ScoreTransitionCalculator.daysUntilNextBand(
            scoreBand: .correct,
            daysOwned: 700,
            durationTarget: target
        )
        let viaPrimitives = ScoreTransitionCalculator.daysUntilNextBand(
            scoreBand: .correct,
            daysOwned: 700,
            thresholdCorrect: target.thresholdCorrect,
            thresholdExcellent: target.thresholdExcellent
        )
        #expect(viaDomain == viaPrimitives)
    }
}
