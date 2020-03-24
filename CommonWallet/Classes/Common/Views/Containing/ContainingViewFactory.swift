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
    func createSeparatorView() -> BorderedContainerView
}

struct ContainingViewFactory: ContainingViewFactoryProtocol {
    let style: WalletStyleProtocol

    func createSelectedAssetView() -> SelectedAssetView {
        let optionalView = UINib(nibName: "SelectedAssetView", bundle: Bundle(for: SelectedAssetView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? SelectedAssetView else {
            fatalError("Unexpected view returned from nib")
        }

        view.backgroundColor = .clear

        view.borderedView.strokeColor = style.thinBorderColor
        view.titleControl.titleLabel.textColor = style.bodyTextColor
        view.titleControl.titleLabel.font = style.bodyRegularFont
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
        view.titleLabel.textColor = style.captionTextColor
        view.titleLabel.font = style.bodyRegularFont
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

        view.titleLabel.textColor = style.captionTextColor
        view.titleLabel.font = style.bodyRegularFont

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
        let optionalView = UINib(nibName: "FeeView", bundle: Bundle(for: FeeView.self))
            .instantiate(withOwner: nil, options: nil)
            .first

        guard let view = optionalView as? FeeView else {
            fatalError("Unexpected view returned from nib")
        }

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
