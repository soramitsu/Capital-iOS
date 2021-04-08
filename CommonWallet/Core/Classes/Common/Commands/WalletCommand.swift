/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

typealias CommandCompletionBlock = () -> ()

public protocol WalletCommandProtocol: class {
    func execute() throws
}
