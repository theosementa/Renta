//  AmortisationMetrics.swift
//  Renta

import Foundation

public struct AmortisationMetrics: Equatable, Sendable {
    public let daysOwned: Int
    public let costPerDay: Double
    public let costPerMonth: Double
    public let costPerYear: Double
    public let costThisMonth: Double
    public let costThisYear: Double
    public let totalAmortized: Double

    public init(
        daysOwned: Int,
        costPerDay: Double,
        costPerMonth: Double,
        costPerYear: Double,
        costThisMonth: Double,
        costThisYear: Double,
        totalAmortized: Double
    ) {
        self.daysOwned = daysOwned
        self.costPerDay = costPerDay
        self.costPerMonth = costPerMonth
        self.costPerYear = costPerYear
        self.costThisMonth = costThisMonth
        self.costThisYear = costThisYear
        self.totalAmortized = totalAmortized
    }
}
