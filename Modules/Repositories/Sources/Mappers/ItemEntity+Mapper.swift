//  ItemEntity+Mapper.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

extension ItemEntity {
    func toDomain() -> ItemModelDomain {
        ItemModelDomain(
            id: id,
            name: name,
            emoji: emoji,
            purchasePrice: purchasePrice,
            purchaseDate: purchaseDate,
            durationTarget: DurationTargetType(rawValue: durationTargetRaw) ?? .oneToThreeYears,
            tags: tags?.map { $0.toDomain() } ?? [],
            excludeFromGlobal: excludeFromGlobal,
            status: ItemStatusType(rawValue: statusRaw) ?? .active,
            saleDate: saleDate,
            salePrice: salePrice,
            createdAt: createdAt
        )
    }
}
