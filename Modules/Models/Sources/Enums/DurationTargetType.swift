import Foundation

public enum DurationTargetType: String, CaseIterable, Codable, Sendable {
    case lessThan6Months   = "lt_6_months"
    case sixMonthsTo1Year  = "6m_to_1y"
    case oneToThreeYears   = "1_to_3_years"
    case threeToFiveYears  = "3_to_5_years"
    case fiveToSevenYears  = "5_to_7_years"
    case sevenYearsOrMore  = "7y_plus"

    public var targetDays: Int {
        switch self {
        case .lessThan6Months:  return 91
        case .sixMonthsTo1Year: return 182
        case .oneToThreeYears:  return 365
        case .threeToFiveYears: return 1095
        case .fiveToSevenYears: return 1825
        case .sevenYearsOrMore: return 2555
        }
    }

    public var thresholdCorrect: Int  { Int(Double(targetDays) * 0.333) }
    public var thresholdExcellent: Int { Int(Double(targetDays) * 0.666) }

    public func scoreValue(daysOwned: Int) -> Int {
        guard daysOwned >= 8 else { return 0 }
        let d = Double(daysOwned)
        let tc = Double(thresholdCorrect)
        let te = Double(thresholdExcellent)
        let td = Double(targetDays)
        let raw: Double
        if d < tc {
            raw = (d / tc) * 33
        } else if d < te {
            raw = 33 + ((d - tc) / (te - tc)) * 34
        } else {
            raw = 67 + min((d - te) / (td - te) * 33, 33)
        }
        return min(max(Int(raw), 0), 100)
    }
}
