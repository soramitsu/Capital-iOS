/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol MultilineTitleIconViewModelProtocol {
    var text: String { get }
    var icon: UIImage? { get }
}

struct MultilineTitleIconViewModel: MultilineTitleIconViewModelProtocol {
    let text: String
    let icon: UIImage?

    init(text: String, icon: UIImage? = nil) {
        self.text = text
        self.icon = icon
    }
}
