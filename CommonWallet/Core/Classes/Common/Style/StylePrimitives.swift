/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol WalletTextStyleProtocol {
    var font: UIFont { get }
    var color: UIColor { get }
}

public protocol WalletShadowStyleProtocol {
    var offset: CGSize { get }
    var color: UIColor { get }
    var opacity: Float { get }
    var blurRadius: CGFloat { get }
}

public protocol WalletStrokeStyleProtocol {
    var color: UIColor { get }
    var lineWidth: CGFloat { get }
}

public protocol WalletLinkStyleProtocol {
    var normal: UIColor { get }
    var highlighted: UIColor { get }
}

public protocol WalletRoundedViewStyleProtocol {
    var fill: UIColor { get }
    var stroke: WalletStrokeStyleProtocol? { get }
    var cornerRadius: CGFloat? { get }
}

public protocol WalletRoundedButtonStyleProtocol {
    var background: UIColor { get }
    var title: WalletTextStyleProtocol { get }
    var stroke: WalletStrokeStyleProtocol? { get }
    var shadow: WalletShadowStyleProtocol? { get }
}

public protocol WalletNameIconStyleProtocol {
    var background: UIColor { get }
    var stroke: WalletStrokeStyleProtocol? { get }
    var title: WalletTextStyleProtocol { get }
    var radius: CGFloat { get }
}

public protocol WalletFormCellStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var details: WalletTextStyleProtocol { get }
    var link: WalletLinkStyleProtocol { get }
    var separator: UIColor { get }
}

public protocol WalletModalActionStyleProtocol {
    var fill: UIColor { get }
    var cornerRadius: CGFloat { get }
    var stroke: WalletStrokeStyleProtocol? { get }
    var shadow: WalletShadowStyleProtocol? { get }
    var doneIcon: UIImage? { get }
    var backdropOpacity: CGFloat { get }
}

public protocol WalletAccessoryStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var action: WalletRoundedButtonStyle { get }
    var separator: WalletStrokeStyle { get }
    var background: UIColor { get }
}

public protocol WalletAmountChangeStyleProtocol {
    var increase: UIImage? { get }
    var decrease: UIImage? { get }
}

public protocol WalletTransactionStatusStyleProtocol {
    var icon: UIImage? { get }
    var color: UIColor { get }
}

public protocol WalletLoadingOverlayStyleProtocol {
    var background: UIColor { get }
    var contentColor: UIColor { get }
    var contentSize: CGSize { get }
    var indicator: UIImage? { get }
    var animationDuration: TimeInterval { get }
}

public protocol WalletInlineErrorStyleProtocol {
    var icon: UIImage? { get }
    var titleColor: UIColor { get }
    var titleFont: UIFont { get }
}

public struct WalletTextStyle: WalletTextStyleProtocol {
    public let font: UIFont
    public let color: UIColor

    public init(font: UIFont, color: UIColor) {
        self.font = font
        self.color = color
    }
}

public struct WalletShadowStyle: WalletShadowStyleProtocol {
    public let offset: CGSize
    public let color: UIColor
    public let opacity: Float
    public let blurRadius: CGFloat

    public init(offset: CGSize, color: UIColor, opacity: Float = 1.0, blurRadius: CGFloat = 0.0) {
        self.offset = offset
        self.color = color
        self.opacity = opacity
        self.blurRadius = blurRadius
    }
}

public struct WalletStrokeStyle: WalletStrokeStyleProtocol {
    public let color: UIColor
    public let lineWidth: CGFloat

    public init(color: UIColor, lineWidth: CGFloat = 1.0) {
        self.color = color
        self.lineWidth = lineWidth
    }
}

public struct WalletRoundedViewStyle: WalletRoundedViewStyleProtocol {
    public let fill: UIColor
    public let stroke: WalletStrokeStyleProtocol?
    public let cornerRadius: CGFloat?

    public init(fill: UIColor,
                cornerRadius: CGFloat? = nil,
                stroke: WalletStrokeStyleProtocol? = nil) {
        self.fill = fill
        self.stroke = stroke
        self.cornerRadius = cornerRadius
    }
}

public struct WalletRoundedButtonStyle: WalletRoundedButtonStyleProtocol {
    public let background: UIColor
    public let title: WalletTextStyleProtocol
    public let stroke: WalletStrokeStyleProtocol?
    public let shadow: WalletShadowStyleProtocol?

