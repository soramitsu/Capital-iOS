/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

public struct WalletWithdrawOption {
    let identifier: String
    let symbol: String
    let shortTitle: String
    let longTitle: String
    let details: String
    let icon: UIImage?

    public init(identifier: String,
                symbol: String,
                shortTitle: String,
                longTitle: String,
                details: String,
                icon: UIImage?) {
        self.identifier = identifier
        self.symbol = symbol
        self.shortTitle = shortTitle
        self.longTitle = longTitle
        self.details = details
        self.icon = icon
    }
}
