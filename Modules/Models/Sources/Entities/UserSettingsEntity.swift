import Foundation
import SwiftData

public extension UUID {
    static let userSettingsID = UUID(uuidString: "00000000-0000-0000-0000-000000000001")!
}

@Model
public final class UserSettingsEntity {
    public var id: UUID = UUID.userSettingsID
    public var monthlyNetSalary: Double? = nil
    public var weeklyHours: Double? = nil
    public var hasCompletedOnboarding: Bool = false
    public var hasPurchasedPro: Bool = false

    public init() {}
}
