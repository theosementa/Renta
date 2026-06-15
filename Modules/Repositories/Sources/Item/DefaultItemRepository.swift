//  DefaultItemRepository.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import SwiftData
import Persistence
import Models

@MainActor
public final class DefaultItemRepository: GenericRepository<ItemEntity>, ItemRepository {

    public override init(manager: SwiftDataContextManager = .shared) {
        super.init(manager: manager)
    }

}

// MARK: - ItemRepository
public extension DefaultItemRepository {

    func fetchAll() throws -> [ItemModelDomain] {
        try context.fetch(FetchDescriptor<ItemEntity>()).map { $0.toDomain() }
    }

    func fetchActive() throws -> [ItemModelDomain] {
        let activeRaw = ItemStatusType.active.rawValue
        let descriptor = FetchDescriptor<ItemEntity>(
            predicate: #Predicate { $0.statusRaw == activeRaw }
        )
        return try context.fetch(descriptor).map { $0.toDomain() }
    }

    func add(
        name: String,
        emoji: String,
        purchasePrice: Double,
        purchaseDate: Date,
        durationTarget: DurationTargetType,
        excludeFromGlobal: Bool
    ) throws -> ItemModelDomain {
        let entity = ItemEntity(
            name: name,
            emoji: emoji,
            purchasePrice: purchasePrice,
            purchaseDate: purchaseDate,
            durationTarget: durationTarget,
            excludeFromGlobal: excludeFromGlobal
        )
        context.insert(entity)
        try context.save()
        return entity.toDomain()
    }

    func update(_ domain: ItemModelDomain) throws {
        let domainID = domain.id
        let descriptor = FetchDescriptor<ItemEntity>(
            predicate: #Predicate { $0.id == domainID }
        )
        guard let entity = try context.fetch(descriptor).first else { return }
        entity.name = domain.name
        entity.emoji = domain.emoji
        entity.purchasePrice = domain.purchasePrice
        entity.purchaseDate = domain.purchaseDate
        entity.durationTargetRaw = domain.durationTarget.rawValue
        entity.excludeFromGlobal = domain.excludeFromGlobal
        entity.statusRaw = domain.status.rawValue
        entity.saleDate = domain.saleDate
        entity.salePrice = domain.salePrice
        entity.updatedAt = Date()
        try context.save()
    }

    func delete(id: UUID) throws {
        let descriptor = FetchDescriptor<ItemEntity>(
            predicate: #Predicate { $0.id == id }
        )
        guard let entity = try context.fetch(descriptor).first else { return }
        context.delete(entity)
        try context.save()
    }

}
