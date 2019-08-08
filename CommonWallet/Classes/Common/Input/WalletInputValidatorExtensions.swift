/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public extension WalletDefaultInputValidator {
    static var ethereumAddress: WalletDefaultInputValidator {
        let format = "0x[A-Fa-f0-9]{40}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)

        return WalletDefaultInputValidator(hint: "42 lowercase hex symbols starting with 0x",
                                           maxLength: 42,
                                           validCharset: CharacterSet.hexAddress,
                                           predicate: predicate)
    }
}
