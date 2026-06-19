//  PortfolioOverviewView.swift
//  Renta
//
//  Created by Theo Sementa on 18/06/2026.

import SwiftUI
import DesignSystem
import Models

public struct PortfolioOverviewView: View {

    let items: [ItemModelDomain]

    public init(items: [ItemModelDomain]) {
        self.items = items
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            Text("home.portfolio.title".localized)
                .font(AppFont.Title.mediumMedium, color: .Text.primary)

            HStack(spacing: .small) {
                chip(band: .excellent)
                chip(band: .correct)
                chip(band: .high)
            }
        }
    }

}

// MARK: - Subviews
private extension PortfolioOverviewView {

    func chip(band: ScoreBandType) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(count(for: band))")
                .font(AppFont.Display.largeBold, color: band.color)
                .contentTransition(.numericText())
                .animation(.smooth.delay(0.5), value: items.count)

            Text(band.label)
                .font(AppFont.Body.largeMedium, color: band.color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.standard)
        .background(band.color.opacity(0.15), in: .rect(cornerRadius: .large))
    }

}

// MARK: - Computed variables
private extension PortfolioOverviewView {

    func count(for band: ScoreBandType) -> Int {
        items.filter { $0.scoreBand == band }.count
    }

}

// MARK: - Preview
private let previewItems: [ItemModelDomain] = [
    ItemModelDomain(
        name: "MacBook Pro",
        emoji: "💻",
        purchasePrice: 2499,
        purchaseDate: Calendar.current.date(byAdding: .year, value: -2, to: .now) ?? .now,
        durationTarget: .threeToFiveYears
    ),
    ItemModelDomain(
        name: "iPhone 15",
        emoji: "📱",
        purchasePrice: 999,
        purchaseDate: Calendar.current.date(byAdding: .month, value: -8, to: .now) ?? .now,
        durationTarget: .oneToThreeYears
    ),
    ItemModelDomain(
        name: "T-shirt Armani",
        emoji: "👕",
        purchasePrice: 180,
        purchaseDate: Calendar.current.date(byAdding: .day, value: -8, to: .now) ?? .now,
        durationTarget: .lessThan6Months
    )
]

#Preview("PortfolioOverviewView — Light") {
    PortfolioOverviewView(items: previewItems)
        .padding(.standard)
        .background(Color.Background.primary)
}

#Preview("PortfolioOverviewView — Dark") {
    PortfolioOverviewView(items: previewItems)
        .padding(.standard)
        .background(Color.Background.primary)
        .preferredColorScheme(.dark)
}
