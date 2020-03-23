/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

final class WithdrawAmountAssembly: WithdrawAmountAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> AmountViewProtocol? {

        do {
            let containingFactory = ContainingViewFactory(style: resolver.style)
            let view = AmountViewController(containingFactory: containingFactory, style: resolver.style)

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

            let assetTitleFactory = AssetSelectionFactory(amountFormatterFactory: resolver.amountFormatterFactory)

            let presenter = try WithdrawAmountPresenter(view: view,
                                                        coordinator: coordinator,
                                                        assets: resolver.account.assets,
                                                        selectedAsset: asset,
                                                        selectedOption: option,
                                                        dataProviderFactory: dataProviderFactory,
                                                        feeCalculationFactory: resolver.feeCalculationFactory,
                                                        withdrawViewModelFactory: viewModelFactory,
                                                        assetTitleFactory: assetTitleFactory,
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
