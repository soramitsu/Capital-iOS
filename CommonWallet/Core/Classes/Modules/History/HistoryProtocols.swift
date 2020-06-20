/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

enum HistoryHeaderType {
    case bar
    case hidden
}

typealias HistoryViewModelChange =
    SectionedListDifference<TransactionSectionViewModel, WalletViewModelProtocol>


protocol HistoryViewProtocol: ControllerBackedProtocol, Draggable {
    func reloadContent()
    func handle(changes: [HistoryViewModelChange])
}


protocol HistoryPresenterProtocol: class {
    func setup()
    func reload()
    func loadNext() -> Bool
    func reloadCache()
    func showFilter()

    func numberOfSections() -> Int
    func sectionModel(at index: Int) -> TransactionSectionViewModelProtocol
}


protocol HistoryCoordinatorProtocol: class {
    func presentFilter(filter: WalletHistoryRequest?, assets: [WalletAsset])
}


protocol HistoryAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol,
                             assets: [WalletAsset],
                             type: HistoryHeaderType) -> HistoryViewProtocol?
}


protocol HistoryCoordinatorDelegate: class {
    
    func coordinator(_ coordinator: HistoryCoordinatorProtocol, didReceive filter: WalletHistoryRequest)
    
}
