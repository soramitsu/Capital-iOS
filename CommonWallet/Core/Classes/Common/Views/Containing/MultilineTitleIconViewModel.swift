/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol MultilineTitleIconViewModelProtocol {
    var text: String { get }
    var icon: UIImage? { get }
    var command: WalletCommandProtocol? { get }
}

public struct MultilineTitleIconViewModel: MultilineTitleIconViewModelProtocol {
    public let text: String
    public let icon: UIImage?
    public let command: WalletCommandProtocol?

    public init(text: String, icon: UIImage? = nil, command: WalletCommandProtocol? = nil) {
        self.text = text
        self.icon = icon
        self.command = command
    }
}
