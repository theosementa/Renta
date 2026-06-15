import Foundation

public extension Calendar {
    func daysSince(_ date: Date) -> Int {
        dateComponents([.day], from: date, to: .now).day ?? 0
    }

    func timeAgoFormatted(from date: Date) -> String {
        let components = dateComponents([.year, .month, .day], from: date, to: .now)

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1

        if let years = components.year, years > 0 {
            formatter.allowedUnits = [.year]
        } else if let months = components.month, months > 0 {
            formatter.allowedUnits = [.month]
        } else {
            formatter.allowedUnits = [.day]
        }

        return formatter.string(from: date, to: .now) ?? ""
    }
}
