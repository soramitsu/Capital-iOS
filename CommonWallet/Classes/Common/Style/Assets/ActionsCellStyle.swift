/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public struct ActionsCellStyle {
    public var sendText: WalletTextStyle
    public var receiveText: WalletTextStyle

    public init(sendText: WalletTextStyle, receiveText: WalletTextStyle) {
        self.sendText = sendText
        self.receiveText = receiveText
    }
}

extension ActionsCellStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> ActionsCellStyle {
        return ActionsCellStyle(sendText: WalletTextStyle(font: style.bodyBoldFont, color: .accentColor),
                                receiveText: WalletTextStyle(font: style.bodyBoldFont, color: .secondaryColor))
    }
}
