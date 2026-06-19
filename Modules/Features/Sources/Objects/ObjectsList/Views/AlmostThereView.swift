//  AlmostThereView.swift
//  Renta
//
//  Created by Theo Sementa on 18/06/2026.

import SwiftUI
import DesignSystem
import Models

public struct AlmostThereView: View {

    let items: [ItemModelDomain]

    public init(items: [ItemModelDomain]) {
        self.items = items
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            header

            ScrollView(.horizontal) {
                HStack(spacing: .standard) {
                    ForEach(almostThereItems) { item in
                        card(for: item)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }

}

// MARK: - Subviews
private extension AlmostThereView {

    var header: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("home.almostThere.title".localized)
                .font(AppFont.Title.mediumMedium, color: .Text.primary)

            Text("home.almostThere.subtitle".localized)
                .font(AppFont.Body.smallRegular, color: .Text.secondary)
        }
    }

    func card(for item: ItemModelDomain) -> some View {
        VStack(alignment: .leading, spacing: .medium) {
            if let nextBand = item.nextScoreBand {
                Text(badgeText(item: item, nextBand: nextBand))
                    .font(AppFont.Label.largeMedium, color: nextBand.color)
                    .padding(.horizontal, CGFloat.small)
                    .padding(.vertical, CGFloat.tiny)
                    .background(nextBand.color.opacity(0.15), in: .capsule)
            }

            HStack {
                Text(item.emoji)
                    .font(.system(size: 16))
                    .padding(.small)
                    .background(item.scoreBand.color.opacity(0.15), in: .rect(cornerRadius: .small))

                Spacer()

                ProfitabilityIndicatorView(scoreValue: item.scoreValue, scoreBand: item.scoreBand)
            }

            VStack(alignment: .leading, spacing: 0) {
                Text(item.name)
                    .font(AppFont.Body.largeMedium, color: .Text.primary)

                Text(item.ownedForDisplay)
                    .font(AppFont.Label.largeMedium, color: .Text.secondary)
            }

            HStack(alignment: .bottom, spacing: .tiny) {
                Text(item.costPerDay.asCurrency)
                    .font(AppFont.Display.smallSemiBold, color: item.scoreBand.color)

                Text("objects.list.perDay".localized)
                    .font(AppFont.Label.largeMedium, color: .Text.secondary)
                    .padding(.bottom, 3)
            }
        }
        .frame(width: 200)
        .padding(.standard)
        .background(Color.Background.secondary, in: .rect(cornerRadius: .mediumLarge))
    }

}

// MARK: - Computed variables
private extension AlmostThereView {

    var almostThereItems: [ItemModelDomain] {
        items
            .filter { $0.nextScoreBand != nil }
            .sorted { $0.daysUntilNextBand < $1.daysUntilNextBand }
    }

    func badgeText(item: ItemModelDomain, nextBand: ScoreBandType) -> String {
        String(format: "home.almostThere.badge".localized, nextBand.label, item.daysUntilNextBand)
    }

}

// MARK: - Preview
private let previewItems: [ItemModelDomain] = [
    ItemModelDomain(
        name: "MacBook Pro",
        emoji: "💻",
        purchasePrice: 2499,
        purchaseDate: Calendar.current.date(byAdding: .day, value: -800, to: .now) ?? .now,
        durationTarget: .threeToFiveYears
    ),
    ItemModelDomain(
        name: "T-shirt Armani",
        emoji: "👕",
        purchasePrice: 180,
        purchaseDate: Calendar.current.date(byAdding: .day, value: -20, to: .now) ?? .now,
        durationTarget: .sixMonthsTo1Year
    ),
    ItemModelDomain(
        name: "iPhone 15",
        emoji: "📱",
        purchasePrice: 999,
        purchaseDate: Calendar.current.date(byAdding: .day, value: -200, to: .now) ?? .now,
        durationTarget: .oneToThreeYears
    )
]

#Preview("AlmostThereView — Light") {
    AlmostThereView(items: previewItems)
        .padding(.standard)
        .background(Color.Background.primary)
}

#Preview("AlmostThereView — Dark") {
    AlmostThereView(items: previewItems)
        .padding(.standard)
        .background(Color.Background.primary)
        .preferredColorScheme(.dark)
}
