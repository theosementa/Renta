//  ItemRepository.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

@MainActor
public protocol ItemRepository {
    func fetchAll() throws -> [ItemModelDomain]
    func fetchActive() throws -> [ItemModelDomain]
    func add(
        name: String,
        emoji: String,
        purchasePrice: Double,
        purchaseDate: Date,
        durationTarget: DurationTargetType,
        excludeFromGlobal: Bool
    ) throws -> ItemModelDomain
    func update(_ domain: ItemModelDomain) throws
    func delete(id: UUID) throws
    func deleteAll() throws
}
