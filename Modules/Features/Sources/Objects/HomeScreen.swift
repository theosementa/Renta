//  HomeScreen.swift
//  Renta
//
//  Created by Theo Sementa on 18/06/2026.

import SwiftUI
import DataSources
import DesignSystem
import Models
import Navigation

public struct HomeScreen: View {

    @Environment(\.brandColor) private var brandColor
    @State private var viewModel = HomeScreen.ViewModel()

    // MARK: - Body
    public var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: .huge) {
                TotalCostCardView(items: viewModel.items)
                PortfolioOverviewView(items: viewModel.items)

                if !viewModel.almostThereItems.isEmpty {
                    AlmostThereView(items: viewModel.items)
                }

                allObjectsRow
            }
            .padding(.standard)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("objects.list.title".localized)
        .navigationBarTitleDisplayMode(.large)
        .background(Color.Background.primary)
        .toolbar {
            if #available(iOS 26, *) {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done", systemImage: "plus", role: .confirm) {
                        viewModel.navigateToAddObject()
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
        .task { await viewModel.loadItems() }
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
                    
                    Text(String(format: "home.allObjects.count".localized, viewModel.items.count))
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

// MARK: - ViewModel
extension HomeScreen {

    @Observable @MainActor
    final class ViewModel {
        private(set) var isInitialLoading: Bool = true
        private(set) var loadError: AppError? = nil
        private let dataSource: ItemDataSource

        var items: [ItemModelDomain] { dataSource.items }

        var almostThereItems: [ItemModelDomain] {
            items.filter { $0.nextScoreBand != nil }
        }

        init(dataSource: ItemDataSource = ItemDataSource.shared) {
            self.dataSource = dataSource
        }
    }

}

// MARK: - Public methods
extension HomeScreen.ViewModel: Routable {

    func navigateToAddObject() {
        router?.present(route: .fullScreenCover, .object(.create))
    }

    func loadItems() async {
        isInitialLoading = true
        loadError = nil
        do {
            try await dataSource.fetchItems()
            isInitialLoading = false
        } catch let error as AppError {
            loadError = error
            isInitialLoading = false
        } catch {
            loadError = .unknown(error.localizedDescription)
            isInitialLoading = false
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
