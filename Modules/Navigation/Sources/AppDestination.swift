//
//  AppDestination.swift
//  Navigation
//
//  Created by Theo Sementa on 15/06/2026.
//

import PharosNav

@RecursiveDestination
public enum AppDestination: @MainActor AppDestinationProtocol {
    case home(HomeDestination)
    case dashboard(DashboardDestination)
    case settings(SettingsDestination)
    case onboarding(OnboardingDestination)
}
