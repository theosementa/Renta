//  Routable.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import PharosNav

public protocol Routable {}

public extension Routable {
    @MainActor
    var router: Router<AppDestination>? {
        AppRouterManager.shared.currentRouter
    }
}
