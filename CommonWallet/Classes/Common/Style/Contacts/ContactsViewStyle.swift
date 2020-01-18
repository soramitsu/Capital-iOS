/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public protocol ContactsViewStyleProtocol {
    var backgroundColor: UIColor { get }
    var searchHeaderBackgroundColor: UIColor { get }
    var searchTextStyle: WalletTextStyleProtocol { get }
    var searchIndicatorStyle: UIColor { get }
    var searchFieldColor: UIColor { get }
    var searchIcon: UIImage? { get }
    var separatorColor: UIColor { get }
    var actionsSeparator: WalletStrokeStyleProtocol { get }
}


public struct ContactsViewStyle: ContactsViewStyleProtocol {
    public var backgroundColor: UIColor
    public var searchHeaderBackgroundColor: UIColor
    public var searchTextStyle: WalletTextStyleProtocol
    public var searchFieldColor: UIColor
    public var searchIndicatorStyle: UIColor
    public var searchIcon: UIImage?
    public var separatorColor: UIColor
    public var actionsSeparator: WalletStrokeStyleProtocol

    public init(backgroundColor: UIColor,
                searchHeaderBackgroundColor: UIColor,
                searchTextStyle: WalletTextStyleProtocol,
                searchFieldColor: UIColor,
                searchIndicatorStyle: UIColor,
                searchIcon: UIImage?,
                separatorColor: UIColor,
                actionsSeparator: WalletStrokeStyleProtocol) {
        self.backgroundColor = backgroundColor
        self.searchTextStyle = searchTextStyle
        self.searchHeaderBackgroundColor = searchHeaderBackgroundColor
        self.searchFieldColor = searchFieldColor
        self.searchIndicatorStyle = searchIndicatorStyle
        self.searchIcon = searchIcon
        self.separatorColor = separatorColor
        self.actionsSeparator = actionsSeparator
    }

}


extension ContactsViewStyle {

    static func createDefaultStyle(with style: WalletStyleProtocol) -> ContactsViewStyle {
        let searchTextStyle = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)
        let searchIcon = UIImage(named: "iconSearch", in: Bundle(for: WalletStyle.self), compatibleWith: nil)
        return ContactsViewStyle(backgroundColor: style.backgroundColor,
                                 searchHeaderBackgroundColor: style.navigationBarStyle.barColor,
                                 searchTextStyle: searchTextStyle,
                                 searchFieldColor: .search,
                                 searchIndicatorStyle: .greyText,
                                 searchIcon: searchIcon,
                                 separatorColor: style.thinBorderColor,
                                 actionsSeparator: WalletStrokeStyle(color: style.accentColor))
    }

}
