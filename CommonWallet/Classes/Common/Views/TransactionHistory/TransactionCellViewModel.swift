/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol TransactionItemViewModelProtocol: class {
    var transactionId: String { get }
    var amount: String { get }
    var title: String { get }
    var incoming: Bool { get }
    var status: AssetTransactionStatus { get }
    var icon: UIImage? { get }
}

final class TransactionItemViewModel: TransactionItemViewModelProtocol {
    var transactionId: String
    var amount: String = ""
    var title: String = ""
    var incoming: Bool = false
    var status: AssetTransactionStatus = .commited
    var icon: UIImage?
    
    init(transactionId: String) {
        self.transactionId = transactionId
    }
}

protocol TransactionSectionViewModelProtocol: class {
    var title: String { get }
    var items: [TransactionItemViewModelProtocol] { get }
}

final class TransactionSectionViewModel: TransactionSectionViewModelProtocol {
    var title: String
    var items: [TransactionItemViewModelProtocol]

    init(title: String, items: [TransactionItemViewModelProtocol]) {
        self.title = title
        self.items = items
    }
}
