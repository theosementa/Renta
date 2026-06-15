//  MockTagRepository.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

@MainActor
public final class MockTagRepository: TagRepository {

    public var tags: [TagModelDomain] = []

    public init(tags: [TagModelDomain] = []) {
        self.tags = tags
    }

}

// MARK: - TagRepository
public extension MockTagRepository {

    func fetchAll() throws -> [TagModelDomain] {
        tags
    }

    func add(name: String) throws -> TagModelDomain {
        let domain = TagModelDomain(id: UUID(), name: name)
        tags.append(domain)
        return domain
    }

    func delete(id: UUID) throws {
        tags.removeAll { $0.id == id }
    }

    func deleteAll() throws {
        tags = []
    }

}
