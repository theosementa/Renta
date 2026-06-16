//  AppPrimaryButtonView.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI

public struct AppPrimaryButtonView: View {

    @Environment(\.brandColor) private var brandColor

    let title: String
    let isLoading: Bool
    let action: () -> Void

    public init(title: String, isLoading: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.isLoading = isLoading
        self.action = action
    }

    // MARK: - Body
    public var body: some View {
        Button(action: action) {
            Group {
                if isLoading {
                    ProgressView()
                        .tint(Color.Base.white)
                } else {
                    Text(title)
                        .font(Font.custom(fontMedium, size: 18))
                        .foregroundStyle(Color.Base.white)
                }
            }
            .frame(maxWidth: .infinity, minHeight: 55)
            .background(brandColor.color, in: .rect(cornerRadius: 14))
        }
        .buttonStyle(.plain)
        .disabled(isLoading)
    }
}

// MARK: - Preview
#Preview("AppPrimaryButtonView") {
    VStack(spacing: .large) {
        AppPrimaryButtonView(title: "Next", action: {})
        AppPrimaryButtonView(title: "Next", isLoading: true, action: {})
        AppPrimaryButtonView(title: "Next", action: {})
            .opacity(0.4)
    }
    .padding(.large)
    .background(Color.Background.primary)
}

#Preview("AppPrimaryButtonView — Dark") {
    VStack(spacing: .large) {
        AppPrimaryButtonView(title: "Next", action: {})
    }
    .padding(.large)
    .background(Color.Background.primary)
    .preferredColorScheme(.dark)
}
