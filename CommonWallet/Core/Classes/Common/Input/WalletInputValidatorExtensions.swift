/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public extension WalletDefaultInputValidator {
    static var ethereumAddress: WalletDefaultInputValidator {
        let format = "0x[A-Fa-f0-9]{40}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)

        let maxLength: UInt8 = 42
        return WalletDefaultInputValidator(hint: L10n.Common.Input.validatorHint("\(maxLength)"),
                                           maxLength: maxLength,
                                           validCharset: CharacterSet.hexAddress,
                                           predicate: predicate)
    }
}
