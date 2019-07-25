/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

struct Constants {
    static let balanceUrlTemplate = "https://wallet.com/balance"
    static let historyUrlTemplate = "https://wallet.com/history?offset={offset}&count={count}"
    static let searchUrlTemplate = "https://wallet.com/search?search={search}"
    static let transferUrlTemplate = "https://wallet.com/transfer"
    static let contactsUrlTemplate = "https://wallet.com/contacts"
    static let soraAssetId: String = "sora#demo"
    static let invoiceAccountId: String = "invoice@demo"
    static let networkTimeout: TimeInterval = 10.0
}
