//  ObjectsListScreen.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import DesignSystem
import Models
import Navigation
import SwiftUI

public struct ObjectsListScreen: View {

    @Environment(\.brandColor) private var brandColor
    @State private var logic = ObjectsListScreen.Logic()

    // MARK: - Body
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: .standard) {
                AppSearchBarView(text: .init(
                    get: { logic.searchText },
                    set: { logic.searchTextChanged($0) }
                ))
                TagSelectorView(
                    selectedBand: logic.selectedBand,
                    brandColor: brandColor.color,
                    onSelect: { logic.bandSelected($0) }
                )
                cardsContent
            }
            .padding(.standard)
        }
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .navigationTitle("objects.list.title".localized)
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationDismissButton {
                    IconView(.iconArrowLeft)
                }
            }
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
        .background(Color.Background.primary)
        .task { await logic.loadItems() }
    }

    public init() {}

}

// MARK: - Subviews
extension ObjectsListScreen {

    @ViewBuilder
    fileprivate var cardsContent: some View {
        switch logic.state {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, .huge)

        case .empty:
            Text("objects.list.empty".localized)
                .font(AppFont.Body.mediumMedium, color: .Text.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, .huge)

        case .success(let items):
            LazyVStack(spacing: .standard) {
                ForEach(items) { item in
                    ObjectCardView(item: item, onDelete: { logic.deleteItem(id: item.id) })
                }
            }

        case .error:
            Text("common.error".localized)
                .font(AppFont.Body.mediumMedium, color: .Text.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, .huge)
        }
    }

}

// MARK: - Preview
#Preview("ObjectsListScreen — Light") {
    NavigationStack {
        ObjectsListScreen()
    }
    .preferredColorScheme(.light)
}

#Preview("ObjectsListScreen — Dark") {
    NavigationStack {
        ObjectsListScreen()
    }
    .preferredColorScheme(.dark)
}
