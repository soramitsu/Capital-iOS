import Foundation

final class AccountListCoordinator: AccountListCoordinatorProtocol {
    
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func send() {
        guard let contactsView = ContactsAssembly.assembleView(with: resolver) else {
            return
        }
        
        resolver.navigation.present(contactsView.controller, inNavigationController: true)
    }
    
    func receive() {
        guard let receiveView = ReceiveAmountAssembly.assembleView(resolver: resolver) else {
            return
        }

        resolver.navigation.present(receiveView.controller, inNavigationController: true)
    }

    func showDetails(for asset: WalletAsset) {
        guard let detailsView = AccountDetailsAssembly.assembleView(with: resolver, asset: asset) else {
            return
        }

        detailsView.controller.hidesBottomBarWhenPushed = true
        resolver.navigation.push(detailsView.controller)
    }
}
