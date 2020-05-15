/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public struct WalletContainingHeaderStyle {
    public let titleStyle: WalletTextStyleProtocol
    public let horizontalSpacing: CGFloat
    public let contentInsets: UIEdgeInsets

    public init(titleStyle: WalletTextStyleProtocol,
                horizontalSpacing: CGFloat,
                contentInsets: UIEdgeInsets) {
        self.titleStyle = titleStyle
        self.horizontalSpacing = horizontalSpacing
        self.contentInsets = contentInsets
    }
}

public struct WalletContainingErrorStyle {
    public let inlineErrorStyle: WalletInlineErrorStyleProtocol
    public let horizontalSpacing: CGFloat
    public let contentInsets: UIEdgeInsets

    public init(inlineErrorStyle: WalletInlineErrorStyleProtocol,
                horizontalSpacing: CGFloat,
                contentInsets: UIEdgeInsets) {
        self.inlineErrorStyle = inlineErrorStyle
        self.horizontalSpacing = horizontalSpacing
        self.contentInsets = contentInsets
    }
}

public struct WalletContainingAssetStyle {
    public let containingHeaderStyle: WalletContainingHeaderStyle
    public let titleStyle: WalletTextStyleProtocol
    public let subtitleStyle: WalletTextStyleProtocol
    public let detailsStyle: WalletTextStyleProtocol
    public let switchIcon: UIImage?
    public let contentInsets: UIEdgeInsets
    public let titleHorizontalSpacing: CGFloat
    public let detailsHorizontalSpacing: CGFloat
    public let displayStyle: SelectedAssetViewDisplayStyle
    public let separatorStyle: WalletStrokeStyleProtocol
    public let containingErrorStyle: WalletContainingErrorStyle

    public init(containingHeaderStyle: WalletContainingHeaderStyle,
                titleStyle: WalletTextStyleProtocol,
                subtitleStyle: WalletTextStyleProtocol,
                detailsStyle: WalletTextStyleProtocol,
                switchIcon: UIImage?,
                contentInsets: UIEdgeInsets,
                titleHorizontalSpacing: CGFloat,
                detailsHorizontalSpacing: CGFloat,
                displayStyle: SelectedAssetViewDisplayStyle,
                separatorStyle: WalletStrokeStyleProtocol,
                containingErrorStyle: WalletContainingErrorStyle) {
        self.containingHeaderStyle = containingHeaderStyle
        self.titleStyle = titleStyle
        self.subtitleStyle = subtitleStyle
        self.detailsStyle = detailsStyle
        self.switchIcon = switchIcon
        self.contentInsets = contentInsets
        self.titleHorizontalSpacing = titleHorizontalSpacing
        self.detailsHorizontalSpacing = detailsHorizontalSpacing
        self.displayStyle = displayStyle
        self.separatorStyle = separatorStyle
        self.containingErrorStyle = containingErrorStyle
    }
}

public struct WalletContainingReceiverStyle {
    public let containingHeaderStyle: WalletContainingHeaderStyle
    public let textStyle: WalletTextStyleProtocol
    public let horizontalSpacing: CGFloat
    public let contentInsets: UIEdgeInsets
    public let separatorStyle: WalletStrokeStyleProtocol
    public let containingErrorStyle: WalletContainingErrorStyle

    public init(containingHeaderStyle: WalletContainingHeaderStyle,
                textStyle: WalletTextStyleProtocol,
                horizontalSpacing: CGFloat,
                contentInsets: UIEdgeInsets,
                separatorStyle: WalletStrokeStyleProtocol,
                containingErrorStyle: WalletContainingErrorStyle) {
        self.containingHeaderStyle = containingHeaderStyle
        self.textStyle = textStyle
        self.horizontalSpacing = horizontalSpacing
        self.contentInsets = contentInsets
        self.separatorStyle = separatorStyle
        self.containingErrorStyle = containingErrorStyle
    }
}

public struct WalletContainingAmountStyle {
    public let containingHeaderStyle: WalletContainingHeaderStyle
    public let assetStyle: WalletTextStyleProtocol
    public let inputStyle: WalletTextStyleProtocol
    public let keyboardIndicatorMode: KeyboardIndicatorDisplayMode
    public let keyboardIcon: UIImage?
    public let caretColor: UIColor?
    public let horizontalSpacing: CGFloat
    public let contentInsets: UIEdgeInsets
    public let separatorStyle: WalletStrokeStyleProtocol
    public let containingErrorStyle: WalletContainingErrorStyle

