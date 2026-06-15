//
//  AppNavigationButton.swift
//  Navigation
//
//  Created by Theo Sementa on 15/06/2026.
//

import SwiftUI
import PharosNav

public struct AppNavigationButton<Label: View>: View {
    public let target: NavigationTarget<AppDestination>
    @ViewBuilder public let label: () -> Label

    public init(target: NavigationTarget<AppDestination>, @ViewBuilder label: @escaping () -> Label) {
        self.target = target
        self.label = label
    }

    public var body: some View {
        GenericNavigationButton(target: target, label: label)
    }
}
