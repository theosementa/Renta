//  AppSearchBarView.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import SwiftUI

public struct AppSearchBarView: View {

    let placeholder: String
    @Binding var text: String

    public init(placeholder: String = "Search", text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    // MARK: - Body
    public var body: some View {
        HStack(spacing: .small) {
            IconView(.iconSearch, size: .large, color: .Text.secondary)
                .accessibilityHidden(true)

            TextField(placeholder, text: $text)
                .font(.Body.mediumRegular, color: .Text.primary)

            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    IconView(.iconXmark, size: .medium, color: .Text.secondary)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("accessibility.clearSearch".localized)
            }
        }
        .padding(.standard)
        .background(Color.Background.secondary, in: .rect(cornerRadius: .standard))
        .accessibilityLabel("accessibility.searchField".localized)
    }
}

// MARK: - Preview
#Preview {
    VStack(spacing: .large) {
        AppSearchBarView(text: .constant(""))
        AppSearchBarView(placeholder: "Search tags...", text: .constant("MacBook"))
    }
    .padding(.large)
    .background(Color.Background.primary)
}
