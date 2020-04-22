/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol InvoiceScanViewStyleProtocol {
    var title: WalletTextStyle { get }
    var message: WalletTextStyle { get }
    var background: UIColor { get }
    var upload: WalletRoundedButtonStyleProtocol { get }
}

public struct InvoiceScanViewStyle: InvoiceScanViewStyleProtocol {
    public var title: WalletTextStyle
    public var message: WalletTextStyle
    public var background: UIColor
    public var upload: WalletRoundedButtonStyleProtocol

    public init(title: WalletTextStyle,
                message: WalletTextStyle,
                background: UIColor,
                upload: WalletRoundedButtonStyleProtocol) {
        self.title = title
        self.message = message
        self.background = background
        self.upload = upload
    }
}

extension InvoiceScanViewStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> InvoiceScanViewStyle {
        let title = WalletTextStyle(font: style.header3Font, color: .white)
        let message = WalletTextStyle(font: style.header3Font, color: .white)

        let uploadTitle = WalletTextStyle(font: style.bodyBoldFont, color: .white)
        let upload = WalletRoundedButtonStyle(background: style.accentColor, title: uploadTitle)

        return InvoiceScanViewStyle(title: title,
                                    message: message,
                                    background: UIColor.black.withAlphaComponent(0.8),
                                    upload: upload)
    }
}
