//  ItemDataSource.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Repositories
import Models

@Observable @MainActor
public final class ItemDataSource {

    public private(set) var items: [ItemModelDomain] = []

    private let repository: ItemRepository
    private let proStatusDataSource: ProStatusDataSource

    public init(
        repository: ItemRepository = DefaultItemRepository(),
        proStatusDataSource: ProStatusDataSource = ProStatusDataSource.shared
    ) {
        self.repository = repository
        self.proStatusDataSource = proStatusDataSource
    }

}

// MARK: - Public methods
public extension ItemDataSource {

    func fetchItems() async throws {
        items = try repository.fetchActive()
    }

    func add(
        name: String,
        emoji: String,
        purchasePrice: Double,
        purchaseDate: Date,
        durationTarget: DurationTargetType,
        excludeFromGlobal: Bool = false
    ) async throws -> ItemModelDomain {
        if !proStatusDataSource.isPro && items.count >= 10 {
            throw AppError.freeTierLimit
        }
        let domain = try repository.add(
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

    func update(_ domain: ItemModelDomain) async throws {
        try repository.update(domain)
        if let index = items.firstIndex(where: { $0.id == domain.id }) {
            items[index] = domain
        }
    }

    func delete(id: UUID) async throws {
        try repository.delete(id: id)
        items.removeAll { $0.id == id }
    }

    func invalidateCache() {
        items = []
    }

}
