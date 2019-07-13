/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class HistoryCoordinator: HistoryCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func presentDetails(for transaction: AssetTransactionData) {
        guard let view = TransactionDetailsAssembly
            .assembleView(resolver: resolver, transactionDetails: transaction) else {
                return
        }

        resolver.navigation.push(view.controller)
    }
}
