//
//  File.swift
//  Features
//
//  Created by Theo Sementa on 16/06/2026.
//

import Foundation
import Navigation

@MainActor
extension NavigationRegistry {
    
    public func registerObjectRoutes() {
        self.register(ObjectDestination.self) { destination in
            switch destination {
            case .list:
                ObjectsListScreen()
            case .create:
                AddObjectScreen()
            }
        }
    }
    
}
