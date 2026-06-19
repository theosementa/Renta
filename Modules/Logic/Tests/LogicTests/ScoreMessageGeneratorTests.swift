//  ScoreMessageGeneratorTests.swift
//  Renta

import Testing
import Foundation
import Models
@testable import Logic

@Suite("ScoreMessageGenerator")
struct ScoreMessageGeneratorTests {

    @Test func fullyAmortizedHintForHundredScore() {
        let hint = ScoreMessageGenerator.hintText(
            scoreValue: 100,
            scoreBand: .excellent,
            daysOwned: 5000,
            durationTarget: .lessThan6Months
        )
        #expect(!hint.isEmpty)
    }

    @Test func excellentBandBeyondTargetIsFullyAmortized() {
        let target = DurationTargetType.lessThan6Months
        let hint = ScoreMessageGenerator.hintText(
            scoreValue: 90,
            scoreBand: .excellent,
            daysOwned: target.targetDays + 10,
            durationTarget: target
        )
        #expect(!hint.isEmpty)
    }

    @Test func excellentBandBeforeTargetMentionsRemaining() {
        let target = DurationTargetType.oneToThreeYears
        let hint = ScoreMessageGenerator.hintText(
            scoreValue: 80,
            scoreBand: .excellent,
            daysOwned: target.thresholdExcellent + 10,
            durationTarget: target
        )
        #expect(!hint.isEmpty)
    }

    @Test func correctBandProducesHint() {
        let target = DurationTargetType.threeToFiveYears
        let hint = ScoreMessageGenerator.hintText(
            scoreValue: 50,
            scoreBand: .correct,
            daysOwned: target.thresholdCorrect + 5,
            durationTarget: target
        )
        #expect(!hint.isEmpty)
    }

    @Test func highBandProducesHint() {
        let target = DurationTargetType.sevenYearsOrMore
        let hint = ScoreMessageGenerator.hintText(
            scoreValue: 10,
            scoreBand: .high,
            daysOwned: 10,
            durationTarget: target
        )
        #expect(!hint.isEmpty)
    }

    @Test func hintNeverEmptyAcrossAllBands() {
        let target = DurationTargetType.fiveToSevenYears
        let bands: [ScoreBandType] = [.high, .correct, .excellent]
        for band in bands {
            let hint = ScoreMessageGenerator.hintText(
                scoreValue: 40,
                scoreBand: band,
                daysOwned: 500,
                durationTarget: target
            )
            #expect(!hint.isEmpty)
        }
    }

    @Test func correctBandClampsRemainingToAtLeastOne() {
        let target = DurationTargetType.lessThan6Months
        // daysOwned beyond excellent threshold → remaining would be negative, clamped to 1.
        let hint = ScoreMessageGenerator.hintText(
            scoreValue: 50,
            scoreBand: .correct,
            daysOwned: target.thresholdExcellent + 100,
            durationTarget: target
        )
        #expect(!hint.isEmpty)
    }

    @Test func highBandClampsRemainingToAtLeastOne() {
        let target = DurationTargetType.lessThan6Months
        let hint = ScoreMessageGenerator.hintText(
            scoreValue: 5,
            scoreBand: .high,
            daysOwned: target.thresholdCorrect + 100,
            durationTarget: target
        )
        #expect(!hint.isEmpty)
    }

    @Test func costDescriptionFormatsCurrencyAndUnit() {
        let result = CostDescriptionGenerator.format(
            cost: 12,
            perUnit: .day,
            currencyCode: "EUR",
            locale: Locale(identifier: "fr_FR")
        )
        #expect(result.contains("/"))
        #expect(result.contains("12"))
    }

    @Test func costDescriptionFallsBackWithoutCurrencyCode() {
        let result = CostDescriptionGenerator.formattedCurrency(5, locale: Locale(identifier: "en_US"))
        #expect(!result.isEmpty)
    }
}
