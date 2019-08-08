/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

public struct WalletWithdrawOption {
    public let identifier: String
    public let symbol: String
    public let title: String
    public let details: String
    public let descriptionPlaceholder: String?
    public let icon: UIImage?

    public init(identifier: String,
                symbol: String,
                title: String,
                details: String,
                descriptionPlaceholder: String?,
                icon: UIImage?) {
        self.identifier = identifier
        self.symbol = symbol
        self.title = title
        self.details = details
        self.descriptionPlaceholder = descriptionPlaceholder
        self.icon = icon
    }
}
