/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public enum TransferCompletion {
    case showResult
    case hide
}

final class TransferConfirmationCoordinator: TransferConfirmationCoordinatorProtocol {
    let resolver: ResolverProtocol
    let completion: TransferCompletion

    init(resolver: ResolverProtocol, completion: TransferCompletion) {
        self.resolver = resolver
        self.completion = completion
    }

    func proceed(payload: ConfirmationPayload) {
        switch completion {
        case .showResult:
            guard let view = TransferResultAssembly.assembleView(resolver: resolver, payload: payload) else {
                return
            }

            resolver.navigation?.set(view.controller, animated: true)
        case .hide:
            resolver.navigation?.dismiss(animated: true)
        }
    }
}
