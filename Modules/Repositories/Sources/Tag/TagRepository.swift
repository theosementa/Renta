//  TagRepository.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

@MainActor
public protocol TagRepository {
    func fetchAll() throws -> [TagModelDomain]
    func add(name: String) throws -> TagModelDomain
    func delete(id: UUID) throws
    func deleteAll() throws
}
