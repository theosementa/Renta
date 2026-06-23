//  HomeScreen+Logic.swift
//  Renta
//
//  Created by Theo Sementa on 18/06/2026.

import Foundation
import DataSources
import Models
import Navigation

// MARK: - Logic
extension HomeScreen {

    @Observable @MainActor
    final class Logic {
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
extension HomeScreen.Logic: Routable {

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
