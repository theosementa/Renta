//  DefaultTagRepository.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import SwiftData
import Persistence
import Models

@MainActor
public final class DefaultTagRepository: GenericRepository<TagEntity>, TagRepository {

    public override init(manager: SwiftDataContextManager = .shared) {
        super.init(manager: manager)
    }

}

// MARK: - TagRepository
public extension DefaultTagRepository {

    func fetchAll() throws -> [TagModelDomain] {
        try context.fetch(FetchDescriptor<TagEntity>()).map { $0.toDomain() }
    }

    func add(name: String) throws -> TagModelDomain {
        let entity = TagEntity(name: name)
        context.insert(entity)
        try context.save()
        return entity.toDomain()
    }

    func delete(id: UUID) throws {
        let descriptor = FetchDescriptor<TagEntity>(
            predicate: #Predicate { $0.id == id }
        )
        guard let entity = try context.fetch(descriptor).first else { return }
        context.delete(entity)
        try context.save()
    }

}
