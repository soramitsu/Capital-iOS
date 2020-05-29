/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

final class TransferCommand {
    let resolver: ResolverProtocol
    let payload: TransferPayload

    var presentationStyle: WalletPresentationStyle = .modal(inNavigation: true)
    var animated: Bool = true

    init(resolver: ResolverProtocol, payload: TransferPayload) {
        self.resolver = resolver
        self.payload = payload
    }
}

extension TransferCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard
            let view = TransferAssembly.assembleView(with: resolver, payload: payload),
            let navigation = resolver.navigation else {
            return
        }

        present(view: view.controller, in: navigation, animated: animated)
    }
}
