//  AddObjectReducer.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

struct AddObjectReducer {

    @MainActor
    func reduce(state: AddObjectState, result: AddObjectResult) -> AddObjectState {
        var newState = state

        switch result {
        case .loading:
            newState.screenState = .loading

        case .submitted:
            newState.screenState = .success(())

        case .failed(let error):
            newState.screenState = .error(error)

        case .stepChanged(let step):
            newState.step = step

        case .nameChanged(let value):
            newState.name = value

        case .emojiChanged(let value):
            newState.emoji = value

        case .priceChanged(let value):
            newState.purchasePrice = value

        case .purchaseDateChanged(let value):
            newState.purchaseDate = value

        case .durationTargetChanged(let value):
            newState.durationTarget = value

        case .tagQueryChanged(let value):
            newState.tagQuery = value

        case .tagSuggestionsLoaded(let suggestions):
            newState.tagSuggestions = suggestions

        case .tagAdded(let tag):
            guard !newState.selectedTags.contains(where: { $0.id == tag.id }) else { break }
            newState.selectedTags.append(tag)

        case .tagRemoved(let id):
            newState.selectedTags.removeAll { $0.id == id }

        }

        return newState
    }

}
