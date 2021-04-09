/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class ControllerHideCommand: WalletHideCommandProtocol {
    let resolver: ResolverProtocol
    var actionType: WalletHideActionType
    var animated: Bool = true
    var completionBlock: (() -> Void)?

    init(resolver: ResolverProtocol, actionType: WalletHideActionType) {
        self.resolver = resolver
        self.actionType = actionType
    }

    func execute() throws {
        guard let navigation = resolver.navigation else {
            return
        }

        switch actionType {
        case .pop:
            navigation.pop(animated: animated)
        case .popToRoot:
            navigation.popToRoot(animated: animated)
        case .dismiss:
            navigation.dismiss(animated: animated, completion: completionBlock)
        }
    }
}
