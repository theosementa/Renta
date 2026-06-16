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

// MARK: - Computed variables
extension ItemModelDomain {
    public var daysOwned: Int {
        Calendar.current.dateComponents([.day], from: purchaseDate, to: .now).day ?? 0
    }

    public var costPerDay: Double {
        daysOwned > 0 ? purchasePrice / Double(daysOwned) : purchasePrice
    }

    public var costPerMonth: Double { costPerDay * 30.44 }
    public var costPerYear: Double { costPerDay * 365 }
    public var totalAmortized: Double { costPerDay * Double(daysOwned) }

    public var scoreValue: Int { durationTarget.scoreValue(daysOwned: daysOwned) }
    public var scoreBand: ScoreBandType { ScoreBandType(scoreValue: scoreValue) }
    public var isScoreVisible: Bool { daysOwned >= 8 }

    public var netCost: Double? { salePrice.map { purchasePrice - $0 } }
    public var netCostPerDay: Double? { netCost.map { $0 / max(Double(daysOwned), 1) } }
    public var recoveryRate: Double? { salePrice.map { ($0 / purchasePrice) * 100 } }

    public var ownedForDisplay: String {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: purchaseDate, to: .now)
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        if years > 0 {
            let yearStr = years == 1 ? "1 year" : "\(years) years"
            if months > 0 {
                let monthStr = months == 1 ? "1 month" : "\(months) months"
                return "\(yearStr) and \(monthStr)"
            }
            return yearStr
        }
        if months > 0 {
            let monthStr = months == 1 ? "1 month" : "\(months) months"
            if days > 0 {
                let dayStr = days == 1 ? "1 day" : "\(days) days"
                return "\(monthStr) and \(dayStr)"
            }
            return monthStr
        }
        return days <= 1 ? "Today" : "\(days) days"
    }

    public var subtitleDisplay: String {
        guard let firstTag = tags.first else { return ownedForDisplay }
        return "\(firstTag.name) • \(ownedForDisplay)"
    }

    public var hintText: String {
        if scoreValue >= 100 { return "Fully amortized 🎉" }
        switch scoreBand {
        case .excellent:
            let remaining = durationTarget.targetDays - daysOwned
            if remaining <= 0 { return "Fully amortized 🎉" }
            return "Target in \(formatDuration(remaining))"
        case .correct:
            let remaining = durationTarget.thresholdExcellent - daysOwned
            return "Excellent in \(formatDuration(max(remaining, 1)))"
        case .high:
            let remaining = durationTarget.thresholdCorrect - daysOwned
            return "Correct in \(formatDuration(max(remaining, 1)))"
        }
    }
}

// MARK: - Private helpers
extension ItemModelDomain {
    private func formatDuration(_ days: Int) -> String {
        if days < 31 {
            return days == 1 ? "1 day" : "\(days) days"
        } else if days < 365 {
            let months = (Double(days) / 30.44).rounded(.toNearestOrAwayFromZero)
            let m = Int(months)
            return m == 1 ? "1 month" : "\(m) months"
        } else {
            let years = (Double(days) / 365.0).rounded(.toNearestOrAwayFromZero)
            let y = Int(years)
            return y == 1 ? "1 year" : "\(y) years"
        }
    }
}