    public init(background: UIColor,
                title: WalletTextStyleProtocol,
                stroke: WalletStrokeStyleProtocol? = nil,
                shadow: WalletShadowStyleProtocol? = nil) {
        self.background = background
        self.title = title
        self.stroke = stroke
        self.shadow = shadow
    }
}

public struct WalletNameIconStyle: WalletNameIconStyleProtocol {
    public let background: UIColor
    public let title: WalletTextStyleProtocol
    public let stroke: WalletStrokeStyleProtocol?
    public let radius: CGFloat

    public init(background: UIColor,
                title: WalletTextStyleProtocol,
                radius: CGFloat,
                stroke: WalletStrokeStyleProtocol? = nil) {
        self.background = background
        self.title = title
        self.stroke = stroke
        self.radius = radius
    }
}

public struct WalletLinkStyle: WalletLinkStyleProtocol {
    public let normal: UIColor
    public let highlighted: UIColor

    public init(normal: UIColor, highlighted: UIColor) {
        self.normal = normal
        self.highlighted = highlighted
    }
}

public struct WalletFormCellStyle: WalletFormCellStyleProtocol {
    public let title: WalletTextStyleProtocol
    public let details: WalletTextStyleProtocol
    public let link: WalletLinkStyleProtocol
    public let separator: UIColor

    public init(title: WalletTextStyleProtocol,
                details: WalletTextStyleProtocol,
                link: WalletLinkStyleProtocol,
                separator: UIColor) {
        self.title = title
        self.details = details
        self.link = link
        self.separator = separator
    }
}

public struct WalletModalActionStyle: WalletModalActionStyleProtocol {
    public let fill: UIColor
    public let cornerRadius: CGFloat
    public let stroke: WalletStrokeStyleProtocol?
    public let shadow: WalletShadowStyleProtocol?
    public let doneIcon: UIImage?
    public let backdropOpacity: CGFloat

    public init(fill: UIColor, cornerRadius: CGFloat,
                stroke: WalletStrokeStyleProtocol?, shadow: WalletShadowStyleProtocol?,
                doneIcon: UIImage?, backdropOpacity: CGFloat) {
        self.fill = fill
        self.cornerRadius = cornerRadius
        self.stroke = stroke
        self.shadow = shadow
        self.doneIcon = doneIcon
        self.backdropOpacity = backdropOpacity
    }
}

public struct WalletAccessoryStyle: WalletAccessoryStyleProtocol {
    public let title: WalletTextStyleProtocol
    public let action: WalletRoundedButtonStyle
    public let separator: WalletStrokeStyle
    public let background: UIColor

    public init(title: WalletTextStyleProtocol, action: WalletRoundedButtonStyle,
                separator: WalletStrokeStyle, background: UIColor) {
        self.title = title
        self.action = action
        self.separator = separator
        self.background = background
    }
}

public struct WalletAmountChangeStyle: WalletAmountChangeStyleProtocol {
    public let increase: UIImage?
    public let decrease: UIImage?

    public init(increase: UIImage?, decrease: UIImage?) {
        self.increase = increase
        self.decrease = decrease
    }
}

public struct WalletTransactionStatusStyle: WalletTransactionStatusStyleProtocol {
    public let icon: UIImage?
    public let color: UIColor

    public init(icon: UIImage?, color: UIColor) {
        self.icon = icon
        self.color = color
    }
}

public struct WalletLoadingOverlayStyle: WalletLoadingOverlayStyleProtocol {
    public let background: UIColor
    public let contentColor: UIColor
    public let contentSize: CGSize
    public let indicator: UIImage?
    public let animationDuration: TimeInterval

    public init(background: UIColor, contentColor: UIColor, contentSize: CGSize, indicator: UIImage?,
                animationDuration: TimeInterval) {
        self.background = background
        self.contentColor = contentColor
        self.contentSize = contentSize
        self.indicator = indicator
        self.animationDuration = animationDuration
    }
}

public struct WalletInlineErrorStyle: WalletInlineErrorStyleProtocol {
    public let icon: UIImage?
    public let titleFont: UIFont
    public let titleColor: UIColor

    public init(titleColor: UIColor, titleFont: UIFont, icon: UIImage? = nil) {
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.icon = icon
    }
}
