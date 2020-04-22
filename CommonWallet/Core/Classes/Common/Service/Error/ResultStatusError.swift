/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

struct ResultStatusError: Error {
    var code: String
    var message: String

    init(statusData: StatusData) {
        code = statusData.code
        message = statusData.message
    }
}
