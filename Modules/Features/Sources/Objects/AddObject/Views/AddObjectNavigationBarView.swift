//  AddObjectNavigationBarView.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem
import Models

struct AddObjectNavigationBarView: View {

    let step: AddObjectStep
    let onLeadingTap: () -> Void
    let onDismiss: () -> Void

    // MARK: - Body
    var body: some View {
        VStack(spacing: .medium) {
            HStack {
                if step != .nameEmoji {
                    AppCircleButtonView(systemImage: "arrow.left", action: onLeadingTap)
                        .accessibilityLabel("common.back".localized)
                } else {
                    Spacer().frame(width: 44)
                }
                Spacer()
                AppCircleButtonView(systemImage: "xmark", action: onDismiss)
                    .accessibilityLabel("common.close".localized)
            }
            AppProgressBarView(
                totalSteps: AddObjectStep.allCases.count,
                currentStep: step.rawValue
            )
        }
        .padding(.horizontal, .large)
    }
}
