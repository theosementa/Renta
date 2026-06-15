//
//  NavigationRegistry+Features.swift
//  Navigation
//
//  Created by Theo Sementa on 15/06/2026.
//

import PharosNav
import SwiftUI

// MARK: - Registration entry point (called from RentaApp.init)
@MainActor
public extension NavigationRegistry {
    func registerAllDestinations() {
        registerHomeDestinations()
        registerDashboardDestinations()
        registerSettingsDestinations()
        registerOnboardingDestinations()
    }
}

// MARK: - Home
@MainActor
extension NavigationRegistry {
    func registerHomeDestinations() {
        register(HomeDestination.self) { destination in
            switch destination {
            case .list:         EmptyView() // T045 — ItemListScreen
            case .detail:       EmptyView() // T055 — ItemDetailScreen
            case .addItem:      EmptyView() // T044 — AddItemScreen
            }
        }
    }
}

// MARK: - Dashboard
@MainActor
extension NavigationRegistry {
    func registerDashboardDestinations() {
        register(DashboardDestination.self) { destination in
            switch destination {
            case .main:         EmptyView() // T059 — DashboardScreen
            case .projections:  EmptyView() // T068 — ProjectionsScreen
            }
        }
    }
}

// MARK: - Settings
@MainActor
extension NavigationRegistry {
    func registerSettingsDestinations() {
        register(SettingsDestination.self) { destination in
            switch destination {
            case .main:         EmptyView() // T079 — SettingsScreen
            case .salary:       EmptyView() // T080 — SalaryScreen
            case .deleteData:   EmptyView() // T087 — DeleteDataScreen
            }
        }
    }
}

// MARK: - Onboarding
@MainActor
extension NavigationRegistry {
    func registerOnboardingDestinations() {
        register(OnboardingDestination.self) { destination in
            switch destination {
            case .welcome:      EmptyView() // T074 — OnboardingWelcomeScreen
            case .permissions:  EmptyView() // T075 — OnboardingPermissionsScreen
            }
        }
    }
}
