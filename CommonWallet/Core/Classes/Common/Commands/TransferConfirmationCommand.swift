/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

final class TransferConfirmationCommand: WalletPresentationCommandProtocol {
    let payload: ConfirmationPayload
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)
    var animated: Bool = true
    var completionBlock: (() -> Void)?

    init(payload: ConfirmationPayload, resolver: ResolverProtocol) {
        self.payload = payload
        self.resolver = resolver
    }

    func execute() throws {
        guard let confirmationView = TransferConfirmationAssembly.assembleView(with: resolver,
                                                                               payload: payload),
            let navigation = resolver.navigation else {
            return
        }

        present(view: confirmationView.controller,
                in: navigation,
                animated: animated,
                completion: completionBlock)
    }
}
