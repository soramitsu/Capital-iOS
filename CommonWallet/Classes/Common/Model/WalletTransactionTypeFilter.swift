/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

struct WalletTransactionTypeFilter: Equatable {
    let backendName: String
    let displayName: String
}

extension WalletTransactionTypeFilter {
    static var all: WalletTransactionTypeFilter {
        return WalletTransactionTypeFilter(backendName: "ALL", displayName: L10n.Common.all)
    }
}

extension WalletTransactionTypeFilter {
    static func createAllFilters(from transactionTypes: [WalletTransactionType]) -> [WalletTransactionTypeFilter] {
        return transactionTypes.reduce(into: [WalletTransactionTypeFilter.all]) { (result, type) in
            let typeFilter = WalletTransactionTypeFilter(backendName: type.backendName,
                                                         displayName: type.displayName)
            return result.append(typeFilter)
        }
    }
}
