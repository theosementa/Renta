//  AddObjectError.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation

public enum AddObjectError: Error {
    case emptyName
    case invalidPrice
    case saveFailed(String)
}

// MARK: - Description
public extension AddObjectError {

    var description: String {
        switch self {
        case .emptyName:
            return "The object name cannot be empty."
        case .invalidPrice:
            return "The purchase price must be greater than zero."
        case .saveFailed(let reason):
            return "Failed to save the object: \(reason)"
        }
    }

}
