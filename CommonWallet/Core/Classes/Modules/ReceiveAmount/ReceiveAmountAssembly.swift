/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class ReceiveAmountAssembly: ReceiveAmountAssemblyProtocol {
    static func assembleView(resolver: ResolverProtocol,
                             selectedAsset: WalletAsset) -> ReceiveAmountViewProtocol? {

        do {
            let receiveInfo = ReceiveInfo(accountId: resolver.account.accountId,
                                          assetId: selectedAsset.identifier,
                                          amount: nil,
                                          details: nil)

            let containingFactory = ContainingViewFactory(style: resolver.style)
            let view = ReceiveAmountViewController(containingFactory: containingFactory,
                                                   style: resolver.style)

            let coordinator = ReceiveAmountCoordinator(resolver: resolver)

            let assetSelectionFactory = ReceiveAssetSelectionTitleFactory()

            let qrEncoder = resolver.qrCoderFactory.createEncoder()
            let qrService = WalletQRService(operationFactory: WalletQROperationFactory(),
                                            encoder: qrEncoder)

            let inputValidatorFactory = resolver.inputValidatorFactory
            let amountFormatterFactory = resolver.amountFormatterFactory
            let transactionFactory = resolver.transactionSettingsFactory

            let viewModelFactory = ReceiveViewModelFactory(amountFormatterFactory: amountFormatterFactory,
                                                           descriptionValidatorFactory: inputValidatorFactory,
                                                           transactionSettingsFactory: transactionFactory)

            let config = resolver.receiveConfiguration

            let presenter = try ReceiveAmountPresenter(view: view,
                                                       coordinator: coordinator,
                                                       account: resolver.account,
                                                       assetSelectionFactory: assetSelectionFactory,
                                                       qrService: qrService,
                                                       sharingFactory: config.accountShareFactory,
                                                       receiveInfo: receiveInfo,
                                                       viewModelFactory: viewModelFactory,
                                                       shouldIncludeDescription: config.shouldIncludeDescription,
                                                       localizationManager: resolver.localizationManager)
            view.presenter = presenter

            let localizationManager = resolver.localizationManager

            view.localizableTitle = resolver.receiveConfiguration.title
            view.localizationManager = localizationManager

            return view
        } catch {
            resolver.logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }
}
