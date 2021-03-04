/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public protocol ContactsViewStyleProtocol {
    var backgroundColor: UIColor { get }
    var searchHeaderBackgroundColor: UIColor { get }
    var searchTextStyle: WalletTextStyleProtocol { get }
    var searchPlaceholderStyle: WalletTextStyleProtocol { get }
    var searchIndicatorStyle: UIColor { get }
    var searchFieldStyle: WalletRoundedViewStyleProtocol { get }
    var searchIcon: UIImage? { get }
    var searchSeparatorColor: UIColor { get }
    var tableSeparatorColor: UIColor { get }
    var actionsSeparator: WalletStrokeStyleProtocol { get }
}


public struct ContactsViewStyle: ContactsViewStyleProtocol {
    public let backgroundColor: UIColor
    public let searchHeaderBackgroundColor: UIColor
    public let searchTextStyle: WalletTextStyleProtocol
    public let searchPlaceholderStyle: WalletTextStyleProtocol
    public let searchFieldStyle: WalletRoundedViewStyleProtocol
    public let searchIndicatorStyle: UIColor
    public let searchIcon: UIImage?
    public let searchSeparatorColor: UIColor
    public let tableSeparatorColor: UIColor
    public let actionsSeparator: WalletStrokeStyleProtocol

    public init(backgroundColor: UIColor,
                searchHeaderBackgroundColor: UIColor,
                searchTextStyle: WalletTextStyleProtocol,
                searchPlaceholderStyle: WalletTextStyleProtocol,
                searchFieldStyle: WalletRoundedViewStyleProtocol,
                searchIndicatorStyle: UIColor,
                searchIcon: UIImage?,
                searchSeparatorColor: UIColor,
                tableSeparatorColor: UIColor,
                actionsSeparator: WalletStrokeStyleProtocol) {
        self.backgroundColor = backgroundColor
        self.searchTextStyle = searchTextStyle
        self.searchHeaderBackgroundColor = searchHeaderBackgroundColor
        self.searchPlaceholderStyle = searchPlaceholderStyle
        self.searchFieldStyle = searchFieldStyle
        self.searchIndicatorStyle = searchIndicatorStyle
        self.searchIcon = searchIcon
        self.searchSeparatorColor = searchSeparatorColor
        self.tableSeparatorColor = tableSeparatorColor
        self.actionsSeparator = actionsSeparator
    }

}


extension ContactsViewStyle {

    static func createDefaultStyle(with style: WalletStyleProtocol) -> ContactsViewStyle {
        let searchTextStyle = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)
        let searchPlaceholderStyle = WalletTextStyle(font: style.bodyRegularFont,
                                                     color: style.bodyTextColor.withAlphaComponent(0.5))
        let searchFieldStyle = WalletRoundedViewStyle(fill: .search)
        let searchIcon = UIImage(named: "iconSearch", in: Bundle(for: WalletStyle.self), compatibleWith: nil)
        return ContactsViewStyle(backgroundColor: style.backgroundColor,
                                 searchHeaderBackgroundColor: style.navigationBarStyle.barColor,
                                 searchTextStyle: searchTextStyle,
                                 searchPlaceholderStyle: searchPlaceholderStyle,
                                 searchFieldStyle: searchFieldStyle,
                                 searchIndicatorStyle: .greyText,
                                 searchIcon: searchIcon,
                                 searchSeparatorColor: style.thinBorderColor,
                                 tableSeparatorColor: style.thinBorderColor,
                                 actionsSeparator: WalletStrokeStyle(color: style.accentColor))
    }

}
