/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class InvoiceScanAssembly: InvoiceScanAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol) -> InvoiceScanViewProtocol? {
        let networkOperationFactory = WalletServiceOperationFactory(accountSettings: resolver.account)
        let networkService = WalletService(networkResolver: resolver.networkResolver,
                                           operationFactory: networkOperationFactory)

        let qrScanServiceFactory = WalletQRCaptureServiceFactory()

        let view = InvoiceScanViewController(nibName: "InvoiceScanViewController", bundle: Bundle(for: self))
        view.style = resolver.invoiceScanConfiguration.viewStyle
        let coordinator = InvoiceScanCoordinator(resolver: resolver)

        let presenter = InvoiceScanPresenter(view: view,
                                             coordinator: coordinator,
                                             qrScanServiceFactory: qrScanServiceFactory,
                                             networkService: networkService,
                                             currentAccountId: resolver.account.accountId)
        presenter.logger = resolver.logger

        view.presenter = presenter

        return view
    }
}
