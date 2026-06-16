import Foundation

public struct UserSettingsDomain: Sendable {
    public let monthlyNetSalary: Double?
    public let weeklyHours: Double?
    public let hasCompletedOnboarding: Bool
    public let brandColor: BrandColorType

    public init(
        monthlyNetSalary: Double? = nil,
        weeklyHours: Double? = nil,
        hasCompletedOnboarding: Bool = false,
        brandColor: BrandColorType = .green
    ) {
        self.monthlyNetSalary = monthlyNetSalary
        self.weeklyHours = weeklyHours
        self.hasCompletedOnboarding = hasCompletedOnboarding
        self.brandColor = brandColor
    }
}

// MARK: - Computed variables
extension UserSettingsDomain {
    public var hourlyRate: Double? {
        guard let salary = monthlyNetSalary, let hours = weeklyHours, hours > 0 else { return nil }
        return salary / (hours * 52 / 12)
    }

    public var dailySalary: Double? {
        guard let rate = hourlyRate, let hours = weeklyHours, hours > 0 else { return nil }
        return rate * (hours / 5)
    }

    public func workMinutes(forCostPerDay cost: Double) -> Double? {
        guard let rate = hourlyRate else { return nil }
        return (cost / rate) * 60
    }
}
