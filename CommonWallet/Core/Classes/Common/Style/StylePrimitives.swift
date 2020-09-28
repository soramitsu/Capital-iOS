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
    public var font: UIFont
    public var color: UIColor

    public init(font: UIFont, color: UIColor) {
        self.font = font
        self.color = color
    }
}

public struct WalletShadowStyle: WalletShadowStyleProtocol {
    public var offset: CGSize
    public var color: UIColor
    public var opacity: Float
    public var blurRadius: CGFloat

    public init(offset: CGSize, color: UIColor, opacity: Float = 1.0, blurRadius: CGFloat = 0.0) {
        self.offset = offset
        self.color = color
        self.opacity = opacity
        self.blurRadius = blurRadius
    }
}

public struct WalletStrokeStyle: WalletStrokeStyleProtocol {
    public var color: UIColor
    public var lineWidth: CGFloat

    public init(color: UIColor, lineWidth: CGFloat = 1.0) {
        self.color = color
        self.lineWidth = lineWidth
    }
}

public struct WalletRoundedViewStyle: WalletRoundedViewStyleProtocol {
    public var fill: UIColor
    public var stroke: WalletStrokeStyleProtocol?
    public var cornerRadius: CGFloat?

    public init(fill: UIColor,
                cornerRadius: CGFloat? = nil,
                stroke: WalletStrokeStyleProtocol? = nil) {
        self.fill = fill
        self.stroke = stroke
        self.cornerRadius = cornerRadius
    }
}

public struct WalletRoundedButtonStyle: WalletRoundedButtonStyleProtocol {
    public var background: UIColor
    public var title: WalletTextStyleProtocol
    public var stroke: WalletStrokeStyleProtocol?
    public var shadow: WalletShadowStyleProtocol?

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
    public var background: UIColor
    public var title: WalletTextStyleProtocol
    public var stroke: WalletStrokeStyleProtocol?
    public var radius: CGFloat

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
    public var normal: UIColor
    public var highlighted: UIColor

    public init(normal: UIColor, highlighted: UIColor) {
        self.normal = normal
        self.highlighted = highlighted
    }
}

public struct WalletFormCellStyle: WalletFormCellStyleProtocol {
    public var title: WalletTextStyleProtocol
    public var details: WalletTextStyleProtocol
    public var link: WalletLinkStyleProtocol
    public var separator: UIColor

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
    public var fill: UIColor
    public var cornerRadius: CGFloat
    public var stroke: WalletStrokeStyleProtocol?
    public var shadow: WalletShadowStyleProtocol?
    public var doneIcon: UIImage?
    public var backdropOpacity: CGFloat

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
    public var title: WalletTextStyleProtocol
    public var action: WalletRoundedButtonStyle
    public var separator: WalletStrokeStyle
    public var background: UIColor

    public init(title: WalletTextStyleProtocol, action: WalletRoundedButtonStyle,
                separator: WalletStrokeStyle, background: UIColor) {
        self.title = title
        self.action = action
        self.separator = separator
        self.background = background
    }
}

public struct WalletAmountChangeStyle: WalletAmountChangeStyleProtocol {
    public var increase: UIImage?
    public var decrease: UIImage?

    public init(increase: UIImage?, decrease: UIImage?) {
        self.increase = increase
        self.decrease = decrease
    }
}

public struct WalletTransactionStatusStyle: WalletTransactionStatusStyleProtocol {
    public var icon: UIImage?
    public var color: UIColor

    public init(icon: UIImage?, color: UIColor) {
        self.icon = icon
        self.color = color
    }
}

public struct WalletLoadingOverlayStyle: WalletLoadingOverlayStyleProtocol {
    public var background: UIColor
    public var contentColor: UIColor
    public var contentSize: CGSize
    public var indicator: UIImage?
    public var animationDuration: TimeInterval

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
    public var icon: UIImage?
    public var titleFont: UIFont
    public var titleColor: UIColor

    public init(titleColor: UIColor, titleFont: UIFont, icon: UIImage? = nil) {
        self.titleColor = titleColor
        self.titleFont = titleFont
        self.icon = icon
    }
}
