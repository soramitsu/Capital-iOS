/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public protocol WalletStyleBuilderProtocol: class {
    @discardableResult
    func with(header1 font: UIFont) -> Self

    @discardableResult
    func with(header2 font: UIFont) -> Self

    @discardableResult
    func with(header3 font: UIFont) -> Self

    @discardableResult
    func with(header4 font: UIFont) -> Self

    @discardableResult
    func with(bodyRegular font: UIFont) -> Self

    @discardableResult
    func with(bodyBold font: UIFont) -> Self

    @discardableResult
    func with(small font: UIFont) -> Self

    @discardableResult
    func with(bodyText color: UIColor) -> Self

    @discardableResult
    func with(headerText color: UIColor) -> Self
    
    @discardableResult
    func with(captionText color: UIColor) -> Self

    @discardableResult
    func with(background color: UIColor) -> Self

    @discardableResult
    func with(navigationBarStyle: WalletNavigationBarStyleProtocol) -> Self

    @discardableResult
    func with(actionButtonStyle: WalletRoundedButtonStyleProtocol) -> Self

    @discardableResult
    func with(nameIconStyle: WalletNameIconStyleProtocol) -> Self

    @discardableResult
    func with(formCellStyle: WalletFormCellStyleProtocol) -> Self

    @discardableResult
    func with(modalActionStyle: WalletModalActionStyleProtocol) -> Self

    @discardableResult
    func with(accessoryStyle: WalletAccessoryStyleProtocol) -> Self

    @discardableResult
    func with(amountChangeStyle: WalletAmountChangeStyleProtocol) -> Self

    @discardableResult
    func with(statusStyleContainer: WalletTransactionStatusStyleContainerProtocol) -> Self

    @discardableResult
    func with(loadingOverlayStyle: WalletLoadingOverlayStyleProtocol) -> Self

    @discardableResult
    func with(thinBorder color: UIColor) -> Self

    @discardableResult
    func with(thickBorder color: UIColor) -> Self

    @discardableResult
    func with(downArrowIcon: UIImage?) -> Self

    @discardableResult
    func with(closeIcon: UIImage?) -> Self

    @discardableResult
    func with(shareIcon: UIImage?) -> Self

    @discardableResult
    func with(keyboardIcon: UIImage?) -> Self

    @discardableResult
    func with(caretColor: UIColor?) -> Self

    @discardableResult
    func with(inlineErrorStyle: WalletInlineErrorStyle) -> Self
}


final class WalletStyleBuilder: WalletStyleBuilderProtocol {
    private lazy var style = WalletStyle()

    func with(header1 font: UIFont) -> Self {
        style.header1Font = font
        return self
    }

    func with(header2 font: UIFont) -> Self {
        style.header2Font = font
        return self
    }

    func with(header3 font: UIFont) -> Self {
        style.header3Font = font
        return self
    }

    func with(header4 font: UIFont) -> Self {
        style.header4Font = font
        return self
    }

    func with(bodyRegular font: UIFont) -> Self {
        style.bodyRegularFont = font
        return self
    }

    func with(bodyBold font: UIFont) -> Self {
        style.bodyBoldFont = font
        return self
    }

    func with(small font: UIFont) -> Self {
        style.smallFont = font
        return self
    }

    func with(headerText color: UIColor) -> Self {
        style.headerTextColor = color
        return self
    }
    
    func with(captionText color: UIColor) -> Self {
        style.captionTextColor = color
        return self
    }

    func with(bodyText color: UIColor) -> Self {
        style.bodyTextColor = color
        return self
    }

    func with(background color: UIColor) -> Self {
        style.backgroundColor = color
        return self
    }

    func with(navigationBarStyle: WalletNavigationBarStyleProtocol) -> Self {
        style.internalNavigationBarStyle = navigationBarStyle
        return self
    }

    func with(actionButtonStyle: WalletRoundedButtonStyleProtocol) -> Self {
        style.internalActionButtonStyle = actionButtonStyle
        return self
    }

    func with(nameIconStyle: WalletNameIconStyleProtocol) -> Self {
        style.internalNameIconStyle = nameIconStyle
        return self
    }

    func with(formCellStyle: WalletFormCellStyleProtocol) -> Self {
        style.internalFormCellStyle = formCellStyle
        return self
    }

    func with(modalActionStyle: WalletModalActionStyleProtocol) -> Self {
        style.internalModalActionStyle = modalActionStyle
        return self
    }

    func with(accessoryStyle: WalletAccessoryStyleProtocol) -> Self {
        style.internalAccessoryStyle = accessoryStyle
        return self
    }

    func with(amountChangeStyle: WalletAmountChangeStyleProtocol) -> Self {
        style.amountChangeStyle = amountChangeStyle
        return self
    }

    func with(statusStyleContainer: WalletTransactionStatusStyleContainerProtocol) -> Self {
        style.statusStyleContainer = statusStyleContainer
        return self
    }

    func with(loadingOverlayStyle: WalletLoadingOverlayStyleProtocol) -> Self {
        style.internalLoadingOverlayStyle = loadingOverlayStyle
        return self
    }

    func with(thinBorder color: UIColor) -> Self {
        style.thinBorderColor = color
        return self
    }

    func with(thickBorder color: UIColor) -> Self {
        style.thickBorderColor = color
        return self
    }

    func with(downArrowIcon: UIImage?) -> Self {
        style.downArrowIcon = downArrowIcon
        return self
    }

    func with(closeIcon: UIImage?) -> Self {
        style.closeIcon = closeIcon
        return self
    }

    func with(shareIcon: UIImage?) -> Self {
        style.shareIcon = shareIcon
        return self
    }

    @discardableResult
    func with(keyboardIcon: UIImage?) -> Self {
        style.keyboardIcon = keyboardIcon
        return self
    }

    func with(caretColor: UIColor?) -> Self {
        style.caretColor = caretColor
        return self
    }

    func with(inlineErrorStyle: WalletInlineErrorStyle) -> Self {
        style.internalInlineErrorStyle = inlineErrorStyle
        return self
    }

    func build() -> WalletStyleProtocol {
        return style
    }
}
