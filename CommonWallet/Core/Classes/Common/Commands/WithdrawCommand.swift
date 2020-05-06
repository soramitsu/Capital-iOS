/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

enum WithdrawCommandError: Error {
    case invalidAssetId
    case invalidOptionId
}

final class WithdrawCommand {
    let resolver: ResolverProtocol
    let assetId: String
    let optionId: String

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)
    var animated: Bool = true

    init(resolver: ResolverProtocol, assetId: String, optionId: String) {
        self.resolver = resolver
        self.optionId = optionId
        self.assetId = assetId
    }
}

extension WithdrawCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard let asset = resolver.account.asset(for: assetId) else {
            throw WithdrawCommandError.invalidAssetId
        }

        guard let option = resolver.account.withdrawOption(for: optionId) else {
            throw WithdrawCommandError.invalidOptionId
        }

        guard
            let withdrawView = WithdrawAssembly.assembleView(with: resolver, asset: asset, option: option),
            let navigation = resolver.navigation else {
                return
        }

        present(view: withdrawView.controller, in: navigation, animated: animated)
    }
}
