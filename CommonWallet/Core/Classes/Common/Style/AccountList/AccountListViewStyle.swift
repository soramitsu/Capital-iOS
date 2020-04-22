/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol AccountListViewStyleProtocol {
    var refreshIndicatorStyle: UIColor { get }
}

public struct AccountListViewStyle: AccountListViewStyleProtocol {
    public var refreshIndicatorStyle: UIColor

    public init(refreshIndicatorStyle: UIColor) {
        self.refreshIndicatorStyle = refreshIndicatorStyle
    }
}

extension AccountListViewStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> AccountListViewStyle {
        return AccountListViewStyle(refreshIndicatorStyle: .greyText)
    }
}
