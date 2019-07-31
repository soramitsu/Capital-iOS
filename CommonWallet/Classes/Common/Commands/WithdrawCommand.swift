/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

final class WithdrawCommand {
    let resolver: ResolverProtocol
    let option: WalletWithdrawOption
    let assetId: IRAssetId

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)

    init(resolver: ResolverProtocol, option: WalletWithdrawOption, assetId: IRAssetId) {
        self.resolver = resolver
        self.option = option
        self.assetId = assetId
    }
}

extension WithdrawCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard let asset = resolver.account
            .assets.first(where: { $0.identifier.identifier() == assetId.identifier() }) else {
            return
        }

        let payload = WithdrawPayload(asset: asset, option: option)

        guard
            let withdrawView = WithdrawAmountAssembly.assembleView(with: resolver, payload: payload),
            let navigation = resolver.navigation else {
                return
        }

        present(view: withdrawView, in: navigation)
    }
}
