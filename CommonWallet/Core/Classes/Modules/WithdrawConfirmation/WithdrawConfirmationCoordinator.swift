/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class WithdrawConfirmationCoordinator: WithdrawConfirmationCoordinatorProtocol {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func showResult(for withdrawInfo: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption) {
        guard let resultView = WithdrawResultAssembly
            .assembleView(for: resolver, info: withdrawInfo, asset: asset, option: option) else {
                return
        }

        resolver.navigation?.set(resultView.controller, animated: true)
    }
}
