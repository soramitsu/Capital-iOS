/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol InvoiceScanViewStyleProtocol {
    var title: WalletTextStyle { get }
    var message: WalletTextStyle { get }
    var background: UIColor { get }
}

public struct InvoiceScanViewStyle: InvoiceScanViewStyleProtocol {
    public var title: WalletTextStyle
    public var message: WalletTextStyle
    public var background: UIColor

    public init(title: WalletTextStyle, message: WalletTextStyle, background: UIColor) {
        self.title = title
        self.message = message
        self.background = background
    }
}

extension InvoiceScanViewStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> InvoiceScanViewStyle {
        let title = WalletTextStyle(font: style.header3Font, color: .white)
        let message = WalletTextStyle(font: style.header3Font, color: .white)
        return InvoiceScanViewStyle(title: title,
                                    message: message,
                                    background: UIColor.black.withAlphaComponent(0.8))
    }
}
