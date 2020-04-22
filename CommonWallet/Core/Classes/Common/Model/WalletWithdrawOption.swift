/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

public struct WalletWithdrawOption {
    public let identifier: String
    public let symbol: String
    public let shortTitle: String
    public let longTitle: String
    public let details: String
    public let icon: UIImage?

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
