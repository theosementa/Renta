//  ObjectsListScreen.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import SwiftUI
import DesignSystem
import Models
import DataSources
import Navigation

public struct ObjectsListScreen: View {

    @State private var viewModel = ObjectsListScreen.ViewModel()

    // MARK: - Body
    public var body: some View {
        ScrollView {
            content
        }
        .scrollIndicators(.hidden)
        .navigationTitle("My Objects")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                AppNavigationButton(target: .fullScreenCover(.object(.create))) {
                    AppCircleButtonView(systemImage: "plus", hasLiquidGlass: false)
                        .allowsHitTesting(false)
                }
                .accessibilityLabel("Add object")
            }
        }
        .background(Color.Background.primary)
        .task { await viewModel.loadItems() }
    }

    public init() {}

}

// MARK: - Subviews
private extension ObjectsListScreen {

    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.top, .huge)

        case .empty:
            Text("No objects yet")
                .font(AppFont.Body.mediumMedium, color: .Text.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, .huge)

        case .success(let items):
            LazyVStack(spacing: .standard) {
                ForEach(items) { item in
                    ObjectCardView(item: item)
                }
            }
            .padding(.standard)

        case .error:
            Text("An error occurred")
                .font(AppFont.Body.mediumMedium, color: .Text.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, .huge)
        }
    }

}

// MARK: - ViewModel
extension ObjectsListScreen {

    @Observable @MainActor final class ViewModel {
        private(set) var state: ScreenState<[ItemModelDomain]> = .loading
        private let dataSource: ItemDataSource

        init(dataSource: ItemDataSource = ItemDataSource()) {
            self.dataSource = dataSource
        }
    }

}

// MARK: - Public methods
extension ObjectsListScreen.ViewModel {

    func loadItems() async {
        state = .loading
        do {
            try await dataSource.fetchItems()
            let items = dataSource.items
            state = items.isEmpty ? .empty : .success(items)
        } catch {
            state = .error(.unknown(error.localizedDescription))
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
