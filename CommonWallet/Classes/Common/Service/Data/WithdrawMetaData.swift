import Foundation

struct WithdrawMetaData: Codable, Equatable {
    var providerAccountId: String
    var feeAccountId: String
    var feeRate: String
}

extension WithdrawMetaData {
    var feeRateDecimal: Decimal? {
        return Decimal(string: feeRate)
    }
}
