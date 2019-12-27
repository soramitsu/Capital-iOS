/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class TransferResultAssembly: TransferResultAssemblyProtocol {
    static func assembleView(resolver: ResolverProtocol, transferPayload: TransferPayload) -> WalletFormViewProtocol? {
        let view = WalletFormViewController(nibName: "WalletFormViewController", bundle: Bundle(for: self))
        view.accessoryViewFactory = AccessoryViewFactory.self
        view.style = resolver.style
        view.title = L10n.Transaction.done

        let localizationManager = resolver.localizationManager
        localizationManager?.addObserver(with: view) { [weak view] (_, _) in
            view?.title = L10n.Transaction.done
        }

        let coordinator = TransferResultCoordinator(resolver: resolver)

        let presenter = TransferResultPresenter(view: view,
                                                coordinator: coordinator,
                                                payload: transferPayload,
                                                resolver: resolver)
        view.presenter = presenter

        presenter.localizationManager = localizationManager

        return view
    }
}
