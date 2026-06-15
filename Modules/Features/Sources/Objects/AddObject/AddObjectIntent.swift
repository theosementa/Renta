//  AddObjectIntent.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

public enum AddObjectIntent {
    // Navigation between steps
    case nextStep
    case previousStep
    // Step 1 — NameEmoji
    case nameChanged(String)
    case emojiChanged(String)
    // Step 2 — Details
    case priceChanged(Double)
    case purchaseDateChanged(Date)
    case durationTargetChanged(DurationTargetType)
    // Step 3 — Tags
    case tagQueryChanged(String)
    case tagAdded(TagModelDomain)
    case tagRemoved(UUID)
    
    // Step 4 — Confirmation
    case excludeFromGlobalChanged(Bool)

    // Global actions
    case loadTags
    case submit
    case dismiss
}
