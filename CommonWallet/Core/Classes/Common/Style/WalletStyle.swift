/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


protocol WalletStyleProtocol {
    var header1Font: UIFont { get }
    var header2Font: UIFont { get }
    var header3Font: UIFont { get }
    var header4Font: UIFont { get }
    var bodyRegularFont: UIFont { get }
    var bodyBoldFont: UIFont { get }
    var smallFont: UIFont { get }
    var bodyTextColor: UIColor { get }
    var headerTextColor: UIColor { get }
    var captionTextColor: UIColor { get }
    var accentColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var navigationBarStyle: WalletNavigationBarStyleProtocol { get }
    var actionButtonStyle: WalletRoundedButtonStyleProtocol { get }
    var nameIconStyle: WalletNameIconStyleProtocol { get }
    var formCellStyle: WalletFormCellStyleProtocol { get }
    var modalActionStyle: WalletModalActionStyleProtocol { get }
    var accessoryListIcon: UIImage? { get }
    var accessoryStyle: WalletAccessoryStyleProtocol { get }
    var amountChangeStyle: WalletAmountChangeStyleProtocol { get }
    var statusStyleContainer: WalletTransactionStatusStyleContainerProtocol { get }
    var loadingOverlayStyle: WalletLoadingOverlayStyleProtocol { get }
    var thinBorderColor: UIColor { get }
    var thickBorderColor: UIColor { get }
    var downArrowIcon: UIImage? { get }
    var closeIcon: UIImage? { get }
    var keyboardIcon: UIImage? { get }
    var caretColor: UIColor? { get }
    var doneIcon: UIImage? { get }
    var shareIcon: UIImage? { get }
    var inlineErrorStyle: WalletInlineErrorStyleProtocol { get }
}


final class WalletStyle: WalletStyleProtocol {
    var header1Font: UIFont = .walletHeader1
    var header2Font: UIFont = .walletHeader2
    var header3Font: UIFont = .walletHeader3
    var header4Font: UIFont = .walletHeader4
    var bodyRegularFont: UIFont = .walletBodyRegular
    var bodyBoldFont: UIFont = .walletBodyBold
    var smallFont: UIFont = .walletSmall
    var bodyTextColor: UIColor = .bodyText
    var headerTextColor: UIColor = .headerText
    var captionTextColor: UIColor = .greyText
    var backgroundColor: UIColor = .background
    var thinBorderColor: UIColor = .thinBorder
    var thickBorderColor: UIColor = .thickBorder
    var accentColor: UIColor = .accentColor
    lazy var downArrowIcon: UIImage? = UIImage(named: "iconArrowDown",
                                               in: Bundle(for: type(of: self)),
                                               compatibleWith: nil)
    lazy var closeIcon: UIImage? = UIImage(named: "iconClose",
                                           in: Bundle(for: type(of: self)),
                                           compatibleWith: nil)
    lazy var keyboardIcon: UIImage? = UIImage(named: "iconKeyboardControl",
                                              in: Bundle(for: type(of: self)),
                                              compatibleWith: nil)
    
    lazy var doneIcon: UIImage? = UIImage(named: "iconDone",
                                          in: Bundle(for: type(of: self)),
                                          compatibleWith: nil)

    lazy var shareIcon: UIImage? = UIImage(named: "iconShare",
                                           in: Bundle(for: type(of: self)),
                                           compatibleWith: nil)

    lazy var accessoryListIcon: UIImage? = UIImage(named: "accessoryListIcon",
                                                   in: Bundle(for: type(of: self)),
                                                   compatibleWith: nil)

    lazy var amountChangeStyle: WalletAmountChangeStyleProtocol = {
        let increaseIcon = UIImage(named: "iconIncrease",
                                   in: Bundle(for: type(of: self)),
                                   compatibleWith: nil)
        let decreaseIcon = UIImage(named: "iconDecrease",
                                   in: Bundle(for: type(of: self)),
                                   compatibleWith: nil)

        return WalletAmountChangeStyle(increase: increaseIcon, decrease: decreaseIcon)
    }()

    lazy var statusStyleContainer: WalletTransactionStatusStyleContainerProtocol = {
        let approveIcon = UIImage(named: "iconApproved",
                                  in: Bundle(for: type(of: self)),
                                  compatibleWith: nil)

        let approveColor = UIColor.secondaryColor

        let approveStyle = WalletTransactionStatusStyle(icon: approveIcon,
                                                        color: approveColor)

        let pendingIcon = UIImage(named: "iconPending",
                              in: Bundle(for: type(of: self)),
                              compatibleWith: nil)

        let pendingColor = UIColor.bodyText

        let pendingStyle = WalletTransactionStatusStyle(icon: pendingIcon,
                                                        color: pendingColor)

        let rejectedIcon = UIImage(named: "iconRejected",
                                   in: Bundle(for: type(of: self)),
                                   compatibleWith: nil)

        let rejectedColor = UIColor.accentColor

        let rejectedStyle = WalletTransactionStatusStyle(icon: rejectedIcon,
                                                         color: rejectedColor)

        return WalletTransactionStatusStyleContainer(approved: approveStyle,
                                                     pending: pendingStyle,
                                                     rejected: rejectedStyle)
    }()

