import Foundation

struct BalanceQueryInfo: Codable {
    var assets: [String]
    var query: Data
}
