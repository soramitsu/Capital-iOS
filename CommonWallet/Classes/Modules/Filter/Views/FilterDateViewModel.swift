/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class FilterDateViewModel: WalletViewModelProtocol {
    
    let cellReuseIdentifier: String = FilterConstants.dateCellIdentifier
    let itemHeight: CGFloat = 56
    
    private(set) var dateString: String?
    private(set) var title: String
    private var action: () -> Void
    
    init(title: String, dateString: String?, action: @escaping () -> Void) {
        self.title = title
        self.dateString = dateString
        self.action = action
    }
}

extension FilterDateViewModel: WalletCommandProtocol {
    var command: WalletCommandProtocol? { return self }

    func execute() throws {
        action()
    }
}
