//
//  SchemaVersions.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.
//

import SwiftData
import Models

enum SchemaV1: VersionedSchema {
    static let versionIdentifier = Schema.Version(1, 0, 0)

    static var models: [any PersistentModel.Type] {
        [ItemEntity.self, TagEntity.self, UserSettingsEntity.self]
    }
}
