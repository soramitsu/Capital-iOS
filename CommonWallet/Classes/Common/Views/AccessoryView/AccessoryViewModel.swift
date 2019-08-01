/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol AccessoryViewModelProtocol: class {
    var title: String { get }
    var icon: UIImage? { get }
    var action: String { get }
    var numberOfLines: Int { get }
}

final class AccessoryViewModel: AccessoryViewModelProtocol {
    var title: String
    var icon: UIImage?
    var action: String
    var numberOfLines: Int = 1

    init(title: String, action: String, icon: UIImage? = nil) {
        self.title = title
        self.icon = icon
        self.action = action
    }
}
