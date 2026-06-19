//  ScoreCalculatorTests.swift
//  Renta

import Testing
import Foundation
import Models
@testable import Logic

@Suite("ScoreCalculator")
struct ScoreCalculatorTests {

    @Test func scoreIsZeroBelowVisibilityThreshold() {
        #expect(ScoreCalculator.scoreValue(daysOwned: 7, durationTarget: .oneToThreeYears) == 0)
    }

    @Test func scoreIsZeroAtZeroDays() {
        #expect(ScoreCalculator.scoreValue(daysOwned: 0, durationTarget: .lessThan6Months) == 0)
    }

    @Test func scoreVisibleFromEightDays() {
        #expect(ScoreCalculator.isScoreVisible(daysOwned: 8))
        #expect(!ScoreCalculator.isScoreVisible(daysOwned: 7))
    }

    @Test func scoreIsClampedAtHundred() {
        let target = DurationTargetType.lessThan6Months
        let score = ScoreCalculator.scoreValue(daysOwned: 10000, durationTarget: target)
        #expect(score == 100)
    }

    @Test func lowBandStaysBelowThirtyFour() {
        let target = DurationTargetType.oneToThreeYears
        let score = ScoreCalculator.scoreValue(daysOwned: target.thresholdCorrect - 1, durationTarget: target)
        #expect(score < 34)
    }

    @Test func correctBandAtLowerBoundary() {
        let target = DurationTargetType.oneToThreeYears
        let score = ScoreCalculator.scoreValue(daysOwned: target.thresholdCorrect, durationTarget: target)
        #expect(score >= 33)
        #expect(score < 67)
    }

    @Test func excellentBandAtThreshold() {
        let target = DurationTargetType.oneToThreeYears
        let score = ScoreCalculator.scoreValue(daysOwned: target.thresholdExcellent, durationTarget: target)
        #expect(score >= 67)
    }

    @Test func scoreIsMonotonicAcrossDays() {
        let target = DurationTargetType.threeToFiveYears
        var previous = 0
        for days in stride(from: 8, through: target.targetDays, by: 30) {
            let score = ScoreCalculator.scoreValue(daysOwned: days, durationTarget: target)
            #expect(score >= previous)
            previous = score
        }
    }

    @Test func scoreBandMatchesScoreValue() {
        let target = DurationTargetType.sevenYearsOrMore
        let band = ScoreCalculator.scoreBand(daysOwned: 10, durationTarget: target)
        #expect(band == .high)
    }

    @Test func primitiveAndDomainOverloadsAgree() {
        let target = DurationTargetType.fiveToSevenYears
        let viaDomain = ScoreCalculator.scoreValue(daysOwned: 500, durationTarget: target)
        let viaPrimitives = ScoreCalculator.scoreValue(
            daysOwned: 500,
            thresholdCorrect: target.thresholdCorrect,
            thresholdExcellent: target.thresholdExcellent,
            targetDays: target.targetDays
        )
        #expect(viaDomain == viaPrimitives)
    }

    @Test func scoreNeverNegative() {
        for target in DurationTargetType.allCases {
            for days in [8, 50, 200, 1000] {
                #expect(ScoreCalculator.scoreValue(daysOwned: days, durationTarget: target) >= 0)
            }
        }
    }
}
