//  TotalCostCardView.swift
//  Renta
//
//  Created by Theo Sementa on 18/06/2026.

import SwiftUI
import DesignSystem
import Models

public struct TotalCostCardView: View {

    let items: [ItemModelDomain]

    public init(items: [ItemModelDomain]) {
        self.items = items
    }

    // MARK: - Body
    public var body: some View {
        VStack(spacing: .standard) {
            header
            divider
            statsRow
        }
        .padding(.standard)
        .background(Color.Brand.main, in: .rect(cornerRadius: .large))
    }
}

// MARK: - Subviews
private extension TotalCostCardView {

    var header: some View {
        VStack(alignment: .leading, spacing: .tiny) {
            Text("home.totalCostCard.label".localized)
                .font(AppFont.Body.mediumRegular, color: .white.opacity(0.6))

            HStack(alignment: .bottom, spacing: 10) {
                Text(totalCostPerDay.asCurrency)
                    .font(AppFont.Display.extraLargeSemiBold, color: .white)

                Text("home.totalCostCard.perDay".localized)
                    .font(AppFont.Body.mediumRegular, color: .white.opacity(0.6))
                    .padding(.bottom, 6)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var divider: some View {
        Rectangle()
            .fill(Color.white.opacity(0.3))
            .frame(height: 0.5)
    }

    var statsRow: some View {
        HStack(spacing: .standard) {
            statColumn(amount: totalCostThisMonth, label: "home.totalCostCard.thisMonth".localized)
            statColumn(amount: totalCostThisYear, label: "home.totalCostCard.thisYear".localized)
            statColumn(amount: totalValue, label: "home.totalCostCard.totalValue".localized)
        }
    }

    func statColumn(amount: Double, label: String) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(amount.asCurrency)
                .font(AppFont.Body.largeMedium, color: .white)

            Text(label)
                .font(AppFont.Body.smallRegular, color: .white.opacity(0.6))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}

// MARK: - Computed variables
private extension TotalCostCardView {

    var activeItems: [ItemModelDomain] {
        items.filter { !$0.excludeFromGlobal }
    }

    var totalCostPerDay: Double {
        activeItems.reduce(0) { $0 + $1.costPerDay }
    }

    var totalCostThisMonth: Double {
        activeItems.reduce(0) { $0 + $1.costThisMonth }
    }

    var totalCostThisYear: Double {
        activeItems.reduce(0) { $0 + $1.costThisYear }
    }

    var totalValue: Double {
        activeItems.reduce(0) { $0 + $1.purchasePrice }
    }

}

// MARK: - Preview
private let previewItems: [ItemModelDomain] = [
    ItemModelDomain(
        name: "MacBook Pro",
        emoji: "💻",
        purchasePrice: 2499,
        purchaseDate: Calendar.current.date(byAdding: .year, value: -2, to: .now) ?? .now,
        durationTarget: .threeToFiveYears,
        tags: []
    ),
    ItemModelDomain(
        name: "iPhone 15",
        emoji: "📱",
        purchasePrice: 999,
        purchaseDate: Calendar.current.date(byAdding: .month, value: -8, to: .now) ?? .now,
        durationTarget: .oneToThreeYears,
        tags: []
    )
]

#Preview("TotalCostCardView — Light") {
    TotalCostCardView(items: previewItems)
        .padding(.standard)
        .background(Color.Background.primary)
}

#Preview("TotalCostCardView — Dark") {
    TotalCostCardView(items: previewItems)
        .padding(.standard)
        .background(Color.Background.primary)
        .preferredColorScheme(.dark)
}
