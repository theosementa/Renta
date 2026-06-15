import Foundation

public enum ScoreBandType: Sendable {
    case high       // 0–33
    case correct    // 34–66
    case excellent  // 67–100

    public init(scoreValue: Int) {
        switch scoreValue {
        case 0..<34:  self = .high
        case 34..<67: self = .correct
        default:      self = .excellent
        }
    }
}
