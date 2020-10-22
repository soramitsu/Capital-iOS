/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

final class HistoryAssembly: HistoryAssemblyProtocol {
    
    static func assembleView(with resolver: ResolverProtocol,
                             assets: [WalletAsset],
                             type: HistoryHeaderType) -> HistoryViewProtocol? {
        let view = HistoryViewController(nibName: "HistoryViewController", bundle: Bundle(for: self))
        view.headerType = type
        view.configuration = resolver.historyConfiguration

        let coordinator = HistoryCoordinator(resolver: resolver)
        
        let dataProviderFactory = DataProviderFactory(accountSettings: resolver.account,
                                                      cacheFacade: CoreDataCacheFacade.shared,
                                                      networkOperationFactory: resolver.networkOperationFactory,
                                                      identifierFactory: resolver.singleValueIdentifierFactory)

        let assetIds = assets.map({ $0.identifier })
        guard
            let transactionDataProvider = try? dataProviderFactory.createHistoryDataProvider(for: assetIds) else {
            return nil
        }

        let dateFormatterFactory = TransactionListSectionFormatterFactory.self
        let dateFormatterProvider = DateFormatterProvider(dateFormatterFactory: dateFormatterFactory,
                                                          dayChangeHandler: DayChangeHandler())

        let includesFeeInAmount = resolver.historyConfiguration.includesFeeInAmount

        let itemViewModelFactory = resolver.historyConfiguration.itemViewModelFactory ??
            HistoryItemViewModelFactory(amountFormatterFactory: resolver.amountFormatterFactory,
                                        includesFeeInAmount: includesFeeInAmount,
                                        transactionTypes: resolver.transactionTypeList,
                                        assets: assets)
        
        let viewModelFactory = HistoryViewModelFactory(dateFormatterProvider: dateFormatterProvider,
                                                       itemViewModelFactory: itemViewModelFactory,
                                                       commandFactory: resolver.commandFactory)

        let walletService = WalletService(operationFactory: resolver.networkOperationFactory)
 
        let presenter = HistoryPresenter(view: view,
                                         coordinator: coordinator,
                                         dataProvider: transactionDataProvider,
                                         walletService: walletService,
                                         eventCenter: resolver.eventCenter,
                                         viewModelFactory: viewModelFactory,
                                         assets: assets,
                                         transactionsPerPage: DataProviderFactory.historyItemsPerPage)
        
        coordinator.delegate = presenter
        
        view.presenter = presenter

        view.localizationManager = resolver.localizationManager
        presenter.localizationManager = resolver.localizationManager

        return view
    }
    
}
