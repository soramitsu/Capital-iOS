/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol ContactAccessoryViewModelFactoryProtocol: class {
    func createViewModel(from title: String, action: String, icon: UIImage?) -> AccessoryViewModel
    func createViewModel(from title: String, fullName: String, action: String) -> AccessoryViewModel
}

final class ContactAccessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol {
    var style: WalletNameIconStyleProtocol
    var radius: CGFloat

    init(style: WalletNameIconStyleProtocol, radius: CGFloat) {
        self.style = style
        self.radius = radius
    }

    func createViewModel(from title: String, action: String, icon: UIImage?) -> AccessoryViewModel {
        return AccessoryViewModel(title: title, action: action, icon: icon)
    }

    func createViewModel(from title: String, fullName: String, action: String) -> AccessoryViewModel {
        let icon = UIImage.createAvatar(fullName: fullName,
                                        radius: radius,
                                        style: style)

        return AccessoryViewModel(title: title, action: action, icon: icon)
    }
}
