//  UserSettingsRepository.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

@MainActor
public protocol UserSettingsRepository {
    func fetch() throws -> UserSettingsDomain
    func save(_ domain: UserSettingsDomain) throws
}
