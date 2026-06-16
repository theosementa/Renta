//  UserSettingsDataSource.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import Foundation
import Repositories
import Models

@Observable @MainActor
public final class UserSettingsDataSource {
    public static let shared = UserSettingsDataSource()

    public private(set) var settings: UserSettingsDomain = .init()
    private let repository: UserSettingsRepository

    public init(repository: UserSettingsRepository = DefaultUserSettingsRepository()) {
        self.repository = repository
        try? load()
    }
}

// MARK: - Public methods
public extension UserSettingsDataSource {

    func load() throws {
        settings = try repository.fetch()
    }

    func updateBrandColor(_ color: BrandColorType) throws {
        let updated = UserSettingsDomain(
            monthlyNetSalary: settings.monthlyNetSalary,
            weeklyHours: settings.weeklyHours,
            hasCompletedOnboarding: settings.hasCompletedOnboarding,
            brandColor: color
        )
        try repository.save(updated)
        settings = updated
    }

}
