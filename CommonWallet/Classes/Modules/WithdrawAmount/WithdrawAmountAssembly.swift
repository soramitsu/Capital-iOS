/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

final class WithdrawAmountAssembly: WithdrawAmountAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WithdrawAmountViewProtocol? {

        do {
            let view = WithdrawAmountViewController(nibName: "WithdrawAmountViewController", bundle: Bundle(for: self))
            view.style = resolver.style

            let coordinator = WithdrawAmountCoordinator(resolver: resolver)

            let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                          cacheFacade: CoreDataCacheFacade.shared,
                                                          networkOperationFactory: resolver.networkOperationFactory)

            let amountFormatter = resolver.amountFormatter

            let limit = resolver.transferAmountLimit
            let validatorFactory = resolver.inputValidatorFactory
            let withdrawViewModelFactory = WithdrawAmountViewModelFactory(amountFormatter: amountFormatter,
                                                                          option: option,
                                                                          amountLimit: limit,
                                                                          descriptionValidatorFactory: validatorFactory)
            let assetTitleFactory = AssetSelectionFactory(amountFormatter: amountFormatter)

            let presenter = try WithdrawAmountPresenter(view: view,
                                                        coordinator: coordinator,
                                                        assets: resolver.account.assets,
                                                        selectedAsset: asset,
                                                        selectedOption: option,
                                                        dataProviderFactory: dataProviderFactory,
                                                        feeCalculationFactory: resolver.feeCalculationFactory,
                                                        withdrawViewModelFactory: withdrawViewModelFactory,
                                                        assetTitleFactory: assetTitleFactory)

            presenter.logger = resolver.logger

            view.presenter = presenter

            view.localizationManager = resolver.localizationManager
            presenter.localizationManager = resolver.localizationManager

            return view
        } catch {
            resolver.logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }
}
