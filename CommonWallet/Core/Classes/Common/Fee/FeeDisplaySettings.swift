import Foundation
import SoraFoundation

public protocol FeeDisplaySettingsProtocol {
    var displayStrategy: FeeDisplayStrategyProtocol { get }
    var displayName: LocalizableResource<String> { get }
    var operationTitle: LocalizableResource<String> { get }
}

public protocol FeeDisplaySettingsFactoryProtocol {
    func createFeeSettingsForId(_ feeId: String) -> FeeDisplaySettingsProtocol
}

public struct FeeDisplaySettings: FeeDisplaySettingsProtocol {
    public let displayStrategy: FeeDisplayStrategyProtocol
    public let displayName: LocalizableResource<String>
    public let operationTitle: LocalizableResource<String>

    public init(displayStrategy: FeeDisplayStrategyProtocol,
                displayName: LocalizableResource<String>,
                operationTitle: LocalizableResource<String>) {
        self.displayStrategy = displayStrategy
        self.displayName = displayName
        self.operationTitle = operationTitle
    }
}

extension FeeDisplaySettings {
    static var defaultSettings: FeeDisplaySettings {

        FeeDisplaySettings(displayStrategy: FeedDisplayStrategyIfNonzero(),
                           displayName: LocalizableResource { _ in L10n.Transaction.fee },
                           operationTitle: LocalizableResource { _ in L10n.Transaction.fee })
    }
}

extension FeeDisplaySettingsFactoryProtocol {
    func createFeeSettingsForId(_ feeId: String) -> FeeDisplaySettingsProtocol {
        FeeDisplaySettings.defaultSettings
    }
}

struct FeeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol {}
