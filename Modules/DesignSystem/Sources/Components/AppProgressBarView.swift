//  AppProgressBarView.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI

public struct AppProgressBarView: View {

    let totalSteps: Int
    let currentStep: Int

    public init(totalSteps: Int, currentStep: Int) {
        self.totalSteps = totalSteps
        self.currentStep = currentStep
    }

    // MARK: - Body
    public var body: some View {
        HStack(spacing: .small) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Capsule()
                    .fill(index == currentStep ? Color.Brand.main : Color.Background.quaternary)
                    .frame(height: 4)
                    .animation(.easeInOut(duration: 0.2), value: currentStep)
            }
        }
    }
}

// MARK: - Preview
#Preview("AppProgressBarView") {
    VStack(spacing: .large) {
        AppProgressBarView(totalSteps: 4, currentStep: 0)
        AppProgressBarView(totalSteps: 4, currentStep: 1)
        AppProgressBarView(totalSteps: 4, currentStep: 2)
        AppProgressBarView(totalSteps: 4, currentStep: 3)
    }
    .padding(.large)
    .background(Color.Background.primary)
}

#Preview("AppProgressBarView — Dark") {
    VStack(spacing: .large) {
        AppProgressBarView(totalSteps: 4, currentStep: 1)
    }
    .padding(.large)
    .background(Color.Background.primary)
    .preferredColorScheme(.dark)
}
