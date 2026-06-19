//  AddObjectState.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Logic
import Models

@MainActor
public struct AddObjectState: Sendable {
    public var screenState: ScreenState<Void> = .success(())
    public var step: AddObjectStep = .nameEmoji
    public var name: String = ""
    public var emoji: String = "📦"
    public var purchasePrice: Double = 0.0
    public var purchaseDate: Date = .now
    public var durationTarget: DurationTargetType = .oneToThreeYears
    public var tagQuery: String = ""
    public var tagSuggestions: [TagModelDomain] = []
    public var selectedTags: [TagModelDomain] = []

    public init() {}
}

// MARK: - Computed variables
public extension AddObjectState {

    var isLoading: Bool {
        if case .loading = screenState { return true }
        return false
    }

    var errorMessage: String? {
        guard case .error(let error) = screenState else { return nil }
        return error.localizedDescription
    }

    var canProceedFromNameEmoji: Bool {
        !name.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var canProceedFromDetails: Bool {
        purchasePrice > 0
    }

    var progress: Double {
        Double(step.rawValue + 1) / Double(AddObjectStep.allCases.count)
    }

    var tagsDisplay: String {
        selectedTags.map(\.name).joined(separator: ", ")
    }

    var daysSinceOwned: Int {
        max(1, Calendar.current.dateComponents([.day], from: purchaseDate, to: .now).day ?? 1)
    }

    var costPerDay: Double {
        AmortisationCalculator.costPerDay(purchasePrice: purchasePrice, daysOwned: daysSinceOwned)
    }
    var costPerMonth: Double {
        AmortisationCalculator.costPerMonth(purchasePrice: purchasePrice, daysOwned: daysSinceOwned)
    }
    var costPerYear: Double {
        AmortisationCalculator.costPerYear(purchasePrice: purchasePrice, daysOwned: daysSinceOwned)
    }

    var scoreValue: Int {
        ScoreCalculator.scoreValue(daysOwned: daysSinceOwned, durationTarget: durationTarget)
    }
    var scoreBand: ScoreBandType {
        ScoreBandType(scoreValue: scoreValue)
    }

    var showCostPerDay: Bool { purchasePrice > costPerDay }
    var showCostPerMonth: Bool { purchasePrice > costPerMonth }
    var showCostPerYear: Bool { purchasePrice > costPerYear }
    var hasCostPreview: Bool { showCostPerDay || showCostPerMonth || showCostPerYear }

}
