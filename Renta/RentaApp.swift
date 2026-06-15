//
//  RentaApp.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.
//

import SwiftUI
import Persistence
import SwiftData
import Navigation

@main
struct RentaApp: App {

    init() {
        NavigationRegistry.shared.registerAllDestinations()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SwiftDataContextManager.shared.container)
    }
}
