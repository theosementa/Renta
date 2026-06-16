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

    @Environment(\.brandColor) private var brandColor
    @State private var viewModel = ObjectsListScreen.ViewModel()

    // MARK: - Body
    public var body: some View {
        ScrollView {
            content
        }
        .scrollIndicators(.hidden)
        .navigationTitle("objects.list.title".localized)
        .navigationBarTitleDisplayMode(.large)
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
            Text("objects.list.empty".localized)
                .font(AppFont.Body.mediumMedium, color: .Text.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, .huge)

        case .success(let items):
            LazyVStack(spacing: .standard) {
                ForEach(items) { item in
                    ObjectCardView(item: item, onDelete: { viewModel.deleteItem(id: item.id) })
                }
            }
            .padding(.standard)

        case .error:
            Text("common.error".localized)
                .font(AppFont.Body.mediumMedium, color: .Text.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, .huge)
        }
    }

}

// MARK: - ViewModel
extension ObjectsListScreen {

    @Observable @MainActor
    final class ViewModel {
        private(set) var isInitialLoading: Bool = true
        private(set) var loadError: AppError? = nil
        private let dataSource: ItemDataSource

        var state: ScreenState<[ItemModelDomain]> {
            if isInitialLoading { return .loading }
            if let error = loadError { return .error(error) }
            return dataSource.items.isEmpty ? .empty : .success(dataSource.items)
        }

        init(dataSource: ItemDataSource = ItemDataSource.shared) {
            self.dataSource = dataSource
        }
    }

}

// MARK: - Public methods
extension ObjectsListScreen.ViewModel: Routable {

    func navigateToAddObject() {
        router?.present(route: .fullScreenCover, .object(.create))
    }

    func deleteItem(id: UUID) {
        Task {
            try? await dataSource.delete(id: id)
        }
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
