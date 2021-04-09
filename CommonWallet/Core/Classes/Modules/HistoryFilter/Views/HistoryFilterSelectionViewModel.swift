/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class HistoryFilterSelectionViewModel: WalletViewModelProtocol {
    
    let cellReuseIdentifier: String = HistoryFilterConstants.selectableCellIdentifier
    let itemHeight: CGFloat = 56
    
    private(set) var selected: Bool = false
    private(set) var title: String
    private(set) var action: HistoryFilterSelectionAction
    private(set) var index: Int
    
    init(title: String, index: Int, action: @escaping HistoryFilterSelectionAction) {
        self.title = title
        self.index = index
        self.action = action
    }
    
    init(title: String, selected: Bool, index: Int, action: @escaping HistoryFilterSelectionAction) {
        self.title = title
        self.index = index
        self.selected = selected
        self.action = action
    }
}

extension HistoryFilterSelectionViewModel: WalletCommandProtocol {
    var command: WalletCommandProtocol? { return self }

    func execute() throws {
        action(index)
    }
}