    var caretColor: UIColor?
    
    var internalNavigationBarStyle: WalletNavigationBarStyleProtocol?
    
    var navigationBarStyle: WalletNavigationBarStyleProtocol {
        if let style = internalNavigationBarStyle {
            return style
        } else {
            return WalletNavigationBarStyle(barColor: .white,
                                            shadowColor: thickBorderColor,
                                            itemTintColor: .accentColor,
                                            titleColor: headerTextColor,
                                            titleFont: header4Font)
        }
    }

    var internalActionButtonStyle: WalletRoundedButtonStyleProtocol?

    var actionButtonStyle: WalletRoundedButtonStyleProtocol {
        if let style = internalActionButtonStyle {
            return style
        } else {
            let enterAmountTitle = WalletTextStyle(font: bodyBoldFont, color: .accentColor)
            let enterAmountShadow = WalletShadowStyle(offset: CGSize(width: 0.0, height: 1.0),
                                                      color: bodyTextColor, opacity: 0.18, blurRadius: 1.0)
            return WalletRoundedButtonStyle(background: .white,
                                            title: enterAmountTitle,
                                            shadow: enterAmountShadow)
        }
    }

    var internalNameIconStyle: WalletNameIconStyleProtocol?

    var nameIconStyle: WalletNameIconStyleProtocol {
        if let style = internalNameIconStyle {
            return style
        } else {
            let title = WalletTextStyle(font: bodyRegularFont, color: .greyText)

            return WalletNameIconStyle(background: .white,
                                       title: title,
                                       radius: 15.0)
        }
    }

    var internalFormCellStyle: WalletFormCellStyleProtocol?

    var formCellStyle: WalletFormCellStyleProtocol {
        if let style = internalFormCellStyle {
            return style
        } else {
            let title = WalletTextStyle(font: bodyRegularFont,
                                        color: captionTextColor)
            let details = WalletTextStyle(font: bodyRegularFont,
                                          color: bodyTextColor)
            let link = WalletLinkStyle(normal: .normalLinkColor,
                                       highlighted: .highlightedLinkColor)

            return WalletFormCellStyle(title: title,
                                      details: details,
                                      link: link,
                                      separator: thinBorderColor)
        }
    }

    var internalModalActionStyle: WalletModalActionStyleProtocol?

    var modalActionStyle: WalletModalActionStyleProtocol {
        if let style = internalModalActionStyle {
            return style
        } else {
            return WalletModalActionStyle(fill: .white,
                                          cornerRadius: 10.0,
                                          stroke: nil,
                                          shadow: nil,
                                          doneIcon: doneIcon,
                                          backdropOpacity: 0.22)
        }
    }

    var internalAccessoryStyle: WalletAccessoryStyleProtocol?

    var accessoryStyle: WalletAccessoryStyleProtocol {
        if let style = internalAccessoryStyle {
            return style
        } else {
            let title = WalletTextStyle(font: bodyRegularFont, color: bodyTextColor)

            let actionTitle = WalletTextStyle(font: bodyBoldFont, color: .white)
            let action = WalletRoundedButtonStyle(background: accentColor, title: actionTitle)

            let separator = WalletStrokeStyle(color: thinBorderColor, lineWidth: 1.0)

            return WalletAccessoryStyle(title: title,
                                        action: action,
                                        separator: separator,
                                        background: backgroundColor)
        }
    }

    var internalLoadingOverlayStyle: WalletLoadingOverlayStyleProtocol?

    var loadingOverlayStyle: WalletLoadingOverlayStyleProtocol {
        if let style = internalLoadingOverlayStyle {
            return style
        } else {
            return WalletLoadingOverlayStyle.createDefault()
        }
    }

    var internalInlineErrorStyle: WalletInlineErrorStyleProtocol?

    var inlineErrorStyle: WalletInlineErrorStyleProtocol {
        if let style = internalInlineErrorStyle {
            return style
        } else {
            let errorColor = UIColor(red: 0.942, green: 0, blue: 0.044, alpha: 1)
            return WalletInlineErrorStyle(titleColor: errorColor, titleFont: smallFont)
        }
    }
}
