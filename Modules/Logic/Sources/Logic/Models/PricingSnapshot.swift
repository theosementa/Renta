//  PricingSnapshot.swift
//  Renta

import Foundation

public struct PricingSnapshot: Equatable, Sendable {
    public let netCost: Double?
    public let netCostPerDay: Double?
    public let recoveryRate: Double?

    public init(
        netCost: Double?,
        netCostPerDay: Double?,
        recoveryRate: Double?
    ) {
        self.netCost = netCost
        self.netCostPerDay = netCostPerDay
        self.recoveryRate = recoveryRate
    }
}
