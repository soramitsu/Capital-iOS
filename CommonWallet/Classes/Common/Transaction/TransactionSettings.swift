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

public struct WalletTransactionSettings {
    public let transferLimit: WalletTransactionLimit
    public let withdrawLimit: WalletTransactionLimit

    public init(transferLimit: WalletTransactionLimit, withdrawLimit: WalletTransactionLimit) {
        self.transferLimit = transferLimit
        self.withdrawLimit = withdrawLimit
    }
}

public protocol WalletTransactionSettingsFactoryProtocol {
    func createSettings(for asset: WalletAsset, senderId: String?, receiverId: String?) -> WalletTransactionSettings
}

public extension WalletTransactionSettingsFactoryProtocol {
    func createSettings(for asset: WalletAsset, senderId: String?, receiverId: String?) -> WalletTransactionSettings {
        let limit: Decimal = WalletTransactionLimitConstants.defaultMaxLimit

        return WalletTransactionSettings(transferLimit: WalletTransactionLimit(maximum: limit),
                                         withdrawLimit: WalletTransactionLimit(maximum: limit))
    }
}

public struct WalletTransactionSettingsFactory: WalletTransactionSettingsFactoryProtocol {}
