/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

public protocol AssetDetailsCommadProtocol: WalletPresentationCommandProtocol {
    var ignoredWhenSingleAsset: Bool { get set }
}

final class AssetDetailsCommand {
    let resolver: ResolverProtocol
    let assetId: String

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)
    var animated: Bool = true
    var completionBlock: (() -> Void)?

    var ignoredWhenSingleAsset: Bool = true

    init(resolver: ResolverProtocol, assetId: String) {
        self.resolver = resolver
        self.assetId = assetId
    }
}

extension AssetDetailsCommand: AssetDetailsCommadProtocol {
    func execute() throws {
        if ignoredWhenSingleAsset, resolver.account.assets.count <= 1 {
            return
        }

        guard let asset = resolver.account.asset(for: assetId) else {
            throw CommandError.invalidAssetId
        }

        guard
            let assetDetailsView = AccountDetailsAssembly.assembleView(with: resolver, asset: asset),
            let navigation = resolver.navigation else {
            return
        }

        present(view: assetDetailsView.controller,
                in: navigation,
                animated: animated,
                completion: completionBlock)
    }
}
