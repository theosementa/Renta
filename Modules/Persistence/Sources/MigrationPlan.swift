//
//  MigrationPlan.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.
//

import SwiftData

enum RentaMigrationPlan: SchemaMigrationPlan {
    // Ordered oldest → newest
    static var schemas: [any VersionedSchema.Type] {
        [SchemaV1.self]
    }

    static var stages: [MigrationStage] {
        []
    }
}