    public init(containingHeaderStyle: WalletContainingHeaderStyle,
                assetStyle: WalletTextStyleProtocol,
                inputStyle: WalletTextStyleProtocol,
                keyboardIndicatorMode: KeyboardIndicatorDisplayMode,
                keyboardIcon: UIImage?,
                caretColor: UIColor?,
                horizontalSpacing: CGFloat,
                contentInsets: UIEdgeInsets,
                separatorStyle: WalletStrokeStyleProtocol,
                containingErrorStyle: WalletContainingErrorStyle) {
        self.containingHeaderStyle = containingHeaderStyle
        self.assetStyle = assetStyle
        self.inputStyle = inputStyle
        self.keyboardIndicatorMode = keyboardIndicatorMode
        self.keyboardIcon = keyboardIcon
        self.caretColor = caretColor
        self.horizontalSpacing = horizontalSpacing
        self.contentInsets = contentInsets
        self.separatorStyle = separatorStyle
        self.containingErrorStyle = containingErrorStyle
    }
}

public struct WalletContainingFeeStyle {
    public let containingHeaderStyle: WalletContainingHeaderStyle
    public let titleStyle: WalletTextStyleProtocol
    public let amountStyle: WalletTextStyleProtocol
    public let activityTintColor: UIColor?
    public let displayStyle: FeeViewDisplayStyle
    public let horizontalSpacing: CGFloat
    public let contentInsets: UIEdgeInsets
    public let separatorStyle: WalletStrokeStyleProtocol
    public let containingErrorStyle: WalletContainingErrorStyle

    public init(containingHeaderStyle: WalletContainingHeaderStyle,
                titleStyle: WalletTextStyleProtocol,
                amountStyle: WalletTextStyleProtocol,
                activityTintColor: UIColor?,
                displayStyle: FeeViewDisplayStyle,
                horizontalSpacing: CGFloat,
                contentInsets: UIEdgeInsets,
                separatorStyle: WalletStrokeStyleProtocol,
                containingErrorStyle: WalletContainingErrorStyle) {
        self.containingHeaderStyle = containingHeaderStyle
        self.titleStyle = titleStyle
        self.amountStyle = amountStyle
        self.activityTintColor = activityTintColor
        self.displayStyle = displayStyle
        self.horizontalSpacing = horizontalSpacing
        self.contentInsets = contentInsets
        self.separatorStyle = separatorStyle
        self.containingErrorStyle = containingErrorStyle
    }
}

public struct WalletContainingDescriptionStyle {
    public let containingHeaderStyle: WalletContainingHeaderStyle
    public let inputStyle: WalletTextStyleProtocol
    public let placeholderStyle: WalletTextStyleProtocol
    public let contentInsets: UIEdgeInsets
    public let keyboardIndicatorMode: KeyboardIndicatorDisplayMode
    public let keyboardIcon: UIImage?
    public let caretColor: UIColor?
    public let separatorStyle: WalletStrokeStyleProtocol
    public let containingErrorStyle: WalletContainingErrorStyle

    public init(containingHeaderStyle: WalletContainingHeaderStyle,
                inputStyle: WalletTextStyleProtocol,
                placeholderStyle: WalletTextStyleProtocol,
                keyboardIndicatorMode: KeyboardIndicatorDisplayMode,
                keyboardIcon: UIImage?,
                caretColor: UIColor?,
                contentInsets: UIEdgeInsets,
                separatorStyle: WalletStrokeStyleProtocol,
                containingErrorStyle: WalletContainingErrorStyle) {
        self.containingHeaderStyle = containingHeaderStyle
        self.inputStyle = inputStyle
        self.placeholderStyle = placeholderStyle
        self.keyboardIndicatorMode = keyboardIndicatorMode
        self.keyboardIcon = keyboardIcon
        self.caretColor = caretColor
        self.contentInsets = contentInsets
        self.separatorStyle = separatorStyle
        self.containingErrorStyle = containingErrorStyle
    }
}
