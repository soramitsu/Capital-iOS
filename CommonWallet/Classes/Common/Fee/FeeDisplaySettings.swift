import Foundation
import IrohaCommunication
import SoraFoundation

public protocol FeeDisplaySettingsProtocol {
    var displayStrategy: FeeDisplayStrategyProtocol { get }
    var displayName: LocalizableResource<String> { get }
    var amountDetailsClosure: (String, Locale) -> String { get }
}

public protocol FeeDisplaySettingsFactoryProtocol {
    func createFeeSettings(asset: WalletAsset,
                           senderId: String?,
                           receiverId: String?) -> FeeDisplaySettingsProtocol
}

public struct FeeDisplaySettings: FeeDisplaySettingsProtocol {
    public let displayStrategy: FeeDisplayStrategyProtocol
    public let displayName: LocalizableResource<String>
    public let amountDetailsClosure: (String, Locale) -> String

    public init(displayStrategy: FeeDisplayStrategyProtocol,
                displayName: LocalizableResource<String>,
                amountDetailsClosure: @escaping (String, Locale) -> String) {
        self.displayStrategy = displayStrategy
        self.displayName = displayName
        self.amountDetailsClosure = amountDetailsClosure
    }
}

extension FeeDisplaySettings {
    static var defaultSettings: FeeDisplaySettings {
        let closure = { (formattedAmount: String, locale: Locale) -> String in
            L10n.Amount.fee(formattedAmount)
        }

        return FeeDisplaySettings(displayStrategy: FeedDisplayStrategyIfNonzero(),
                                  displayName: LocalizableResource { _ in L10n.Transaction.fee },
                                  amountDetailsClosure: closure)
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
