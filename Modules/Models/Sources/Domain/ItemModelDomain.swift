import Foundation

public struct ItemModelDomain: Identifiable, Equatable, Sendable {
    public let id: UUID
    public let name: String
    public let emoji: String
    public let purchasePrice: Double
    public let purchaseDate: Date
    public let durationTarget: DurationTargetType
    public let tags: [TagModelDomain]
    public let excludeFromGlobal: Bool
    public let status: ItemStatusType
    public let saleDate: Date?
    public let salePrice: Double?
    public let createdAt: Date

    public init(
        id: UUID = UUID(),
        name: String,
        emoji: String,
        purchasePrice: Double,
        purchaseDate: Date,
        durationTarget: DurationTargetType,
        tags: [TagModelDomain] = [],
        excludeFromGlobal: Bool = false,
        status: ItemStatusType = .active,
        saleDate: Date? = nil,
        salePrice: Double? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.purchasePrice = purchasePrice
        self.purchaseDate = purchaseDate
        self.durationTarget = durationTarget
        self.tags = tags
        self.excludeFromGlobal = excludeFromGlobal
        self.status = status
        self.saleDate = saleDate
        self.salePrice = salePrice
        self.createdAt = createdAt
    }
}
