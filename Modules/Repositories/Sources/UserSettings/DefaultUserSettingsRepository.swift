//  DefaultUserSettingsRepository.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import SwiftData
import Persistence
import Models

@MainActor
public final class DefaultUserSettingsRepository: GenericRepository<UserSettingsEntity>, UserSettingsRepository {

    public override init(manager: SwiftDataContextManager = .shared) {
        super.init(manager: manager)
    }

}

// MARK: - UserSettingsRepository
public extension DefaultUserSettingsRepository {

    func fetch() throws -> UserSettingsDomain {
        let entity = try fetchOrCreateEntity()
        return entity.toDomain()
    }

    func save(_ domain: UserSettingsDomain) throws {
        let entity = try fetchOrCreateEntity()
        entity.monthlyNetSalary = domain.monthlyNetSalary
        entity.weeklyHours = domain.weeklyHours
        entity.hasCompletedOnboarding = domain.hasCompletedOnboarding
        try context.save()
    }

}

// MARK: - Private methods
private extension DefaultUserSettingsRepository {

    func fetchOrCreateEntity() throws -> UserSettingsEntity {
        let settingsID = UUID.userSettingsID
        let descriptor = FetchDescriptor<UserSettingsEntity>(
            predicate: #Predicate { $0.id == settingsID }
        )
        if let existing = try context.fetch(descriptor).first {
            return existing
        }
        let entity = UserSettingsEntity()
        context.insert(entity)
        try context.save()
        return entity
    }

}
