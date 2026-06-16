//  ObjectCardView.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import SwiftUI
import DesignSystem
import Models

public struct ObjectCardView: View {

    let item: ItemModelDomain

    public init(item: ItemModelDomain) {
        self.item = item
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: .standard) {
            header
            costRow
            Divider()
            Text(item.hintText)
                .font(AppFont.Label.largeMedium, color: .Text.secondary)
        }
        .padding(.standard)
        .background(Color.Background.secondary, in: .rect(cornerRadius: .mediumLarge))
    }
}

// MARK: - Subviews
private extension ObjectCardView {

    var header: some View {
        HStack {
            HStack(spacing: .small) {
                Text(item.emoji)
                    .font(.system(size: 20))
                    .padding(.small)
                    .background(item.scoreBand.color.opacity(0.15), in: .rect(cornerRadius: .small))

                VStack(alignment: .leading, spacing: 2) {
                    Text(item.name)
                        .font(AppFont.Body.largeMedium, color: .Text.primary)

                    Text(item.subtitleDisplay)
                        .font(AppFont.Label.largeMedium, color: .Text.secondary)
                }
            }

            Spacer()

            ProfitabilityIndicatorView(scoreValue: item.scoreValue, scoreBand: item.scoreBand)
        }
    }

    var costRow: some View {
        HStack(alignment: .bottom, spacing: .tiny) {
            Text(item.costPerDay.asCurrency)
                .font(AppFont.Display.smallSemiBold, color: item.scoreBand.color)

            Text("/day")
                .font(AppFont.Label.largeMedium, color: .Text.secondary)
                .padding(.bottom, 3)
        }
    }

}

// MARK: - Preview
private let previewItem = ItemModelDomain(
    name: "MacBook Pro",
    emoji: "💻",
    purchasePrice: 2499,
    purchaseDate: Calendar.current.date(byAdding: .year, value: -2, to: .now) ?? .now,
    durationTarget: .threeToFiveYears,
    tags: [TagModelDomain(name: "Technology")]
)

#Preview("ObjectCardView — Light") {
    ObjectCardView(item: previewItem)
        .padding(.standard)
        .background(Color.Background.primary)
}

#Preview("ObjectCardView — Dark") {
    ObjectCardView(item: previewItem)
        .padding(.standard)
        .background(Color.Background.primary)
        .preferredColorScheme(.dark)
}
