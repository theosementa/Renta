//  AddObjectState.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
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

    var ownedForDisplay: String {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: purchaseDate, to: .now)
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        if years > 0 {
            let yearStr = years == 1 ? "1 year" : "\(years) years"
            if months > 0 {
                let monthStr = months == 1 ? "1 month" : "\(months) months"
                return "\(yearStr) and \(monthStr)"
            }
            return yearStr
        }
        if months > 0 {
            let monthStr = months == 1 ? "1 month" : "\(months) months"
            if days > 0 {
                let dayStr = days == 1 ? "1 day" : "\(days) days"
                return "\(monthStr) and \(dayStr)"
            }
            return monthStr
        }
        return days <= 1 ? "Today" : "\(days) days"
    }

    var costPerDay: Double { purchasePrice / Double(daysSinceOwned) }
    var costPerMonth: Double { costPerDay * 30.44 }
    var costPerYear: Double { costPerDay * 365.25 }

    var scoreValue: Int { durationTarget.scoreValue(daysOwned: daysSinceOwned) }
    var scoreBand: ScoreBandType { ScoreBandType(scoreValue: scoreValue) }

    var showCostPerDay: Bool { purchasePrice > costPerDay }
    var showCostPerMonth: Bool { purchasePrice > costPerMonth }
    var showCostPerYear: Bool { purchasePrice > costPerYear }
    var hasCostPreview: Bool { showCostPerDay || showCostPerMonth || showCostPerYear }

}
