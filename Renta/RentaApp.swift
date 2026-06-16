//
//  RentaApp.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.
//

import SwiftUI
import SwiftData
import PharosNav
import Persistence
import Navigation
import Objects

@main
struct RentaApp: App {

    init() {
        NavigationRegistry.shared.registerAllDestinations()
        NavigationRegistry.shared.registerObjectRoutes()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SwiftDataContextManager.shared.container)
    }
}

struct ContentView: View {

    @State private var routerManager = AppRouterManager.shared

    var body: some View {
        NavigationTabView(
            routerManager: routerManager,
            flows: [.home, .dashboard, .settings]
        ) { flow in
            switch flow {
            case .home:
                NavigationTabItem {
                    Label("Objects", systemImage: "bag")
                } content: {
                    ObjectsListScreen()
                }
            case .dashboard:
                NavigationTabItem {
                    Label("Dashboard", systemImage: "chart.bar")
                } content: {
                    EmptyView()
                }
            case .settings:
                NavigationTabItem {
                    Label("Settings", systemImage: "gear")
                } content: {
                    EmptyView()
                }
            case .onboarding:
                nil
            }
        }
    }
}
