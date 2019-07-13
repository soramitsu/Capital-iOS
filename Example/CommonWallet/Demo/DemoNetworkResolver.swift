/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import CommonWallet
import RobinHood

final class DemoNetworkResolver: WalletNetworkResolverProtocol {
    func urlTemplate(for type: WalletRequestType) -> String {
        switch type {
        case .balance:
            return "https://demowallet.com/balance"
        case .history:
            return "https://demowallet.com/history?offset={offset}&count={count}"
        case .transfer:
            return "https://demowallet.com/transfer"
        case .search:
            return "https://demowallet.com/search?q={search}"
        case .contacts:
            return "https://demowallet.com/contacts"
        }
    }

    func adapter(for type: WalletRequestType) -> NetworkRequestModifierProtocol? {
        return nil
    }
}
