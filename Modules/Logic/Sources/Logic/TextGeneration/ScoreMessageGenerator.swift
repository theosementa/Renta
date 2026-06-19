//  ScoreMessageGenerator.swift
//  Renta

import Foundation
import Models

public enum ScoreMessageGenerator: Sendable {

    private enum Constants {
        static let fullyAmortizedScore: Int = 100
    }

    // MARK: - Public methods

    /// Localized hint shown under an item's score.
    /// Mirrors `ItemModelDomain.hintText`: a fully amortized item, or the time
    /// remaining until the next score band.
    public static func hintText(
        scoreValue: Int,
        scoreBand: ScoreBandType,
        daysOwned: Int,
        durationTarget: DurationTargetType
    ) -> String {
        if scoreValue >= Constants.fullyAmortizedScore {
            return localized("item.hint.fullyAmortized")
        }

        switch scoreBand {
        case .excellent:
            let remaining = durationTarget.targetDays - daysOwned
            guard remaining > 0 else { return localized("item.hint.fullyAmortized") }
            return format("item.hint.targetIn", DurationFormatter.formatCompact(days: remaining))

        case .correct:
            let remaining = max(durationTarget.thresholdExcellent - daysOwned, 1)
            return format("item.hint.excellentIn", DurationFormatter.formatCompact(days: remaining))

        case .high:
            let remaining = max(durationTarget.thresholdCorrect - daysOwned, 1)
            return format("item.hint.correctIn", DurationFormatter.formatCompact(days: remaining))
        }
    }

    // MARK: - Private methods

    private static func format(_ key: String, _ argument: String) -> String {
        String(format: localized(key), argument)
    }

    private static func localized(_ key: String) -> String {
        NSLocalizedString(key, bundle: .main, comment: "")
    }

}
