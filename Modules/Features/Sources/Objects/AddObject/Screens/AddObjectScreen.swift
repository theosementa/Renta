//  AddObjectScreen.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem
import Models

public struct AddObjectScreen: View {

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
                title: store.state.step == .confirmation ? "Add object" : "Next",
                isLoading: store.state.isLoading
            ) {
                if store.state.step == .confirmation {
                    store.send(.submit)
                } else {
                    store.send(.nextStep)
                }
            }
            .padding(.horizontal, .large)
            .padding(.bottom, .large)
            .disabled(isActionButtonDisabled)
            .opacity(isActionButtonDisabled ? 0.4 : 1)
            .animation(.easeInOut(duration: 0.15), value: store.state.step)
        }
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
                    .frame(maxWidth: .infinity, alignment: .leading)

                stepContent
            }
            .padding(.large)
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    var stepTitle: String {
        switch store.state.step {
        case .nameEmoji:    return "What did you buy?"
        case .details:      return "How long should a typical object in this category take to feel well amortized?"
        case .tags:         return "Add tags"
        case .confirmation: return "Looks good?"
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
                break
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
