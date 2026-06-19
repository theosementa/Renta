//  ScoreCalculator.swift
//  Renta

import Foundation
import Models

public enum ScoreCalculator: Sendable {

    private enum Constants {
        static let minVisibleDays: Int = 8
        static let lowBandCeiling: Double = 33
        static let correctBandSpan: Double = 34
        static let excellentBandBase: Double = 67
        static let excellentBandSpan: Double = 33
    }

    // MARK: - Public methods
    public static func scoreValue(daysOwned: Int, durationTarget: DurationTargetType) -> Int {
        scoreValue(
            daysOwned: daysOwned,
            thresholdCorrect: durationTarget.thresholdCorrect,
            thresholdExcellent: durationTarget.thresholdExcellent,
            targetDays: durationTarget.targetDays
        )
    }

    public static func scoreValue(
        daysOwned: Int,
        thresholdCorrect: Int,
        thresholdExcellent: Int,
        targetDays: Int
    ) -> Int {
        guard daysOwned >= Constants.minVisibleDays else { return 0 }

        let d = Double(daysOwned)
        let tc = Double(thresholdCorrect)
        let te = Double(thresholdExcellent)
        let td = Double(targetDays)

        let raw: Double
        if d < tc {
            raw = (d / tc) * Constants.lowBandCeiling
        } else if d < te {
            raw = Constants.lowBandCeiling + ((d - tc) / (te - tc)) * Constants.correctBandSpan
        } else {
            raw = Constants.excellentBandBase
                + min((d - te) / (td - te) * Constants.excellentBandSpan, Constants.excellentBandSpan)
        }

        return min(max(Int(raw), 0), 100)
    }

    public static func isScoreVisible(daysOwned: Int) -> Bool {
        daysOwned >= Constants.minVisibleDays
    }

    public static func scoreBand(daysOwned: Int, durationTarget: DurationTargetType) -> ScoreBandType {
        ScoreBandType(scoreValue: scoreValue(daysOwned: daysOwned, durationTarget: durationTarget))
    }

}
