/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public typealias WalletViewModelFactory = () throws -> WalletViewModelProtocol

public protocol WalletViewModelProtocol: class {
    var cellReuseIdentifier: String { get }
    var itemHeight: CGFloat { get }
    var command: WalletCommandProtocol? { get }
}
