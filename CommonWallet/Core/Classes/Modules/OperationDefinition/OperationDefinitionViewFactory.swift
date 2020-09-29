/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

public protocol OperationDefinitionViewFactoryProtocol {
    func createHeaderViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionHeaderView
    func createErrorViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionErrorView
    func createAssetView() -> BaseSelectedAssetView
    func createReceiverView() -> BaseReceiverView
    func createAmountView() -> BaseAmountInputView
    func createFeeView() -> BaseFeeView
    func createDescriptionView() -> BaseDescriptionInputView
}

struct OperationDefinitionViewFactory: OperationDefinitionViewFactoryProtocol {
    let style: OperationDefinitionViewStyle
    let defaultStyle: WalletStyleProtocol

    init(style: OperationDefinitionViewStyle, defaultStyle: WalletStyleProtocol) {
        self.style = style
        self.defaultStyle = defaultStyle
    }

    func createHeaderViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionHeaderView {
        switch type {
        case .asset:
            return createHeaderViewForStyle(style.assetStyle.containingHeaderStyle)
        case .receiver:
            return createHeaderViewForStyle(style.receiverStyle.containingHeaderStyle)
        case .amount:
            return createHeaderViewForStyle(style.amountStyle.containingHeaderStyle)
        case .fee:
            return createHeaderViewForStyle(style.feeStyle.containingHeaderStyle)
        case .description:
            return createHeaderViewForStyle(style.descriptionStyle.containingHeaderStyle)
        }
    }

    func createErrorViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionErrorView {
        switch type {
        case .asset:
            return createErrorViewForStyle(style.assetStyle.containingErrorStyle)
        case .receiver:
            return createErrorViewForStyle(style.receiverStyle.containingErrorStyle)
        case .amount:
            return createErrorViewForStyle(style.amountStyle.containingErrorStyle)
        case .fee:
            return createErrorViewForStyle(style.feeStyle.containingErrorStyle)
        case .description:
            return createErrorViewForStyle(style.descriptionStyle.containingErrorStyle)
        }
    }

    func createAssetView() -> BaseSelectedAssetView {
        let view = SelectedAssetView()

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.assetStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.assetStyle.separatorStyle.lineWidth

        view.titleColor = style.assetStyle.titleStyle.color
        view.titleFont = style.assetStyle.titleStyle.font

        view.subtitleColor = style.assetStyle.subtitleStyle.color
        view.subtitleFont = style.assetStyle.subtitleStyle.font

        view.detailsControl.titleLabel.textColor = style.assetStyle.detailsStyle.color
        view.detailsControl.titleLabel.font = style.assetStyle.detailsStyle.font
        view.accessoryIcon = style.assetStyle.switchIcon ?? defaultStyle.downArrowIcon

        view.contentInsets = style.assetStyle.contentInsets
        view.titleHorizontalSpacing = style.assetStyle.titleHorizontalSpacing
        view.detailsHorizontalSpacing = style.assetStyle.detailsHorizontalSpacing
        view.displayStyle = style.assetStyle.displayStyle

        return view
    }

    func createReceiverView() -> BaseReceiverView {
        let view = ReceiverFormView()

        view.borderedView.strokeColor = style.receiverStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.receiverStyle.separatorStyle.lineWidth

        view.titleLabel.textColor = style.receiverStyle.textStyle.color
        view.titleLabel.font = style.receiverStyle.textStyle.font

        view.horizontalSpacing = style.receiverStyle.horizontalSpacing
        view.contentInsets = style.receiverStyle.contentInsets

        return view
    }

    func createAmountView() -> BaseAmountInputView {
        let optionalView = UINib(nibName: "AmountInputView", bundle: Bundle(for: SelectedAssetView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? AmountInputView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.amountStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.amountStyle.separatorStyle.lineWidth

        view.amountField.textColor = style.amountStyle.inputStyle.color
        view.amountField.font = style.amountStyle.inputStyle.font

        view.assetLabel.textColor = style.amountStyle.assetStyle.color
        view.assetLabel.font = style.amountStyle.assetStyle.font

        let optionalCaretColor = style.amountStyle.caretColor ?? defaultStyle.caretColor

        if let caretColor = optionalCaretColor {
            view.amountField.tintColor = caretColor
        }

        view.keyboardIndicatorIcon = style.amountStyle.keyboardIcon ?? defaultStyle.keyboardIcon
        view.keyboardIndicatorMode = style.amountStyle.keyboardIndicatorMode

        view.horizontalSpacing = style.amountStyle.horizontalSpacing
        view.contentInsets = style.amountStyle.contentInsets

        return view
    }

    func createFeeView() -> BaseFeeView {
        let view = FeeView()

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.feeStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.feeStyle.separatorStyle.lineWidth

        if let activityIndicatorColor = style.feeStyle.activityTintColor {
            view.activityIndicator.tintColor = activityIndicatorColor
        }

        view.titleLabel.textColor = style.feeStyle.titleStyle.color
        view.titleLabel.font = style.feeStyle.titleStyle.font

        view.detailsColor = style.feeStyle.amountStyle.color
        view.detailsFont = style.feeStyle.amountStyle.font

        view.contentInsets = style.feeStyle.contentInsets
        view.displayType = style.feeStyle.displayStyle
        view.horizontalSpacing = style.feeStyle.horizontalSpacing

        return view
    }

    func createDescriptionView() -> BaseDescriptionInputView {
        let optionalView = UINib(nibName: "DescriptionInputView", bundle: Bundle(for: DescriptionInputView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? DescriptionInputView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.descriptionStyle.separatorStyle.color
        view.borderedView.strokeWidth = style.descriptionStyle.separatorStyle.lineWidth

        view.textView.textColor = style.descriptionStyle.inputStyle.color
        view.textView.font = style.descriptionStyle.inputStyle.font

        let optionalCaretColor = style.descriptionStyle.caretColor ?? defaultStyle.caretColor

        if let caretColor = optionalCaretColor {
            view.textView.tintColor = caretColor
        }

        view.placeholderLabel.textColor = style.descriptionStyle.placeholderStyle.color
        view.placeholderLabel.font = style.descriptionStyle.placeholderStyle.font

        view.keyboardIndicatorMode = style.descriptionStyle.keyboardIndicatorMode
        view.keyboardIndicatorIcon = style.descriptionStyle.keyboardIcon

        view.contentInsets = style.descriptionStyle.contentInsets

        return view
    }

    // MARK: Private

    private func createHeaderViewForStyle(_ style: WalletContainingHeaderStyle)
        -> BaseOperationDefinitionHeaderView {
        let view = MultilineTitleIconView()

        view.titleLabel.textColor = style.titleStyle.color
        view.titleLabel.font = style.titleStyle.font

        view.contentInsets = style.contentInsets
        view.horizontalSpacing = style.horizontalSpacing

        return view
    }

    private func createErrorViewForStyle(_ style: WalletContainingErrorStyle)
        -> BaseOperationDefinitionErrorView {
        let view = ContainingErrorView()

        view.titleLabel.textColor = style.inlineErrorStyle.titleColor
        view.titleLabel.font = style.inlineErrorStyle.titleFont

        view.contentInsets = style.contentInsets
        view.horizontalSpacing = style.horizontalSpacing

        view.icon = style.inlineErrorStyle.icon ?? defaultStyle.inlineErrorStyle.icon

        return view
    }
}
