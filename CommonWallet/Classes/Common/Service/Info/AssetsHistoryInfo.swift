/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

struct AssetsHistoryInfo: Encodable {
    var assets: [String]
    var query: Data
}
