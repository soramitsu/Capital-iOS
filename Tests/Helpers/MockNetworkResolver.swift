import Foundation
@testable import CommonWallet
import RobinHood

struct MockNetworkResolver: WalletNetworkResolverProtocol {
    func urlTemplate(for type: WalletRequestType) -> String {
        switch type {
        case .balance:
            return Constants.balanceUrlTemplate
        case .contacts:
            return Constants.contactsUrlTemplate
        case .history:
            return Constants.historyUrlTemplate
        case .search:
            return Constants.searchUrlTemplate
        case .transfer:
            return Constants.transferUrlTemplate
        case .withdraw:
            return Constants.withdrawUrlTemplate
        case .withdrawalMetadata:
            return Constants.withdrawalMetadataUrlTemplate
        }
    }

    func adapter(for type: WalletRequestType) -> NetworkRequestModifierProtocol? {
        return nil
    }
}
