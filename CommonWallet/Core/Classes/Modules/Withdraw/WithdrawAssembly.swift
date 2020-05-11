/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import SoraFoundation

final class WithdrawAssembly: WithdrawAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WithdrawViewProtocol? {

        do {
            let containingFactory = OperationDefinitionViewFactory(style: resolver.withdrawConfiguration.style)
            let view = WithdrawViewController(containingFactory: containingFactory, style: resolver.style)
            view.localizableTitle = LocalizableResource { _ in option.shortTitle }

            let coordinator = WithdrawAmountCoordinator(resolver: resolver)

            let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                          cacheFacade: CoreDataCacheFacade.shared,
                                                          networkOperationFactory: resolver.networkOperationFactory)

            let validatorFactory = resolver.inputValidatorFactory
            let formatterFactory = resolver.amountFormatterFactory
            let feeSettingsFactory = resolver.feeDisplaySettingsFactory
            let transactionFactory = resolver.transactionSettingsFactory

            let viewModelFactory = WithdrawAmountViewModelFactory(amountFormatterFactory: formatterFactory,
                                                                  option: option,
                                                                  descriptionValidatorFactory: validatorFactory,
                                                                  transactionSettingsFactory: transactionFactory,
                                                                  feeDisplaySettingsFactory: feeSettingsFactory)

            let assetSelectionFactory = AssetSelectionFactory(amountFormatterFactory: resolver.amountFormatterFactory)

            let presenter = try WithdrawPresenter(view: view,
                                                        coordinator: coordinator,
                                                        assets: resolver.account.assets,
                                                        selectedAsset: asset,
                                                        selectedOption: option,
                                                        dataProviderFactory: dataProviderFactory,
                                                        feeCalculationFactory: resolver.feeCalculationFactory,
                                                        withdrawViewModelFactory: viewModelFactory,
                                                        assetSelectionFactory: assetSelectionFactory,
                                                        localizationManager: resolver.localizationManager)

            presenter.logger = resolver.logger

            view.presenter = presenter

            view.localizationManager = resolver.localizationManager

            return view
        } catch {
            resolver.logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }
}
