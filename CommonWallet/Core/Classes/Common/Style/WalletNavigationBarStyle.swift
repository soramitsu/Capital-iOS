/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol WalletNavigationBarStyleProtocol {
    var barColor: UIColor { get }
    var shadowColor: UIColor { get }
    var itemTintColor: UIColor { get }
    var titleColor: UIColor { get }
    var titleFont: UIFont { get }
}

public struct WalletNavigationBarStyle: WalletNavigationBarStyleProtocol, Equatable {
    public let barColor: UIColor
    public let shadowColor: UIColor
    public let itemTintColor: UIColor
    public let titleColor: UIColor
    public let titleFont: UIFont

    public init(barColor: UIColor,
                shadowColor: UIColor,
                itemTintColor: UIColor,
                titleColor: UIColor,
                titleFont: UIFont) {
        self.barColor = barColor
        self.shadowColor = shadowColor
        self.itemTintColor = itemTintColor
        self.titleColor = titleColor
        self.titleFont = titleFont
    }
}
