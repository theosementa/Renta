//  MockItemRepository.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

@MainActor
public final class MockItemRepository: ItemRepository {

    public var items: [ItemModelDomain] = []

    public init(items: [ItemModelDomain] = []) {
        self.items = items
    }

}

// MARK: - ItemRepository
public extension MockItemRepository {

    func fetchAll() throws -> [ItemModelDomain] {
        items
    }

    func fetchActive() throws -> [ItemModelDomain] {
        items.filter { $0.status == .active }
    }

    func add(
        name: String,
        emoji: String,
        purchasePrice: Double,
        purchaseDate: Date,
        durationTarget: DurationTargetType,
        excludeFromGlobal: Bool
    ) throws -> ItemModelDomain {
        let domain = ItemModelDomain(
            id: UUID(),
            name: name,
            emoji: emoji,
            purchasePrice: purchasePrice,
            purchaseDate: purchaseDate,
            durationTarget: durationTarget,
            excludeFromGlobal: excludeFromGlobal
        )
        items.append(domain)
        return domain
    }

    func update(_ domain: ItemModelDomain) throws {
        guard let index = items.firstIndex(where: { $0.id == domain.id }) else { return }
        items[index] = domain
    }

    func delete(id: UUID) throws {
        items.removeAll { $0.id == id }
    }

    func deleteAll() throws {
        items = []
    }

}
