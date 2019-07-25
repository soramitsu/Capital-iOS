import Foundation


final class ConfirmationAssembly: ConfirmationAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol, payload: TransferPayload) -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.loadingViewFactory = WalletLoadingOverlayFactory(style: resolver.style.loadingOverlayStyle)
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style
        view.title = "Confirmation"
        
        let coordinator = ConfirmationCoordinator(resolver: resolver)
        
        let operationFactory = WalletServiceOperationFactory(accountSettings: resolver.account)
        
        let walletService = WalletService(networkResolver: resolver.networkResolver,
                                          operationFactory: operationFactory)

        let accessoryViewModelFactory = ContactAccessoryViewModelFactory(style: resolver.style.nameIconStyle,
                                                                         radius: AccessoryView.iconRadius)

        let presenter = ConfirmationPresenter(view: view,
                                              coordinator: coordinator,
                                              service: walletService,
                                              resolver: resolver,
                                              payload: payload,
                                              accessoryViewModelFactory: accessoryViewModelFactory)

        presenter.logger = resolver.logger

        view.presenter = presenter

        return view
    }
    
}
