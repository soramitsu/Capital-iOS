/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class HistoryFilterDateViewModel: WalletViewModelProtocol {
    
    let cellReuseIdentifier: String = HistoryFilterConstants.dateCellIdentifier
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

extension HistoryFilterDateViewModel: WalletCommandProtocol {
    var command: WalletCommandProtocol? { return self }

    func execute() throws {
        action()
    }
}
