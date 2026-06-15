import Foundation

public struct ItemModelUI: Identifiable, Sendable {
    public let id: UUID
    public let name: String
    public let emoji: String
    public let tagsDisplay: String
    public let costPerDayFormatted: String
    public let costPerMonthFormatted: String
    public let costPerYearFormatted: String
    public let totalAmortizedFormatted: String
    public let daysOwnedFormatted: String
    public let scoreValue: Int
    public let scoreBand: ScoreBandType
    public let isScoreVisible: Bool
    public let status: ItemStatusType
    public let netCostFormatted: String?
    public let netCostPerDayFormatted: String?
    public let recoveryRateFormatted: String?

    public init(
        id: UUID,
        name: String,
        emoji: String,
        tagsDisplay: String,
        costPerDayFormatted: String,
        costPerMonthFormatted: String,
        costPerYearFormatted: String,
        totalAmortizedFormatted: String,
        daysOwnedFormatted: String,
        scoreValue: Int,
        scoreBand: ScoreBandType,
        isScoreVisible: Bool,
        status: ItemStatusType,
        netCostFormatted: String? = nil,
        netCostPerDayFormatted: String? = nil,
        recoveryRateFormatted: String? = nil
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.tagsDisplay = tagsDisplay
        self.costPerDayFormatted = costPerDayFormatted
        self.costPerMonthFormatted = costPerMonthFormatted
        self.costPerYearFormatted = costPerYearFormatted
        self.totalAmortizedFormatted = totalAmortizedFormatted
        self.daysOwnedFormatted = daysOwnedFormatted
        self.scoreValue = scoreValue
        self.scoreBand = scoreBand
        self.isScoreVisible = isScoreVisible
        self.status = status
        self.netCostFormatted = netCostFormatted
        self.netCostPerDayFormatted = netCostPerDayFormatted
        self.recoveryRateFormatted = recoveryRateFormatted
    }
}
