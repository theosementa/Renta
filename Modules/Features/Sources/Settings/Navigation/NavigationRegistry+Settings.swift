//  NavigationRegistry+Settings.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import SwiftUI
import Navigation

@MainActor
public extension NavigationRegistry {

    func registerSettingsRoutes() {
        register(SettingsDestination.self) { destination in
            switch destination {
            case .main:       SettingsScreen()
            case .salary:     EmptyView()
            case .deleteData: EmptyView()
            }
        }
    }

}
