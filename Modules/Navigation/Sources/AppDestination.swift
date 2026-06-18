//
//  AppDestination.swift
//  Navigation
//
//  Created by Theo Sementa on 15/06/2026.
//

import PharosNav

@RecursiveDestination
public nonisolated enum AppDestination: @MainActor AppDestinationProtocol {
    case home(HomeDestination)
    case object(ObjectDestination)
    case dashboard(DashboardDestination)
    case settings(SettingsDestination)
    case onboarding(OnboardingDestination)
}
