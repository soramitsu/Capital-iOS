/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

typealias HistoryViewModelChange =
    SectionedListDifference<TransactionSectionViewModel, TransactionItemViewModel>

protocol HistoryViewProtocol: ControllerBackedProtocol, Draggable {
    func didReload()
    func didReceive(changes: [HistoryViewModelChange])
}

protocol HistoryPresenterProtocol: class {
    func setup()
    func reload()
    func loadNext() -> Bool
    func viewDidAppear()

    func numberOfSections() -> Int
    func sectionModel(at index: Int) -> TransactionSectionViewModelProtocol
    func didSelectModel(at index: Int, in section: Int)
}

protocol HistoryCoordinatorProtocol: class {
    func presentDetails(for transaction: AssetTransactionData)
}

protocol HistoryAssemblyProtocol: class {
	static func assembleView(with resolver: ResolverProtocol) -> HistoryViewProtocol?
}
