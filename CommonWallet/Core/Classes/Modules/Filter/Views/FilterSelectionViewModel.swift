/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class FilterSelectionViewModel: WalletViewModelProtocol {
    
    let cellReuseIdentifier: String = FilterConstants.selectableCellIdentifier
    let itemHeight: CGFloat = 56
    
    private(set) var selected: Bool = false
    private(set) var title: String
    private(set) var action: FilterSelectionAction
    private(set) var index: Int
    
    init(title: String, index: Int, action: @escaping FilterSelectionAction) {
        self.title = title
        self.index = index
        self.action = action
    }
    
    init(title: String, selected: Bool, index: Int, action: @escaping FilterSelectionAction) {
        self.title = title
        self.index = index
        self.selected = selected
        self.action = action
    }
}

extension FilterSelectionViewModel: WalletCommandProtocol {
    var command: WalletCommandProtocol? { return self }

    func execute() throws {
        action(index)
    }
}
