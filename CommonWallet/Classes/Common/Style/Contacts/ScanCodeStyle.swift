/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public protocol SendOptionCellStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var accessoryIcon: UIImage? { get }
}


public struct SendOptionCellStyle: SendOptionCellStyleProtocol {
    public var title: WalletTextStyleProtocol
    public var accessoryIcon: UIImage?
    
    public init(title: WalletTextStyleProtocol,
                accessoryIcon: UIImage?) {
        self.title = title
        self.accessoryIcon = accessoryIcon
    }
}


extension SendOptionCellStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> SendOptionCellStyle {
        let title = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)

        return SendOptionCellStyle(title: title,
                                   accessoryIcon: style.accessoryListIcon)
    }
}
