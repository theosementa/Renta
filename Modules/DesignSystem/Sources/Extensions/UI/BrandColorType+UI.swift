//  BrandColorType+UI.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import SwiftUI
import Models

public extension BrandColorType {
    var color: Color {
        switch self {
        case .green:  Color(hex: 0x1A7F5A)
        case .blue:   Color(hex: 0x007AFF)
        case .purple: Color(hex: 0x5856D6)
        case .orange: Color(hex: 0xFF9500)
        case .red:    Color(hex: 0xFF3B30)
        case .pink:   Color(hex: 0xFF2D55)
        }
    }
}

public extension EnvironmentValues {
    @Entry var brandColor: BrandColorType = .green
}
