/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

public protocol AssetDetailsCommadProtocol: WalletPresentationCommandProtocol {
    var ignoredWhenSingleAsset: Bool { get set }
}

enum AssetDetailsCommandError: Error {
    case invalidAssetId
}

final class AssetDetailsCommand {
    let resolver: ResolverProtocol
    let assetId: IRAssetId

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)
    var animated: Bool = true

    var ignoredWhenSingleAsset: Bool = true

    init(resolver: ResolverProtocol, assetId: IRAssetId) {
        self.resolver = resolver
        self.assetId = assetId
    }
}

extension AssetDetailsCommand: AssetDetailsCommadProtocol {
    func execute() throws {
        if ignoredWhenSingleAsset, resolver.account.assets.count <= 1 {
            return
        }

        guard let asset = resolver.account.asset(for: assetId.identifier()) else {
            throw AssetDetailsCommandError.invalidAssetId
        }

        guard
            let assetDetailsView = AccountDetailsAssembly.assembleView(with: resolver, asset: asset),
            let navigation = resolver.navigation else {
            return
        }

        present(view: assetDetailsView.controller, in: navigation, animated: animated)
    }
}
