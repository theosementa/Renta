//  AddObjectStore.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation

public protocol AddObjectStore {
    var state: AddObjectState { get }
    var sideEffects: AsyncStream<AddObjectSideEffect> { get }
    func send(_ intent: AddObjectIntent)
}
