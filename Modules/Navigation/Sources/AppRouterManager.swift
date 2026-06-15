//
//  AppRouterManager.swift
//  Navigation
//
//  Created by Theo Sementa on 15/06/2026.
//

import PharosNav

@MainActor
public final class AppRouterManager: RouterManager<AppFlow, AppDestination> {
    public static let shared = AppRouterManager()

    private init() {
        super.init(selectedFlow: .home)
    }
}
