//  SettingsScreen.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import SwiftUI
import Models
import DesignSystem

public struct SettingsScreen: View {

    @State private var logic = SettingsScreen.Logic()

    public init() {}

    // MARK: - Body
    public var body: some View {
        Form {
            Section("settings.appearance".localized) {
                Picker("settings.brandColor".localized, selection: .init(
                    get: { logic.brandColor },
                    set: { logic.updateBrandColor($0) }
                )) {
                    ForEach(BrandColorType.allCases, id: \.self) { color in
                        Label {
                            Text(color.localizedName)
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
        .navigationTitle("settings.title".localized)
        .navigationBarTitleDisplayMode(.large)
    }

}

// MARK: - Preview
#Preview {
    NavigationStack {
        SettingsScreen()
    }
}
