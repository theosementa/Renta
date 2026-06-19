//  ScoreTransitionCalculator.swift
//  Renta

import Foundation
import Models

public enum ScoreTransitionCalculator: Sendable {

    // MARK: - Public methods
    public static func nextScoreBand(scoreBand: ScoreBandType) -> ScoreBandType? {
        switch scoreBand {
        case .excellent: return nil
        case .correct:   return .excellent
        case .high:      return .correct
        }
    }

    public static func daysUntilNextBand(
        scoreBand: ScoreBandType,
        daysOwned: Int,
        durationTarget: DurationTargetType
    ) -> Int {
        daysUntilNextBand(
            scoreBand: scoreBand,
            daysOwned: daysOwned,
            thresholdCorrect: durationTarget.thresholdCorrect,
            thresholdExcellent: durationTarget.thresholdExcellent
        )
    }

    public static func daysUntilNextBand(
        scoreBand: ScoreBandType,
        daysOwned: Int,
        thresholdCorrect: Int,
        thresholdExcellent: Int
    ) -> Int {
        switch scoreBand {
        case .excellent: return 0
        case .correct:   return max(1, thresholdExcellent - daysOwned)
        case .high:      return max(1, thresholdCorrect - daysOwned)
        }
    }

    public static func snapshot(
        daysOwned: Int,
        durationTarget: DurationTargetType
    ) -> ScoreSnapshot {
        let value = ScoreCalculator.scoreValue(daysOwned: daysOwned, durationTarget: durationTarget)
        let band = ScoreBandType(scoreValue: value)
        return ScoreSnapshot(
            scoreValue: value,
            scoreBand: band,
            isVisible: ScoreCalculator.isScoreVisible(daysOwned: daysOwned),
            nextBand: nextScoreBand(scoreBand: band),
            daysUntilNextBand: daysUntilNextBand(
                scoreBand: band,
                daysOwned: daysOwned,
                durationTarget: durationTarget
            )
        )
    }

}
