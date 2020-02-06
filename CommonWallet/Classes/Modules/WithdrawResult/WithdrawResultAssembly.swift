/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class WithdrawResultAssembly: WithdrawResultAssemblyProtocol {
    static func assembleView(for resolver: ResolverProtocol,
                             info: WithdrawInfo,
                             asset: WalletAsset,
                             option: WalletWithdrawOption) -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style

        view.title = L10n.Transaction.done

        let localizationManager = resolver.localizationManager
        localizationManager?.addObserver(with: view) { [weak view] (_, _) in
            view?.title = L10n.Transaction.done
        }
        
        let coordinator = WithdrawResultCoordinator(resolver: resolver)

        let amountFormatter = resolver.amountFormatterFactory.createDisplayFormatter(for: asset)

        let presenter = WithdrawResultPresenter(view: view,
                                                coordinator: coordinator,
                                                withdrawInfo: info,
                                                asset: asset,
                                                withdrawOption: option,
                                                style: resolver.style,
                                                amountFormatter: amountFormatter,
                                                dateFormatter: resolver.statusDateFormatter,
                                                feeDisplayStrategy: resolver.feeDisplayStrategy)
        view.presenter = presenter

        presenter.localizationManager = localizationManager

        return view
    }
}
