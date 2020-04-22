/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public enum WalletHideActionType {
    case dismiss
    case pop
    case popToRoot
}

public protocol WalletHideCommandProtocol: WalletCommandProtocol {
    var actionType: WalletHideActionType { get set }
    var animated: Bool { get set }
}
