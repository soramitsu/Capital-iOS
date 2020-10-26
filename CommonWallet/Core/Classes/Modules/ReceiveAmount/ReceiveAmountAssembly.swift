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

            let config = resolver.receiveConfiguration

            let containingFactory = ContainingViewFactory(style: resolver.style)
            let view = ReceiveAmountViewController(containingFactory: containingFactory,
                                                   customViewFactory: config.viewFactory,
                                                   viewStyle: config.receiveStyle,
                                                   style: resolver.style)

            let coordinator = ReceiveAmountCoordinator(resolver: resolver)

            let qrEncoder = resolver.qrCoderFactory.createEncoder()
            let qrService = WalletQRService(operationFactory: WalletQROperationFactory(),
                                            encoder: qrEncoder)

            let inputValidatorFactory = resolver.inputValidatorFactory
            let amountFormatterFactory = resolver.amountFormatterFactory
            let settings = resolver.receiveConfiguration.settings

            let viewModelFactory = ReceiveViewModelFactory(amountFormatterFactory: amountFormatterFactory,
                                                           descriptionValidatorFactory: inputValidatorFactory,
                                                           transactionSettings: settings)

            let eligibleAssets = resolver.account.assets.filter { $0.modes.contains(.transfer) }

            let presenter = try ReceiveAmountPresenter(view: view,
                                                       coordinator: coordinator,
                                                       assets: eligibleAssets,
                                                       accountId: resolver.account.accountId,
                                                       qrService: qrService,
                                                       sharingFactory: config.accountShareFactory,
                                                       receiveInfo: receiveInfo,
                                                       viewModelFactory: viewModelFactory,
                                                       fieldsInclusion: config.fieldsInclusion,
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
