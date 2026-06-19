//  ScoreSnapshot.swift
//  Renta

import Foundation
import Models

public struct ScoreSnapshot: Equatable, Sendable {
    public let scoreValue: Int
    public let scoreBand: ScoreBandType
    public let isVisible: Bool
    public let nextBand: ScoreBandType?
    public let daysUntilNextBand: Int

    public init(
        scoreValue: Int,
        scoreBand: ScoreBandType,
        isVisible: Bool,
        nextBand: ScoreBandType?,
        daysUntilNextBand: Int
    ) {
        self.scoreValue = scoreValue
        self.scoreBand = scoreBand
        self.isVisible = isVisible
        self.nextBand = nextBand
        self.daysUntilNextBand = daysUntilNextBand
    }
}
