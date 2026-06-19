//  ItemModelDomain+UI.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import Foundation
import Logic
import Models

public extension ItemModelDomain {
    var ownedForDisplay: String {
        DurationFormatter.format(days: daysOwned)
    }

    var hintText: String {
        ScoreMessageGenerator.hintText(
            scoreValue: scoreValue,
            scoreBand: scoreBand,
            daysOwned: daysOwned,
            durationTarget: durationTarget
        )
    }
}
