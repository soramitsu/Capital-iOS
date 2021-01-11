/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class InvoiceScanAssembly: InvoiceScanAssemblyProtocol {
    static func assembleView(with resolver: ResolverProtocol) -> InvoiceScanViewProtocol? {
        let networkService = WalletService(operationFactory: resolver.networkOperationFactory)

        let qrScanServiceFactory = WalletQRCaptureServiceFactory()

        let config = resolver.invoiceScanConfiguration

        let view = InvoiceScanViewController(nibName: "InvoiceScanViewController", bundle: Bundle(for: self))
        view.style = config.viewStyle
        let coordinator = InvoiceScanCoordinator(resolver: resolver)

        let presenter = InvoiceScanPresenter(view: view,
                                             coordinator: coordinator,
                                             currentAccountId: resolver.account.accountId,
                                             networkService: networkService,
                                             localSearchEngine: config.localSearchEngine,
                                             qrScanServiceFactory: qrScanServiceFactory,
                                             qrCoderFactory: resolver.qrCoderFactory,
                                             localizationManager: resolver.localizationManager)

        if resolver.invoiceScanConfiguration.supportsUpload {
            view.showsUpload = true
            presenter.qrExtractionService = WalletQRExtractionService(processingQueue: .global())
        } else {
            view.showsUpload = false
        }

        presenter.logger = resolver.logger

        view.presenter = presenter

        view.localizationManager = resolver.localizationManager

        return view
    }
}
