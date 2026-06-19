//
//  SwiftUIView.swift
//  DesignSystem
//
//  Created by Theo Sementa on 19/06/2026.
//

import SwiftUI
import Models

public struct CircleButtonView: View {
    
    // MARK: Dependencies
    let icon: ImageType
    let hasLiquidGlass: Bool
    let action: () -> Void

    // MARK: Init
    public init(
        icon: ImageType,
        hasLiquidGlass: Bool = true,
        action: @escaping () -> Void = { }
    ) {
        self.icon = icon
        self.hasLiquidGlass = hasLiquidGlass
        self.action = action
    }
    
    // MARK: - Body
    public var body: some View {
        Button(action: action) {
            IconView(icon, size: .mediumLarge, color: .Text.primary)
                .padding(.medium)
                .background {
                    if #available(iOS 26, *) {
                        if hasLiquidGlass {
                            Circle()
                                .fill(.clear)
                                .glassEffect(.regular.interactive())
                        }
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
#Preview {
    CircleButtonView(icon: .iconCalendar)
}
