//  AddObjectStep1View.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI
import DesignSystem
import MCEmojiPicker

struct AddObjectStep1View: View {

    @Bindable var store: DefaultAddObjectStore
    @State private var showEmojiPicker = false

    // MARK: - Body
    var body: some View {
        VStack(spacing: .mediumLarge) {
            AppTextFieldView(
                label: "addObject.step1.nameLabel".localized,
                leadingEmoji: store.state.emoji,
                placeholder: "MacBook Pro M1 Max",
                text: .init(
                    get: { store.state.name },
                    set: { store.send(.nameChanged($0)) }
                ),
                onEmojiTap: { showEmojiPicker = true }
            )
            .emojiPicker(
                isPresented: $showEmojiPicker,
                selectedEmoji: .init(
                    get: { store.state.emoji },
                    set: { store.send(.emojiChanged($0)) }
                )
            )

            AppTextFieldView(
                label: "addObject.purchasePrice".localized,
                placeholder: "0",
                suffix: "€",
                text: .init(
                    get: { store.state.purchasePrice == 0 ? "" : String(store.state.purchasePrice) },
                    set: { newValue in
                        let sanitized = newValue.replacingOccurrences(of: ",", with: ".")
                        store.send(.priceChanged(Double(sanitized) ?? 0))
                    }
                )
            )
            .keyboardType(.decimalPad)

            AppDateFieldView(
                label: "addObject.purchaseDate".localized,
                infoMessage: purchaseDateInfoMessage,
                date: .init(
                    get: { store.state.purchaseDate },
                    set: { store.send(.purchaseDateChanged($0)) }
                )
            )
        }
    }
}

// MARK: - Private computed properties
private extension AddObjectStep1View {

    var purchaseDateInfoMessage: String {
        let days = Calendar.current.dateComponents([.day], from: store.state.purchaseDate, to: .now).day ?? 0
        if days < 365 {
            return String(format: "addObject.step1.daysAgo".localized, days)
        } else {
            let years = days / 365
            return String(format: "addObject.step1.yearsAgo".localized, years, days)
        }
    }

}
