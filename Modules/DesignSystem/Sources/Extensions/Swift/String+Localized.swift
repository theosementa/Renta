//  String+Localized.swift
//  Renta
//
//  Created by Theo Sementa on 16/06/2026.

import Foundation

public extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }
}
