/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public typealias ActionsViewModelFactory = (ActionsViewModelDelegate?) throws -> ActionsViewModelProtocol

public protocol ActionsViewModelProtocol: WalletViewModelProtocol {
    var sendTitle: String { get }
    var receiveTitle: String { get }
    var style: ActionsCellStyle { get }

    var delegate: ActionsViewModelDelegate? { get }
}

public protocol ActionsViewModelDelegate: class {
    func didRequestSend(for viewModel: ActionsViewModelProtocol)
    func didRequestReceive(for viewModel: ActionsViewModelProtocol)
}

final class ActionsViewModel: ActionsViewModelProtocol {
    var cellReuseIdentifier: String
    var itemHeight: CGFloat

    var sendTitle: String = "Send"
    var receiveTitle: String = "Receive"
    var style: ActionsCellStyle

    weak var delegate: ActionsViewModelDelegate?

    init(cellReuseIdentifier: String, itemHeight: CGFloat, style: ActionsCellStyle) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.style = style
    }

    func didSelect() {}
}
