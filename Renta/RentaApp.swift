//
//  RentaApp.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.
//

import SwiftUI
import Persistence
import SwiftData

@main
struct RentaApp: App {

    init() {
        // T031 — NavigationRegistry.shared.registerAllDestinations()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SwiftDataContextManager.shared.container)
    }
}
