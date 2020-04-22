/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol TransactionHeaderStyleProtocol {
    var background: UIColor { get }
    var title: WalletTextStyleProtocol { get }
    var separatorColor: UIColor { get }
    var separatorWidth: CGFloat { get }
}

public struct TransactionHeaderStyle: TransactionHeaderStyleProtocol {
    public var background: UIColor
    public var title: WalletTextStyleProtocol
    public var separatorColor: UIColor
    public var separatorWidth: CGFloat

    public init(background: UIColor,
                title: WalletTextStyleProtocol,
                separatorColor: UIColor,
                separatorWidth: CGFloat = 1.0) {
        self.background = background
        self.title = title
        self.separatorColor = separatorColor
        self.separatorWidth = separatorWidth
    }
}

extension TransactionHeaderStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> TransactionHeaderStyle {
        return TransactionHeaderStyle(background: .white,
                                      title: WalletTextStyle(font: style.bodyRegularFont, color: .greyText),
                                      separatorColor: style.thickBorderColor)
    }
}
