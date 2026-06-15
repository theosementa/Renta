//  AddObjectStep.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation

public enum AddObjectStep: Int, CaseIterable, Sendable {
    case nameEmoji = 0
    case details = 1
    case tags = 2
    case confirmation = 3
}
