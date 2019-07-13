/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class HistoryAssembly: HistoryAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol) -> HistoryViewProtocol? {
        let view = HistoryViewController(nibName: "HistoryViewController", bundle: Bundle(for: self))
        view.configuration = resolver.historyConfiguration

        let coordinator = HistoryCoordinator(resolver: resolver)

        let networkOperationFactory = WalletServiceOperationFactory(accountSettings: resolver.account)
        
        let dataProviderFactory = DataProviderFactory(networkResolver: resolver.networkResolver,
                                                      accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: networkOperationFactory)
        
        guard let transactionDataProvider = try? dataProviderFactory.createAccountHistoryDataProvider() else {
            return nil
        }

        let viewModelFactory = HistoryViewModelFactory(dateFormatter: resolver.historyDateFormatter,
                                                       amountFormatter: resolver.amountFormatter,
                                                       assets: resolver.account.assets)

        let walletService = WalletService(networkResolver: resolver.networkResolver,
                                          operationFactory: networkOperationFactory)
 
        let presenter = HistoryPresenter(view: view,
                                         coordinator: coordinator,
                                         dataProvider: transactionDataProvider,
                                         walletService: walletService,
                                         viewModelFactory: viewModelFactory,
                                         assets: resolver.account.assets.map({ $0.identifier }),
                                         transactionsPerPage: DataProviderFactory.historyItemsPerPage)
        view.presenter = presenter

        return view
    }
    
}
