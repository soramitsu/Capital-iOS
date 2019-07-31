import Foundation

struct WithdrawalData: Codable, Equatable {
    var accountId: String
    var feeRate: String
}

extension WithdrawalData {
    var feeRateDecimal: Decimal? {
        return Decimal(string: feeRate)
    }
}
