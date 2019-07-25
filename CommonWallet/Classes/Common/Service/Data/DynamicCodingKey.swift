import Foundation

public struct DynamicCodingKey: CodingKey {
    public var stringValue: String

    public init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = Int(stringValue)
    }

    public var intValue: Int?

    public init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
}
