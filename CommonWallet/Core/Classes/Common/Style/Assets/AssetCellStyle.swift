/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public enum AssetCellStyle {
    case card(_ style: CardAssetStyle)
}

public struct CardAssetStyle {
    public var backgroundColor: UIColor
    public var leftFillColor: UIColor
    public var symbol: WalletTextStyleProtocol
    public var title: WalletTextStyleProtocol
    public var subtitle: WalletTextStyleProtocol
    public var accessory: WalletTextStyleProtocol
    public var shadow: WalletShadowStyleProtocol
    public var cornerRadius: CGFloat

    public init(backgroundColor: UIColor,
                leftFillColor: UIColor,
                symbol: WalletTextStyleProtocol,
                title: WalletTextStyleProtocol,
                subtitle: WalletTextStyleProtocol,
                accessory: WalletTextStyleProtocol,
                shadow: WalletShadowStyleProtocol,
                cornerRadius: CGFloat) {
        self.backgroundColor = backgroundColor
        self.leftFillColor = leftFillColor
        self.symbol = symbol
        self.title = title
        self.subtitle = subtitle
        self.accessory = accessory
        self.shadow = shadow
        self.cornerRadius = cornerRadius
    }
}

extension CardAssetStyle {
    static func createDefaultCardStyle(with style: WalletStyleProtocol) -> CardAssetStyle {
        let shadow = WalletShadowStyle(offset: CGSize(width: 0.0, height: 5.0),
                                       color: style.bodyTextColor,
                                       opacity: 0.04,
                                       blurRadius: 4.0)

        return CardAssetStyle(backgroundColor: .white,
                              leftFillColor: .accentColor,
                              symbol: WalletTextStyle(font: style.header2Font, color: .white),
                              title: WalletTextStyle(font: style.header2Font, color: style.bodyTextColor),
                              subtitle: WalletTextStyle(font: style.bodyRegularFont, color: .greyText),
                              accessory: WalletTextStyle(font: style.bodyRegularFont, color: .greyText),
                              shadow: shadow,
                              cornerRadius: 10.0)
    }
}
