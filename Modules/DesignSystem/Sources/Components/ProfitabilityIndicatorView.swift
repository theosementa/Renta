//  ProfitabilityIndicatorView.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import SwiftUI
import Models

public struct ProfitabilityIndicatorView: View {

    let scoreValue: Int
    let scoreBand: ScoreBandType

    public init(scoreValue: Int, scoreBand: ScoreBandType) {
        self.scoreValue = scoreValue
        self.scoreBand = scoreBand
    }

    // MARK: - Body
    public var body: some View {
        ZStack {
            Circle()
                .stroke(scoreBand.color.opacity(0.15), lineWidth: 4)

            Circle()
                .trim(from: 0, to: CGFloat(scoreValue) / 100.0)
                .stroke(scoreBand.color, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                .rotationEffect(.degrees(-90))

            Text("\(scoreValue)")
                .font(AppFont.custom(name: .fontSemiBold, size: 14), color: scoreBand.color)
        }
        .frame(width: 36, height: 36)
    }
}

// MARK: - Preview
#Preview("ProfitabilityIndicatorView — Excellent") {
    HStack(spacing: .large) {
        ProfitabilityIndicatorView(scoreValue: 85, scoreBand: .excellent)
        ProfitabilityIndicatorView(scoreValue: 55, scoreBand: .correct)
        ProfitabilityIndicatorView(scoreValue: 20, scoreBand: .high)
    }
    .padding(.large)
    .background(Color.Background.primary)
}

#Preview("ProfitabilityIndicatorView — Dark") {
    HStack(spacing: .large) {
        ProfitabilityIndicatorView(scoreValue: 85, scoreBand: .excellent)
        ProfitabilityIndicatorView(scoreValue: 55, scoreBand: .correct)
        ProfitabilityIndicatorView(scoreValue: 20, scoreBand: .high)
    }
    .padding(.large)
    .background(Color.Background.primary)
    .preferredColorScheme(.dark)
}
