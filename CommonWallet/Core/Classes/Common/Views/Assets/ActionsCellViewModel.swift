/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol ActionViewModelProtocol: class {
    var title: String { get }
    var style: WalletTextStyleProtocol { get }
    var command: WalletCommandProtocol { get }
}

public protocol ActionsViewModelProtocol: WalletViewModelProtocol {
    var send: ActionViewModelProtocol { get }
    var receive: ActionViewModelProtocol { get }
}

final class ActionViewModel: ActionViewModelProtocol {
    var title: String
    var style: WalletTextStyleProtocol
    var command: WalletCommandProtocol

    init(title: String, style: WalletTextStyleProtocol, command: WalletCommandProtocol) {
        self.title = title
        self.style = style
        self.command = command
    }
}

final class ActionsViewModel: ActionsViewModelProtocol {
    var cellReuseIdentifier: String
    var itemHeight: CGFloat

    var command: WalletCommandProtocol? { return nil }

    var send: ActionViewModelProtocol
    var receive: ActionViewModelProtocol

    init(cellReuseIdentifier: String,
         itemHeight: CGFloat,
         sendViewModel: ActionViewModelProtocol,
         receiveViewModel: ActionViewModelProtocol) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.send = sendViewModel
        self.receive = receiveViewModel
    }
}
