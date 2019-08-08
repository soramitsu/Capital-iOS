/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

extension CharacterSet {
    static var hexAddress: CharacterSet {
        return CharacterSet(charactersIn: "0123456789xabcdefABCDEF")
    }
}
