/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol ActionsViewModelProtocol: WalletViewModelProtocol {
    var sendTitle: String { get }
    var receiveTitle: String { get }
    var style: ActionsCellStyle { get }

    var sendCommand: WalletCommandProtocol { get }
    var receiveCommand: WalletCommandProtocol { get }
}

final class ActionsViewModel: ActionsViewModelProtocol {
    var cellReuseIdentifier: String
    var itemHeight: CGFloat

    var command: WalletCommandProtocol? { return nil }

    var sendTitle: String = "Send"
    var receiveTitle: String = "Receive"
    var style: ActionsCellStyle

    var sendCommand: WalletCommandProtocol
    var receiveCommand: WalletCommandProtocol

    init(cellReuseIdentifier: String,
         itemHeight: CGFloat,
         style: ActionsCellStyle,
         sendCommand: WalletCommandProtocol,
         receiveCommand: WalletCommandProtocol) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.style = style
        self.sendCommand = sendCommand
        self.receiveCommand = receiveCommand
    }
}
