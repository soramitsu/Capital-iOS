import Foundation

struct WalletTransactionLimitConstants {
    static var defaultMaxLimit: Decimal { 1e+7 }
}

public struct WalletTransactionLimit {
    public let minimum: Decimal
    public let maximum: Decimal

    public init(minimum: Decimal = 0.0, maximum: Decimal) {
        self.minimum = minimum
        self.maximum = maximum
    }
}

public protocol WalletTransactionSettingsProtocol {
    func limitForAssetId(_ assetId: String,
                         senderId: String?,
                         receiverId: String?) -> WalletTransactionLimit
}

struct WalletTransactionSettings: WalletTransactionSettingsProtocol {
    public let limit: WalletTransactionLimit

    public init(limit: WalletTransactionLimit) {
        self.limit = limit
    }

    func limitForAssetId(_ assetId: String,
                         senderId: String?,
                         receiverId: String?) -> WalletTransactionLimit {
        limit
    }
}

extension WalletTransactionSettings {
    static var defaultSettings: WalletTransactionSettings {
        let limit: Decimal = WalletTransactionLimitConstants.defaultMaxLimit
        return WalletTransactionSettings(limit: WalletTransactionLimit(maximum: limit))
    }
}
