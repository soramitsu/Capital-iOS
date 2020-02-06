/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol WalletInputValidatorProtocol: class {
    var input: String { get }
    var hint: String { get }
    var isValid: Bool { get }

    func didReceiveReplacement(_ string: String, for range: NSRange) -> Bool
}
