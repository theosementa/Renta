//  AddObjectResult.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

enum AddObjectResult {
    case loading
    case submitted(ItemModelDomain)
    case failed(AppError)
    case stepChanged(AddObjectStep)
    case nameChanged(String)
    case emojiChanged(String)
    case priceChanged(Double)
    case purchaseDateChanged(Date)
    case durationTargetChanged(DurationTargetType)
    case tagQueryChanged(String)
    case tagSuggestionsLoaded([TagModelDomain])
    case tagAdded(TagModelDomain)
    case tagRemoved(UUID)
}
