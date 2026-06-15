import Foundation
import SwiftData

@Model
public final class TagEntity {
    public var id: UUID = UUID()
    public var name: String = ""
    public var items: [ItemEntity]? = []

    public init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}
