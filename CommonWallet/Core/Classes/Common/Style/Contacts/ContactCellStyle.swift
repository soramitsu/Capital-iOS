/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public protocol ContactCellStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var nameIcon: WalletNameIconStyleProtocol { get }
    var accessoryIcon: UIImage? { get }
}


public struct ContactCellStyle: ContactCellStyleProtocol {
    public var title: WalletTextStyleProtocol
    public var nameIcon: WalletNameIconStyleProtocol
    public var accessoryIcon: UIImage?
    
    public init(title: WalletTextStyleProtocol,
                nameIcon: WalletNameIconStyleProtocol,
                accessoryIcon: UIImage?) {
        self.title = title
        self.nameIcon = nameIcon
        self.accessoryIcon = accessoryIcon
    }

}


extension ContactCellStyle {

    static func createDefaultStyle(with style: WalletStyleProtocol) -> ContactCellStyle {
        let title = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)
        let accessoryIcon = UIImage(named: "accessoryListIcon",
                                    in: Bundle(for: WalletStyle.self),
                                    compatibleWith: nil)
        return ContactCellStyle(title: title,
                                nameIcon: style.nameIconStyle,
                                accessoryIcon: accessoryIcon)
    }

}
