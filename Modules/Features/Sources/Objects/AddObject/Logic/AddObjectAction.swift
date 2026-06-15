//  AddObjectAction.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

enum AddObjectAction {
    case loadTags
    case submit(
        name: String,
        emoji: String,
        purchasePrice: Double,
        purchaseDate: Date,
        durationTarget: DurationTargetType,
        tags: [TagModelDomain],
        excludeFromGlobal: Bool
    )
}
