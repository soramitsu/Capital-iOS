/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

final class WithdrawAmountAssembly: WithdrawAmountAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WithdrawAmountViewProtocol? {
        let view = WithdrawAmountViewController(nibName: "WithdrawAmountViewController", bundle: Bundle(for: self))
        view.style = resolver.style

        let coordinator = WithdrawAmountCoordinator(resolver: resolver)

        let networkFactory = WalletServiceOperationFactory(accountSettings: resolver.account)

        let dataProviderFactory = DataProviderFactory(networkResolver: resolver.networkResolver,
                                                      accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: networkFactory)

        let amountFormatter = resolver.amountFormatter
        let maxLength = resolver.transferDescriptionLimit
        let limit = resolver.transferAmountLimit
        let withdrawViewModelFactory = WithdrawAmountViewModelFactory(amountFormatter: amountFormatter,
                                                                      option: option,
                                                                      amountLimit: limit,
                                                                      descriptionMaxLength: maxLength)
        let assetTitleFactory = AssetSelectionFactory(amountFormatter: amountFormatter)

        guard let presenter = try? WithdrawAmountPresenter(view: view,
                                                           coordinator: coordinator,
                                                           assets: resolver.account.assets,
                                                           selectedAsset: asset,
                                                           selectedOption: option,
                                                           dataProviderFactory: dataProviderFactory,
                                                           withdrawViewModelFactory: withdrawViewModelFactory,
                                                           assetTitleFactory: assetTitleFactory) else {
                                                            return nil
        }

        presenter.logger = resolver.logger

        view.presenter = presenter

        return view
    }
}
