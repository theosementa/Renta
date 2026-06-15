//
//  File.swift
//  DesignSystem
//
//  Created by Theo Sementa on 15/06/2026.
//

import Foundation
import SwiftUI

public extension Color {
    
    static func dynamicColor(light: UInt, dark: UInt) -> Color {
        let lightColor = Color(hex: light)
        let darkColor = Color(hex: dark)
        
        return Color(
            uiColor: UIColor { $0.userInterfaceStyle == .dark ? UIColor(darkColor) : UIColor(lightColor) }
        )
    }
    
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
    
}

public extension Color {
    
    struct Base {
        public static let white: Color = Color(hex: 0xFFFFFF)
        public static let black: Color = Color(hex: 0x000000)
    }
    
    struct Text {
        public static let primary: Color = Color.primary
        public static let primaryReversed: Color = dynamicColor(light: 0xFFFFFF, dark: 0x000000)
        public static let secondary: Color = Color.secondary
        public static let tertiary: Color = Color(uiColor: .tertiaryLabel)
    }
    
    struct Background {
        public static let primary: Color = Color(uiColor: .systemGroupedBackground)
        public static let secondary: Color = Color(uiColor: .secondarySystemGroupedBackground)
        public static let tertiary: Color = Color(uiColor: .tertiarySystemGroupedBackground)
        public static let quaternary: Color = dynamicColor(light: 0xE5E5EA, dark: 0x36383C)
    }
    
    struct Brand {
        public static let main: Color = Color(hex: 0x1A7F5A)
    }
    
    struct Status {
        public static let excellent: Color = Color(hex: 0x1B7F5A)
        public static let correct: Color = Color(hex: 0xB96B00)
        public static let high: Color = Color(hex: 0xCC2201)
    }
    
}
