/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

enum WithdrawCommandError: Error {
    case invalidAssetId
    case invalidOptionId
}

final class WithdrawCommand {
    let resolver: ResolverProtocol
    let assetId: IRAssetId
    let optionId: String

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)
    var animated: Bool = true

    init(resolver: ResolverProtocol, assetId: IRAssetId, optionId: String) {
        self.resolver = resolver
        self.optionId = optionId
        self.assetId = assetId
    }
}

extension WithdrawCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard let asset = resolver.account.asset(for: assetId.identifier()) else {
            throw WithdrawCommandError.invalidAssetId
        }

        guard let option = resolver.account.withdrawOption(for: optionId) else {
            throw WithdrawCommandError.invalidOptionId
        }

        guard
            let withdrawView = WithdrawAmountAssembly.assembleView(with: resolver, asset: asset, option: option),
            let navigation = resolver.navigation else {
                return
        }

        present(view: withdrawView.controller, in: navigation, animated: animated)
    }
}
