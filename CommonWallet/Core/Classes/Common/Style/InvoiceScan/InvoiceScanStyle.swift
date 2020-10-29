/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol InvoiceScanViewStyleProtocol {
    var background: UIColor { get }
    var title: WalletTextStyle { get }
    var message: WalletTextStyle { get }
    var maskBackground: UIColor { get }
    var upload: WalletRoundedButtonStyleProtocol { get }
}

public struct InvoiceScanViewStyle: InvoiceScanViewStyleProtocol {
    public var title: WalletTextStyle
    public var message: WalletTextStyle
    public var background: UIColor
    public var maskBackground: UIColor
    public var upload: WalletRoundedButtonStyleProtocol

    public init(background: UIColor,
                title: WalletTextStyle,
                message: WalletTextStyle,
                maskBackground: UIColor,
                upload: WalletRoundedButtonStyleProtocol) {
        self.background = background
        self.title = title
        self.message = message
        self.maskBackground = maskBackground
        self.upload = upload
    }
}

extension InvoiceScanViewStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> InvoiceScanViewStyle {
        let title = WalletTextStyle(font: style.header3Font, color: .white)
        let message = WalletTextStyle(font: style.header3Font, color: .white)

        let uploadTitle = WalletTextStyle(font: style.bodyBoldFont, color: .white)
        let upload = WalletRoundedButtonStyle(background: style.accentColor, title: uploadTitle)

        return InvoiceScanViewStyle(background: style.backgroundColor,
                                    title: title,
                                    message: message,
                                    maskBackground: UIColor.black.withAlphaComponent(0.8),
                                    upload: upload)
    }
}
