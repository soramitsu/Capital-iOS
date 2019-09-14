/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class HistoryAssembly: HistoryAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol,
                             assets: [WalletAsset],
                             type: HistoryHeaderType) -> HistoryViewProtocol? {
        let view = HistoryViewController(nibName: "HistoryViewController", bundle: Bundle(for: self))
        view.headerType = type
        view.configuration = resolver.historyConfiguration

        let coordinator = HistoryCoordinator(resolver: resolver)

        let networkOperationFactory = WalletServiceOperationFactory(accountSettings: resolver.account)
        
        let dataProviderFactory = DataProviderFactory(networkResolver: resolver.networkResolver,
                                                      accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: networkOperationFactory)

        let assetIds = assets.map({ $0.identifier })
        guard
            let transactionDataProvider = try? dataProviderFactory.createHistoryDataProvider(for: assetIds) else {
            return nil
        }

        let dateFormatterFactory = TransactionListSectionFormatterFactory.self
        let dateFormatterProvider = DateFormatterProvider(dateFormatterFactory: dateFormatterFactory,
                                                          dayChangeHandler: DayChangeHandler())

        let viewModelFactory = HistoryViewModelFactory(dateFormatterProvider: dateFormatterProvider,
                                                       amountFormatter: resolver.amountFormatter,
                                                       assets: assets)

        let walletService = WalletService(networkResolver: resolver.networkResolver,
                                          operationFactory: networkOperationFactory)
 
        let presenter = HistoryPresenter(view: view,
                                         coordinator: coordinator,
                                         dataProvider: transactionDataProvider,
                                         walletService: walletService,
                                         viewModelFactory: viewModelFactory,
                                         assets: assets,
                                         transactionsPerPage: DataProviderFactory.historyItemsPerPage)
        
        coordinator.delegate = presenter
        
        view.presenter = presenter

        return view
    }
    
}
