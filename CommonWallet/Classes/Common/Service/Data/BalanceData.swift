import Foundation

public struct BalanceData: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case balance
    }

    var identifier: String
    var balance: String
}
