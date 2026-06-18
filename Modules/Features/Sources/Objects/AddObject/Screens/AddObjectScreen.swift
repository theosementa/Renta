//  AddObjectScreen.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem
import Models

public struct AddObjectScreen: View {
    
    // MARK: Environments
    @Environment(\.dismiss) private var dismiss

    // MARK: States
    @State private var store = DefaultAddObjectStore()

    // MARK: - Body
    public var body: some View {
        VStack(spacing: 0) {
            AddObjectNavigationBarView(
                step: store.state.step,
                onLeadingTap: { store.send(.previousStep) },
                onDismiss: { store.send(.dismiss) }
            )

            scrollableContent

            AppPrimaryButtonView(
                title: store.state.step == .confirmation ? "objects.list.addButton".localized : "common.next".localized,
                isLoading: store.state.isLoading
            ) {
                if store.state.step == .confirmation {
                    store.send(.submit)
                } else {
                    store.send(.nextStep)
                }
            }
            .padding([.horizontal, .bottom], .large)
            .disabled(isActionButtonDisabled)
            .opacity(isActionButtonDisabled ? 0.4 : 1)
            .animation(.easeInOut(duration: 0.15), value: store.state.step)
        }
        .ignoresSafeArea(.keyboard)
        .background(Color.Background.primary)
        .task { await observeSideEffects() }
    }

    public init() {}

}

// MARK: - Scrollable content
private extension AddObjectScreen {

    var scrollableContent: some View {
        ScrollView {
            VStack(spacing: .huge) {
                Text(stepTitle)
                    .font(.Title.mediumMedium, color: .Text.primary)
                    .fullWidth(.leading)

                stepContent
            }
            .padding(.large)
        }
        .scrollIndicators(.hidden)
        .scrollDismissesKeyboard(.immediately)
        .fullSize()
    }

    var stepTitle: String {
        switch store.state.step {
        case .nameEmoji:    return "addObject.step1.question".localized
        case .details:      return "addObject.step2.question".localized
        case .tags:         return "addObject.step3.question".localized
        case .confirmation: return "addObject.step4.question".localized
        }
    }

    @ViewBuilder
    var stepContent: some View {
        switch store.state.step {
        case .nameEmoji:
            AddObjectStep1View(store: store)
        case .details:
            AddObjectStep2View(store: store)
        case .tags:
            AddObjectStep3View(store: store)
        case .confirmation:
            AddObjectStep4View(store: store)
        }
    }

}

// MARK: - Helpers
private extension AddObjectScreen {

    var isActionButtonDisabled: Bool {
        switch store.state.step {
        case .nameEmoji:    return !store.state.canProceedFromNameEmoji || store.state.isLoading
        case .details:      return store.state.isLoading
        case .tags:         return store.state.isLoading
        case .confirmation: return store.state.isLoading
        }
    }

}

// MARK: - Side effects
private extension AddObjectScreen {

    func observeSideEffects() async {
        for await effect in store.sideEffects {
            switch effect {
            case .dismiss:
                dismiss()
            case .showProUpgrade:
                break
            case .objectAdded:
                break
            }
        }
    }

}

// MARK: - Preview
#Preview("Step 1 — Light") {
    AddObjectScreen()
        .preferredColorScheme(.light)
}

#Preview("Step 1 — Dark") {
    AddObjectScreen()
        .preferredColorScheme(.dark)
}
