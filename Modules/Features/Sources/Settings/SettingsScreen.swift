//  SettingsScreen.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import SwiftUI
import Models
import DesignSystem
import DataSources

public struct SettingsScreen: View {

    @State private var viewModel = SettingsScreen.ViewModel()

    public init() {}

    // MARK: - Body
    public var body: some View {
        Form {
            Section(LocalizedStringKey("Appearance")) {
                Picker(LocalizedStringKey("Brand Color"), selection: .init(
                    get: { viewModel.brandColor },
                    set: { viewModel.updateBrandColor($0) }
                )) {
                    ForEach(BrandColorType.allCases, id: \.self) { color in
                        Label {
                            Text(LocalizedStringKey(color.displayName))
                        } icon: {
                            Circle()
                                .fill(color.color)
                                .frame(width: 16, height: 16)
                        }
                        .tag(color)
                    }
                }
            }
        }
        .navigationTitle(LocalizedStringKey("Settings"))
        .navigationBarTitleDisplayMode(.large)
    }

}

// MARK: - ViewModel
extension SettingsScreen {

    @Observable @MainActor
    final class ViewModel {
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
extension SettingsScreen.ViewModel {

    func updateBrandColor(_ color: BrandColorType) {
        try? dataSource.updateBrandColor(color)
    }

}

// MARK: - Preview
#Preview {
    NavigationStack {
        SettingsScreen()
    }
}
