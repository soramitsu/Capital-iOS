import Foundation

public struct TransferMetaData: Codable, Equatable {
    var feeAccountId: String?
    var feeType: String
    var feeRate: String
}

public extension TransferMetaData {
    var feeRateDecimal: Decimal? {
        return Decimal(string: feeRate)
    }
}
