import Foundation

public enum ItemStatusType: String, Codable, Sendable {
    case active
    case sold
    case endOfLife
    case gifted
    case lost
}
