//  ItemModelDomain+Calculations.swift
//  Renta

import Foundation
import Logic
import Models

// MARK: - Amortisation
public extension ItemModelDomain {

    var daysOwned: Int {
        AmortisationCalculator.daysOwned(from: purchaseDate)
    }

    var costPerDay: Double {
        AmortisationCalculator.costPerDay(purchasePrice: purchasePrice, daysOwned: daysOwned)
    }

    var costPerMonth: Double {
        AmortisationCalculator.costPerMonth(purchasePrice: purchasePrice, daysOwned: daysOwned)
    }

    var costPerYear: Double {
        AmortisationCalculator.costPerYear(purchasePrice: purchasePrice, daysOwned: daysOwned)
    }

    var costThisMonth: Double {
        AmortisationCalculator.costThisMonth(purchasePrice: purchasePrice, daysOwned: daysOwned)
    }

    var costThisYear: Double {
        AmortisationCalculator.costThisYear(purchasePrice: purchasePrice, daysOwned: daysOwned)
    }

    var totalAmortized: Double {
        AmortisationCalculator.totalAmortized(purchasePrice: purchasePrice, daysOwned: daysOwned)
    }
}

// MARK: - Score
public extension ItemModelDomain {

    var scoreValue: Int {
        ScoreCalculator.scoreValue(daysOwned: daysOwned, durationTarget: durationTarget)
    }

    var scoreBand: ScoreBandType {
        ScoreBandType(scoreValue: scoreValue)
    }

    var isScoreVisible: Bool {
        ScoreCalculator.isScoreVisible(daysOwned: daysOwned)
    }

    var nextScoreBand: ScoreBandType? {
        ScoreTransitionCalculator.nextScoreBand(scoreBand: scoreBand)
    }

    var daysUntilNextBand: Int {
        ScoreTransitionCalculator.daysUntilNextBand(
            scoreBand: scoreBand,
            daysOwned: daysOwned,
            durationTarget: durationTarget
        )
    }
}

// MARK: - Pricing
public extension ItemModelDomain {

    var netCost: Double? {
        PricingAnalyzer.netCost(purchasePrice: purchasePrice, salePrice: salePrice)
    }

    var netCostPerDay: Double? {
        PricingAnalyzer.netCostPerDay(purchasePrice: purchasePrice, salePrice: salePrice, daysOwned: daysOwned)
    }

    var recoveryRate: Double? {
        PricingAnalyzer.recoveryRate(purchasePrice: purchasePrice, salePrice: salePrice)
    }
}
