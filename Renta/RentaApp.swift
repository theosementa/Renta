//
//  RentaApp.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.
//

import SwiftUI
import PharosNav
import Navigation
import DataSources
import Objects
import Settings
import Models
import DesignSystem

@main
struct RentaApp: App {

    init() {
        NavigationRegistry.shared.registerAllDestinations()
        NavigationRegistry.shared.registerObjectRoutes()
        NavigationRegistry.shared.registerSettingsRoutes()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {

    @State private var routerManager = AppRouterManager.shared
    @State private var userSettingsDataSource = UserSettingsDataSource.shared

    var body: some View {
        NavigationTabView(
            routerManager: routerManager,
            flows: [.home, .dashboard, .settings]
        ) { flow in
            switch flow {
            case .home:
                NavigationTabItem {
                    Label("tab.objects".localized, systemImage: "bag")
                } content: {
                    ObjectsListScreen()
                }
            case .dashboard:
                NavigationTabItem {
                    Label("tab.dashboard".localized, systemImage: "chart.bar")
                } content: {
                    EmptyView()
                }
            case .settings:
                NavigationTabItem {
                    Label("tab.settings".localized, systemImage: "gear")
                } content: {
                    SettingsScreen()
                }
            case .onboarding:
                nil
            }
        }
        .tint(userSettingsDataSource.settings.brandColor.color)
        .environment(\.brandColor, userSettingsDataSource.settings.brandColor)
    }
}
