/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol TransactionItemViewModelProtocol: WalletViewModelProtocol {
    var amount: String { get }
    var title: String { get }
    var incoming: Bool { get }
    var status: AssetTransactionStatus { get }
    var icon: UIImage? { get }
}

final class TransactionItemViewModel: TransactionItemViewModelProtocol {
    let cellReuseIdentifier: String
    let itemHeight: CGFloat
    let amount: String
    let title: String
    let incoming: Bool
    let status: AssetTransactionStatus
    let icon: UIImage?
    let command: WalletCommandProtocol?
    
    init(cellReuseIdentifier: String,
         itemHeight: CGFloat,
         amount: String,
         title: String,
         incoming: Bool,
         status: AssetTransactionStatus,
         icon: UIImage?,
         command: WalletCommandProtocol?) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.amount = amount
        self.title = title
        self.incoming = incoming
        self.status = status
        self.icon = icon
        self.command = command
    }
}

protocol TransactionSectionViewModelProtocol: class {
    var title: String { get }
    var items: [WalletViewModelProtocol] { get }
}

final class TransactionSectionViewModel: TransactionSectionViewModelProtocol {
    var title: String
    var items: [WalletViewModelProtocol]

    init(title: String, items: [WalletViewModelProtocol]) {
        self.title = title
        self.items = items
    }
}
