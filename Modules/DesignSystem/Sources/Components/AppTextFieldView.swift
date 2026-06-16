//  AppTextFieldView.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI

public struct AppTextFieldView: View {

    let label: String
    let leadingEmoji: String?
    let placeholder: String
    let suffix: String?
    let infoMessage: String?
    @Binding var text: String
    let onEmojiTap: (() -> Void)?

    public init(
        label: String,
        leadingEmoji: String? = nil,
        placeholder: String = "",
        suffix: String? = nil,
        infoMessage: String? = nil,
        text: Binding<String>,
        onEmojiTap: (() -> Void)? = nil
    ) {
        self.label = label
        self.leadingEmoji = leadingEmoji
        self.placeholder = placeholder
        self.suffix = suffix
        self.infoMessage = infoMessage
        self._text = text
        self.onEmojiTap = onEmojiTap
    }

    // MARK: - Body
    public var body: some View {
        VStack(alignment: .leading, spacing: .tiny) {
            Text(label)
                .font(.Body.smallRegular, color: .Text.secondary)

            HStack(spacing: .tiny) {
                if let emoji = leadingEmoji {
                    Button {
                        onEmojiTap?()
                    } label: {
                        Text(emoji)
                            .font(.Title.mediumMedium)
                            .frame(width: 52, height: 52)
                            .background(Color.Background.secondary, in: .rect(cornerRadius: .standard))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("accessibility.changeEmoji".localized)
                }

                HStack(spacing: .medium) {
                    TextField(placeholder, text: $text)
                        .font(.Body.mediumMedium, color: .Text.primary)

                    if let suffix {
                        Text(suffix)
                            .font(.Body.mediumMedium, color: .Text.tertiary)
                    }
                }
                .padding(.standard)
                .frame(maxWidth: .infinity, minHeight: 52)
                .background(Color.Background.secondary, in: .rect(cornerRadius: .standard))
            }

            if let info = infoMessage {
                Text(info)
                    .font(.Label.largeMedium, color: .Text.tertiary)
                    .padding(.horizontal, .tiny)
            }
        }
    }
}

// MARK: - Preview
#Preview("AppTextFieldView — with emoji") {
    VStack(spacing: .large) {
        AppTextFieldView(
            label: "Name and emoji",
            leadingEmoji: "📦",
            placeholder: "MacBook Pro M1 Max",
            text: .constant(""),
            onEmojiTap: {}
        )
        AppTextFieldView(
            label: "Purchase price",
            placeholder: "0",
            suffix: "€",
            text: .constant("1299")
        )
        AppTextFieldView(
            label: "With info",
            placeholder: "Placeholder",
            infoMessage: "Some helpful information below the field.",
            text: .constant("")
        )
    }
    .padding(.large)
    .background(Color.Background.primary)
}

#Preview("AppTextFieldView — Dark") {
    VStack(spacing: .large) {
        AppTextFieldView(
            label: "Name and emoji",
            leadingEmoji: "📦",
            placeholder: "MacBook Pro M1 Max",
            text: .constant(""),
            onEmojiTap: {}
        )
    }
    .padding(.large)
    .background(Color.Background.primary)
    .preferredColorScheme(.dark)
}
