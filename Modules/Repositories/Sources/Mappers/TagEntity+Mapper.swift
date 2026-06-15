//  TagEntity+Mapper.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

extension TagEntity {
    func toDomain() -> TagModelDomain {
        TagModelDomain(id: id, name: name)
    }
}
