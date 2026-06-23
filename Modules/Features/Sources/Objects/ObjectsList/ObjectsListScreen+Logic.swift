//  ObjectsListScreen+Logic.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import Foundation
import DataSources
import Models
import Navigation

// MARK: - Logic
extension ObjectsListScreen {

    @Observable @MainActor
    final class Logic {
        private(set) var isInitialLoading: Bool = true
        private(set) var loadError: AppError? = nil
        private(set) var searchText: String = ""
        private(set) var selectedBand: ScoreBandType? = nil
        private let dataSource: ItemDataSource

        init(dataSource: ItemDataSource = ItemDataSource.shared) {
            self.dataSource = dataSource
        }
    }

}

// MARK: - Computed variables
extension ObjectsListScreen.Logic {

    var filteredItems: [ItemModelDomain] {
        dataSource.items
            .filter { searchText.isEmpty || $0.name.localizedCaseInsensitiveContains(searchText) }
            .filter { selectedBand == nil || $0.scoreBand == selectedBand }
    }

    var state: ScreenState<[ItemModelDomain]> {
        if isInitialLoading { return .loading }
        if let error = loadError { return .error(error) }
        return filteredItems.isEmpty ? .empty : .success(filteredItems)
    }

}

// MARK: - Public methods
extension ObjectsListScreen.Logic: Routable {

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

    func searchTextChanged(_ text: String) {
        searchText = text
    }

    func bandSelected(_ band: ScoreBandType?) {
        selectedBand = band
    }

}
