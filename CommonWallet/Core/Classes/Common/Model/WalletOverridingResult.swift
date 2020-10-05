/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct WalletOverridingResult<T> {
    public let item: T

    public init(item: T) {
        self.item = item
    }
}
