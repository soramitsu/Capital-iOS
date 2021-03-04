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
    var upppercased: Bool { get }
}

public struct TransactionHeaderStyle: TransactionHeaderStyleProtocol {
    public let background: UIColor
    public let title: WalletTextStyleProtocol
    public let separatorColor: UIColor
    public let separatorWidth: CGFloat
    public let upppercased: Bool

    public init(background: UIColor,
                title: WalletTextStyleProtocol,
                separatorColor: UIColor,
                separatorWidth: CGFloat = 1.0,
                upppercased: Bool = false) {
        self.background = background
        self.title = title
        self.separatorColor = separatorColor
        self.separatorWidth = separatorWidth
        self.upppercased = upppercased
    }
}

extension TransactionHeaderStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> TransactionHeaderStyle {
        return TransactionHeaderStyle(background: .white,
                                      title: WalletTextStyle(font: style.bodyRegularFont, color: .greyText),
                                      separatorColor: style.thickBorderColor)
    }
}
