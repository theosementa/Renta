//  UserSettingsEntity+Mapper.swift
//  Renta
//
//  Created by Theo Sementa on 15/06/2026.

import Foundation
import Models

extension UserSettingsEntity {
    func toDomain() -> UserSettingsDomain {
        UserSettingsDomain(
            monthlyNetSalary: monthlyNetSalary,
            weeklyHours: weeklyHours,
            hasCompletedOnboarding: hasCompletedOnboarding
        )
    }
}
