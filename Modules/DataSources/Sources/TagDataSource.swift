//  TagDataSource.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Repositories
import Models

@Observable @MainActor
public final class TagDataSource {

    public private(set) var tags: [TagModelDomain] = []

    private let repository: TagRepository

    public init(repository: TagRepository = DefaultTagRepository()) {
        self.repository = repository
    }

}

// MARK: - Public methods
public extension TagDataSource {

    func fetchTags() async throws {
        tags = try repository.fetchAll()
    }

    @discardableResult
    func add(name: String) async throws -> TagModelDomain {
        if let existing = tags.first(where: { $0.name.lowercased() == name.lowercased() }) {
            return existing
        }
        let domain = try repository.add(name: name)
        tags.append(domain)
        return domain
    }

    func delete(id: UUID) async throws {
        try repository.delete(id: id)
        tags.removeAll { $0.id == id }
    }

    func suggestions(for query: String) -> [TagModelDomain] {
        if query.isEmpty {
            return Array(tags.prefix(5))
        }
        return tags
            .filter { $0.name.localizedCaseInsensitiveContains(query) }
            .prefix(5)
            .map { $0 }
    }

}
