/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol ContactsSectionStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var uppercased: Bool { get }
    var height: CGFloat { get }
}


public struct ContactsSectionStyle: ContactsSectionStyleProtocol {
    public var title: WalletTextStyleProtocol
    public var uppercased: Bool
    public var height: CGFloat

    public init(title: WalletTextStyleProtocol,
                uppercased: Bool,
                height: CGFloat) {
        self.title = title
        self.uppercased = uppercased
        self.height = height
    }

}


extension ContactsSectionStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> ContactsSectionStyle {
        let title = WalletTextStyle(font: style.bodyRegularFont,
                                    color: style.captionTextColor)
        return ContactsSectionStyle(title: title, uppercased: false, height: 55.0)
    }
}
