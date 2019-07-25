import Foundation


final class ReceiveAmountAssembly: ReceiveAmountAssemblyProtocol {
    static func assembleView(resolver: ResolverProtocol) -> ReceiveAmountViewProtocol? {
        guard let defaultAsset = resolver.account.assets.first else {
            return nil
        }

        let receiveInfo = ReceiveInfo(accountId: resolver.account.accountId,
                                      assetId: defaultAsset.identifier,
                                      amount: nil,
                                      details: nil)

        let view = ReceiveAmountViewController(nibName: "ReceiveAmountViewController", bundle: Bundle(for: self))
        view.style = resolver.style

        let coordinator = ReceiveAmountCoordinator(resolver: resolver)

        let assetSelectionFactory = ReceiveAssetSelectionTitleFactory()

        let qrService = WalletQRService(operationFactory: WalletQROperationFactory())

        let presenter = ReceiveAmountPresenter(view: view,
                                               coordinator: coordinator,
                                               account: resolver.account,
                                               assetSelectionFactory: assetSelectionFactory,
                                               qrService: qrService,
                                               receiveInfo: receiveInfo,
                                               amountLimit: resolver.transferAmountLimit)
        view.presenter = presenter

        return view
    }
}
