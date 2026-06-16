//  ItemModelDomain+UI.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import Foundation
import Models

public extension ItemModelDomain {
    var ownedForDisplay: String {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: purchaseDate, to: .now)
        let years = components.year ?? 0
        let months = components.month ?? 0
        let days = components.day ?? 0
        if years > 0 {
            let yearStr = years == 1 ? "item.owned.oneYear".localized : String(format: "item.owned.years".localized, years)
            if months > 0 {
                let monthStr = months == 1 ? "item.owned.oneMonth".localized : String(format: "item.owned.months".localized, months)
                return String(format: "item.owned.combined".localized, yearStr, monthStr)
            }
            return yearStr
        }
        if months > 0 {
            let monthStr = months == 1 ? "item.owned.oneMonth".localized : String(format: "item.owned.months".localized, months)
            if days > 0 {
                let dayStr = days == 1 ? "item.owned.oneDay".localized : String(format: "item.owned.days".localized, days)
                return String(format: "item.owned.combined".localized, monthStr, dayStr)
            }
            return monthStr
        }
        return days <= 1 ? "item.owned.today".localized : String(format: "item.owned.days".localized, days)
    }

    var hintText: String {
        if scoreValue >= 100 { return "item.hint.fullyAmortized".localized }
        switch scoreBand {
        case .excellent:
            let remaining = durationTarget.targetDays - daysOwned
            if remaining <= 0 { return "item.hint.fullyAmortized".localized }
            return String(format: "item.hint.targetIn".localized, formatDuration(remaining))
        case .correct:
            let remaining = durationTarget.thresholdExcellent - daysOwned
            return String(format: "item.hint.excellentIn".localized, formatDuration(max(remaining, 1)))
        case .high:
            let remaining = durationTarget.thresholdCorrect - daysOwned
            return String(format: "item.hint.correctIn".localized, formatDuration(max(remaining, 1)))
        }
    }
}

private extension ItemModelDomain {
    func formatDuration(_ days: Int) -> String {
        if days < 31 {
            return days == 1 ? "item.owned.oneDay".localized : String(format: "item.owned.days".localized, days)
        } else if days < 365 {
            let m = Int((Double(days) / 30.44).rounded(.toNearestOrAwayFromZero))
            return m == 1 ? "item.owned.oneMonth".localized : String(format: "item.owned.months".localized, m)
        } else {
            let y = Int((Double(days) / 365.0).rounded(.toNearestOrAwayFromZero))
            return y == 1 ? "item.owned.oneYear".localized : String(format: "item.owned.years".localized, y)
        }
    }
}
