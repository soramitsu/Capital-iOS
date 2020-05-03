/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

final class WithdrawAmountCoordinator: WithdrawCoordinatorProtocol {
    var resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    func confirm(with info: WithdrawInfo, asset: WalletAsset, option: WalletWithdrawOption) {
        guard let confirmationView = WithdrawConfirmationAssembly
            .assembleView(for: resolver, info: info, asset: asset, option: option) else {
                return
        }

        resolver.navigation?.push(confirmationView.controller)
    }
}
