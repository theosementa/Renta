//  SettingsScreen+Logic.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import Foundation
import DataSources
import Models

// MARK: - Logic
extension SettingsScreen {

    @Observable @MainActor
    final class Logic {
        private let dataSource: UserSettingsDataSource

        var brandColor: BrandColorType {
            dataSource.settings.brandColor
        }

        init(dataSource: UserSettingsDataSource = .shared) {
            self.dataSource = dataSource
        }
    }

}

// MARK: - Public methods
extension SettingsScreen.Logic {

    func updateBrandColor(_ color: BrandColorType) {
        try? dataSource.updateBrandColor(color)
    }

}
