import Foundation
import SwiftData

@Model
public final class ItemEntity {
    public var id: UUID = UUID()
    public var name: String = ""
    public var emoji: String = "📦"
    public var purchasePrice: Double = 0.0
    public var purchaseDate: Date = Date()
    public var durationTargetRaw: String = DurationTargetType.oneToThreeYears.rawValue
    @Relationship(deleteRule: .nullify, inverse: \TagEntity.items) public var tags: [TagEntity]? = []
    public var excludeFromGlobal: Bool = false
    public var statusRaw: String = ItemStatusType.active.rawValue
    public var saleDate: Date? = nil
    public var salePrice: Double? = nil
    public var createdAt: Date = Date()
    public var updatedAt: Date = Date()

    public init(
        id: UUID = UUID(),
        name: String,
        emoji: String,
        purchasePrice: Double,
        purchaseDate: Date,
        durationTarget: DurationTargetType,
        tags: [TagEntity] = [],
        excludeFromGlobal: Bool = false,
        status: ItemStatusType = .active,
        saleDate: Date? = nil,
        salePrice: Double? = nil
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.purchasePrice = purchasePrice
        self.purchaseDate = purchaseDate
        self.durationTargetRaw = durationTarget.rawValue
        self.tags = tags
        self.excludeFromGlobal = excludeFromGlobal
        self.statusRaw = status.rawValue
        self.saleDate = saleDate
        self.salePrice = salePrice
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
