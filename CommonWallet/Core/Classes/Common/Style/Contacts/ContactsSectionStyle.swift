/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol ContactsSectionStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var uppercased: Bool { get }
    var height: CGFloat { get }
    var displaysSeparatorForLastCell: Bool { get }
}


public struct ContactsSectionStyle: ContactsSectionStyleProtocol {
    public var title: WalletTextStyleProtocol
    public var uppercased: Bool
    public var height: CGFloat
    public var displaysSeparatorForLastCell: Bool

    public init(title: WalletTextStyleProtocol,
                uppercased: Bool,
                height: CGFloat,
                displaysSeparatorForLastCell: Bool) {
        self.title = title
        self.uppercased = uppercased
        self.height = height
        self.displaysSeparatorForLastCell = displaysSeparatorForLastCell
    }

}


extension ContactsSectionStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> ContactsSectionStyle {
        let title = WalletTextStyle(font: style.bodyRegularFont,
                                    color: style.captionTextColor)
        return ContactsSectionStyle(title: title,
                                    uppercased: false,
                                    height: 55.0,
                                    displaysSeparatorForLastCell: false)
    }
}
