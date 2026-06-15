//  AppCircleButtonView.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import SwiftUI

public struct AppCircleButtonView: View {

    let systemImage: String
    let action: () -> Void

    public init(systemImage: String, action: @escaping () -> Void) {
        self.systemImage = systemImage
        self.action = action
    }

    // MARK: - Body
    public var body: some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color.Text.primary)
                .frame(width: 44, height: 44)
                .background {
                    if #available(iOS 26, *) {
                        Circle()
                            .fill(.clear)
                            .glassEffect(.regular.interactive())
                    } else {
                        Circle()
                            .fill(Color.Background.secondary)
                    }
                }
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview
#Preview("AppCircleButtonView") {
    HStack(spacing: .large) {
        AppCircleButtonView(systemImage: "xmark", action: {})
        AppCircleButtonView(systemImage: "arrow.left", action: {})
    }
    .padding(.large)
    .background(Color.Background.primary)
}

#Preview("AppCircleButtonView — Dark") {
    HStack(spacing: .large) {
        AppCircleButtonView(systemImage: "xmark", action: {})
        AppCircleButtonView(systemImage: "arrow.left", action: {})
    }
    .padding(.large)
    .background(Color.Background.primary)
    .preferredColorScheme(.dark)
}
