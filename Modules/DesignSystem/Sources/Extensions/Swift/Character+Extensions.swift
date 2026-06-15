//  Character+Extensions.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation

public extension Character {
    var isEmoji: Bool {
        unicodeScalars.first.map { $0.properties.isEmoji && $0.value > 0x238C } ?? false
    }
}
