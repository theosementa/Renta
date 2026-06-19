import SwiftUI
import Models

public extension ScoreBandType {
    var color: Color {
        switch self {
        case .high:      return Color.Status.high
        case .correct:   return Color.Status.correct
        case .excellent: return Color.Status.excellent
        }
    }

    var label: String {
        switch self {
        case .high:      return "common.scoreBand.high".localized
        case .correct:   return "common.scoreBand.correct".localized
        case .excellent: return "common.scoreBand.excellent".localized
        }
    }
}
