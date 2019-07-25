import Foundation

struct AssetsHistoryInfo: Encodable {
    var assets: [String]
    var query: Data
}
