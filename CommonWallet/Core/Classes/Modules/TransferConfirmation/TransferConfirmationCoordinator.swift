/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public enum TransferCompletion {
    case showResult
    case hide
    case toast(view: UIViewController, presenter: UIViewController?)
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
        case .toast(let view, let presenter):
            resolver.navigation?.dismiss(animated: true)
            (presenter ?? UIApplication.shared.keyWindow?.rootViewController)?.present(view, animated: true, completion: nil)
        }
    }
}
