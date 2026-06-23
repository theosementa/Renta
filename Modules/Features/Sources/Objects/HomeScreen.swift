//  HomeScreen.swift
//  Renta
//
//  Created by Theo Sementa on 18/06/2026.

import SwiftUI
import DesignSystem
import Models
import Navigation

public struct HomeScreen: View {

    @Environment(\.brandColor) private var brandColor
    @State private var logic = HomeScreen.Logic()

    // MARK: - Body
    public var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: .huge) {
                TotalCostCardView(items: logic.items)
                    .padding(.horizontal, .large)
                PortfolioOverviewView(items: logic.items)
                    .padding(.horizontal, .large)

                if !logic.almostThereItems.isEmpty {
                    AlmostThereView(items: logic.items)
                }

                allObjectsRow
                    .padding(.horizontal, .large)
            }
            .padding(.vertical, .large)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("objects.list.title".localized)
        .navigationBarTitleDisplayMode(.large)
        .background(Color.Background.primary)
        .toolbar {
            if #available(iOS 26, *) {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", systemImage: "plus", role: .confirm) {
                        logic.navigateToAddObject()
                    }
                    .tint(brandColor.color)
                    .accessibilityLabel("objects.list.addButton".localized)
                }
            } else {
                ToolbarItem(placement: .topBarTrailing) {
                    AppNavigationButton(target: .fullScreenCover(.object(.create))) {
                        IconView(.iconPlus, color: .white)
                            .padding(.small)
                    }
                    .background(brandColor.color, in: .circle)
                    .accessibilityLabel("objects.list.addButton".localized)
                }
            }
        }
        .task { await logic.loadItems() }
    }

    public init() {}

}

// MARK: - Subviews
extension HomeScreen {

    fileprivate var allObjectsRow: some View {
        AppNavigationButton(target: .push(.object(.list))) {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("home.allObjects.title".localized)
                        .font(AppFont.Body.largeMedium, color: .Text.primary)

                    Text(String(format: "home.allObjects.count".localized, logic.items.count))
                        .font(AppFont.Body.smallRegular, color: .Text.secondary)
                }
                
                Spacer()
                
                IconView(.iconArrowRight)
            }
            .padding(.standard)
            .background(Color.Background.secondary, in: .rect(cornerRadius: .mediumLarge))
        }
    }

}

// MARK: - Preview
#Preview("HomeScreen — Light") {
    NavigationStack {
        HomeScreen()
    }
    .preferredColorScheme(.light)
}

#Preview("HomeScreen — Dark") {
    NavigationStack {
        HomeScreen()
    }
    .preferredColorScheme(.dark)
}
