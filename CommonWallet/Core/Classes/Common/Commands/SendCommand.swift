/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

enum SendCommandError: Error {
    case invalidAssetId
    case noAssets
}

final class SendCommand {
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .modal(inNavigation: true)
    var animated: Bool = true

    let selectedAssetId: String?

    init(resolver: ResolverProtocol, selectedAssetId: String? = nil) {
        self.resolver = resolver
        self.selectedAssetId = selectedAssetId
    }
}

extension SendCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard let assetId = selectedAssetId ?? resolver.account.assets.first?.identifier else {
            throw SendCommandError.noAssets
        }

        guard let asset = resolver.account.asset(for: assetId) else {
            throw SendCommandError.invalidAssetId
        }

        guard
            let contactsView = ContactsAssembly.assembleView(with: resolver, selectedAsset: asset),
            let navigation = resolver.navigation else {
            return
        }

        present(view: contactsView.controller, in: navigation, animated: animated)
    }
}
