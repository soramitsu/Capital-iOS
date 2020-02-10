import Foundation
import IrohaCommunication
import SoraFoundation

public protocol FeeDisplaySettingsProtocol {
    var displayStrategy: FeeDisplayStrategyProtocol { get }
    var displayName: LocalizableResource<String> { get }
    var amountDetails: LocalizableResource<String> { get }
}

public protocol FeeDisplaySettingsFactoryProtocol {
    func createFeeSettings(asset: WalletAsset,
                           senderId: String?,
                           receiverId: String?) -> FeeDisplaySettingsProtocol
}

public struct FeeDisplaySettings: FeeDisplaySettingsProtocol {
    public let displayStrategy: FeeDisplayStrategyProtocol
    public let displayName: LocalizableResource<String>
    public let amountDetails: LocalizableResource<String>

    public init(displayStrategy: FeeDisplayStrategyProtocol,
                displayName: LocalizableResource<String>,
                amountDetails: LocalizableResource<String>) {
        self.displayStrategy = displayStrategy
        self.displayName = displayName
        self.amountDetails = amountDetails
    }
}

extension FeeDisplaySettings {
    static var defaultSettings: FeeDisplaySettings {
        FeeDisplaySettings(displayStrategy: FeedDisplayStrategyIfNonzero(),
                           displayName: LocalizableResource { _ in L10n.Transaction.fee },
                           amountDetails: LocalizableResource { _ in L10n.Amount.fee })
    }
}

extension FeeDisplaySettingsFactoryProtocol {
    func createFeeSettings(asset: WalletAsset,
                           senderId: String?,
                           receiverId: String?) -> FeeDisplaySettingsProtocol {
        FeeDisplaySettings.defaultSettings
    }
}

struct FeeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol {}
