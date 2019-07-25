import Foundation
import RobinHood

public protocol WalletNetworkResolverProtocol {
    func urlTemplate(for type: WalletRequestType) -> String
    func adapter(for type: WalletRequestType) -> NetworkRequestModifierProtocol?
}
