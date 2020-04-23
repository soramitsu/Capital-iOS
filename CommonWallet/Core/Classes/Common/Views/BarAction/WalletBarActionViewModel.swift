/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

enum WalletBarActionDisplayType {
    case title(_ title: String)
    case icon(_ image: UIImage)
}

protocol WalletBarActionViewModelProtocol {
    var displayType: WalletBarActionDisplayType { get }
    var command: WalletCommandProtocol { get }
}

struct WalletBarActionViewModel: WalletBarActionViewModelProtocol {
    let displayType: WalletBarActionDisplayType
    let command: WalletCommandProtocol
}
