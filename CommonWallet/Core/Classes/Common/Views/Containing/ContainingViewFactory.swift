/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

enum AmountInputViewDisplay {
    case large
    case small
}

protocol ContainingViewFactoryProtocol {
    func createQrView() -> QRView
    func createSelectedAssetView() -> SelectedAssetView
    func createAmountInputView(for display: AmountInputViewDisplay) -> AmountInputView
    func createDescriptionInputView() -> DescriptionInputView
    func createFeeView() -> FeeView
    func createReceiver() -> ReceiverFormView
    func createTitleView() -> MultilineTitleIconView
    func createErrorView() -> MultilineTitleIconView
    func createSeparatorView() -> BorderedContainerView
}

struct ContainingViewFactory: ContainingViewFactoryProtocol {
    let style: WalletStyleProtocol

    func createTitleView() -> MultilineTitleIconView {
        let view = MultilineTitleIconView()

        view.titleLabel.textColor = style.captionTextColor
        view.titleLabel.font = style.bodyRegularFont

        return view
    }

    func createReceiver() -> ReceiverFormView {
        let view = ReceiverFormView()

        view.borderedView.strokeColor = style.thinBorderColor
        view.titleLabel.textColor = style.bodyTextColor
        view.titleLabel.font = style.bodyRegularFont

        return view
    }

    func createErrorView() -> MultilineTitleIconView {
        let view = MultilineTitleIconView()

        let errorStyle = style.inlineErrorStyle

        view.titleLabel.textColor = errorStyle.titleColor
        view.titleLabel.font = errorStyle.titleFont

        return view
    }

    func createSelectedAssetView() -> SelectedAssetView {
        let view = SelectedAssetView()

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.thinBorderColor
        view.borderedView.strokeWidth = 1.0
        view.titleColor = style.bodyTextColor
        view.titleFont = style.bodyRegularFont
        view.subtitleColor = style.bodyTextColor
        view.subtitleFont = style.bodyRegularFont
        view.detailsControl.titleLabel.textColor = style.bodyTextColor
        view.detailsControl.titleLabel.font = style.bodyRegularFont
        view.accessoryIcon = style.downArrowIcon

        return view
    }

    func createAmountInputView(for display: AmountInputViewDisplay) -> AmountInputView {
        let optionalView = UINib(nibName: "AmountInputView", bundle: Bundle(for: SelectedAssetView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? AmountInputView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.thinBorderColor
        view.amountField.textColor = style.bodyTextColor
        view.assetLabel.textColor = style.bodyTextColor

        if let caretColor = style.caretColor {
            view.amountField.tintColor = caretColor
        }

        switch display {
        case .large:
            view.amountField.font = style.header1Font
            view.assetLabel.font = style.header1Font
        case .small:
            view.amountField.font = style.header2Font
            view.assetLabel.font = style.header2Font
        }

        view.keyboardIndicatorIcon = style.keyboardIcon

        return view
    }

    func createDescriptionInputView() -> DescriptionInputView {
        let optionalView = UINib(nibName: "DescriptionInputView", bundle: Bundle(for: DescriptionInputView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? DescriptionInputView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.thinBorderColor

        view.textView.textColor = style.bodyTextColor
        view.textView.font = style.bodyRegularFont

        if let caretColor = style.caretColor {
            view.textView.tintColor = caretColor
        }

        view.placeholderLabel.textColor = style.bodyTextColor.withAlphaComponent(0.22)
        view.placeholderLabel.font = style.bodyRegularFont

        view.keyboardIndicatorIcon = style.keyboardIcon

        return view
    }

    func createQrView() -> QRView {
        let optionalView = UINib(nibName: "QRView", bundle: Bundle(for: QRView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? QRView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .white
        view.borderedView.strokeColor = style.thinBorderColor
        view.imageView.backgroundColor = .clear

        return view
    }

    func createFeeView() -> FeeView {
        let view = FeeView()

        view.backgroundColor = .clear
        view.borderedView.strokeColor = style.thinBorderColor
        view.activityIndicator.tintColor = style.captionTextColor
        view.titleLabel.textColor = style.captionTextColor
        view.titleLabel.font = style.bodyRegularFont

        return view
    }

    func createSeparatorView() -> BorderedContainerView {
        let separatorView = BorderedContainerView()
        separatorView.strokeColor = style.thinBorderColor
        return separatorView
    }
}
