//  AddObjectSideEffect.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

public enum AddObjectSideEffect: Sendable {
    case dismiss
    case showProUpgrade
    case objectAdded(ItemModelDomain)
}
