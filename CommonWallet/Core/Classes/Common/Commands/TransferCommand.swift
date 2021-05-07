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
    var completionBlock: (() -> Void)?

    init(resolver: ResolverProtocol, payload: TransferPayload) {
        self.resolver = resolver
        self.payload = payload
    }
}

extension TransferCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        if
            let assetId = payload.receiveInfo.assetId,
            let asset = resolver.account.asset(for: assetId),
            !asset.modes.contains(.transfer) {

            throw CommandError.notEligibleAsset
        }

        if
            payload.receiveInfo.assetId == nil,
            resolver.account.assets.filter({ $0.modes.contains(.transfer)}).isEmpty {

            throw CommandError.noAssets
        }

        guard
            let view = TransferAssembly.assembleView(with: resolver, payload: payload),
            let navigation = resolver.navigation else {
            return
        }

        present(view: view.controller,
                in: navigation,
                animated: animated,
                completion: completionBlock)
    }
}
