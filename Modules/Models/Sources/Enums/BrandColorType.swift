//  BrandColorType.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import Foundation

public enum BrandColorType: String, CaseIterable, Sendable {
    case green
    case blue
    case purple
    case orange
    case red
    case pink

    public var displayName: String {
        switch self {
        case .green:  "Green"
        case .blue:   "Blue"
        case .purple: "Purple"
        case .orange: "Orange"
        case .red:    "Red"
        case .pink:   "Pink"
        }
    }
}
