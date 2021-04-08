/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol HistoryViewStyleProtocol {
    var fillColor: UIColor { get }
    var borderStyle: WalletStrokeStyle { get }
    var cornerRadius: CGFloat { get }
    var titleStyle: WalletTextStyleProtocol { get }
    var filterIcon: UIImage? { get }
    var closeIcon: UIImage? { get }
    var panIndicatorStyle: UIColor { get }
    var shouldInsertFullscreenShadow: Bool { get }
    var shadow: WalletShadowStyleProtocol? { get }
    var separatorStyle: UIColor? { get }
    var pageLoadingIndicatorColor: UIColor? { get }
}

public struct HistoryViewStyle: HistoryViewStyleProtocol {
    public let separatorStyle: UIColor?
    public let shadow: WalletShadowStyleProtocol?
    public let fillColor: UIColor
    public let borderStyle: WalletStrokeStyle
    public let cornerRadius: CGFloat
    public let titleStyle: WalletTextStyleProtocol
    public let filterIcon: UIImage?
    public let closeIcon: UIImage?
    public let panIndicatorStyle: UIColor
    public let shouldInsertFullscreenShadow: Bool
    public let pageLoadingIndicatorColor: UIColor?

    public init(fillColor: UIColor,
                borderStyle: WalletStrokeStyle,
                cornerRadius: CGFloat,
                titleStyle: WalletTextStyleProtocol,
                filterIcon: UIImage?,
                closeIcon: UIImage?,
                panIndicatorStyle: UIColor,
                shouldInsertFullscreenShadow: Bool,
                shadow: WalletShadowStyleProtocol?,
                separatorStyle: UIColor?,
                pageLoadingIndicatorColor: UIColor?) {
        self.fillColor = fillColor
        self.borderStyle = borderStyle
        self.cornerRadius = cornerRadius
        self.titleStyle = titleStyle
        self.filterIcon = filterIcon
        self.closeIcon = closeIcon
        self.panIndicatorStyle = panIndicatorStyle
        self.shouldInsertFullscreenShadow = shouldInsertFullscreenShadow
        self.separatorStyle = separatorStyle
        self.shadow = shadow
        self.pageLoadingIndicatorColor = pageLoadingIndicatorColor
    }
}

extension HistoryViewStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> HistoryViewStyle {
        let filter = UIImage(named: "filter",
                             in: Bundle(for: WalletStyle.self),
                             compatibleWith: nil)

        return HistoryViewStyle(fillColor: .white,
                                borderStyle: WalletStrokeStyle(color: .border, lineWidth: 1.0),
                                cornerRadius: 10.0,
                                titleStyle: WalletTextStyle(font: style.header4Font, color: style.headerTextColor),
                                filterIcon: filter,
                                closeIcon: style.closeIcon,
                                panIndicatorStyle: .panIndicator,
                                shouldInsertFullscreenShadow: true,
                                shadow: nil,
                                separatorStyle: nil,
                                pageLoadingIndicatorColor: nil)
    }
}
