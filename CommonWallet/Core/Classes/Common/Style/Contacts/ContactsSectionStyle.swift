/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol ContactsSectionStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var uppercased: Bool { get }
}


public struct ContactsSectionStyle: ContactsSectionStyleProtocol {
    public var title: WalletTextStyleProtocol
    public var uppercased: Bool

    public init(title: WalletTextStyleProtocol,
                uppercased: Bool) {
        self.title = title
        self.uppercased = uppercased
    }

}


extension ContactsSectionStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> ContactsSectionStyle {
        let title = WalletTextStyle(font: style.bodyRegularFont,
                                    color: style.captionTextColor)
        return ContactsSectionStyle(title: title, uppercased: false)
    }
}
