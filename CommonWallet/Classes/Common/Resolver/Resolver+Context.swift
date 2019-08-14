/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

extension Resolver: CommonWalletContextProtocol {
    func createRootController() throws -> UINavigationController {
        guard let dashboardView = DashboardAssembly.assembleView(with: self) else {
            throw CommonWalletBuilderError.moduleCreationFailed
        }

        let navigationController = WalletNavigationController(rootViewController: dashboardView.controller)
        let navigation = Navigation(navigationController: navigationController, style: style)
        self.navigation = navigation

        return navigationController
    }

    func prepareSendCommand() -> WalletPresentationCommandProtocol {
        return SendCommand(resolver: self)
    }

    func prepareReceiveCommand() -> WalletPresentationCommandProtocol {
        return ReceiveCommand(resolver: self)
    }

    func prepareAssetDetailsCommand(for assetId: IRAssetId) -> WalletPresentationCommandProtocol {
        return AssetDetailsCommand(resolver: self, assetId: assetId)
    }

    func prepareScanReceiverCommand(defaultAssetId: IRAssetId) -> WalletPresentationCommandProtocol {
        return ScanReceiverCommand(resolver: self, defaultAssetId: defaultAssetId)
    }


    func prepareWithdrawCommand(for option: WalletWithdrawOption, assetId: IRAssetId)
        -> WalletPresentationCommandProtocol {
            return WithdrawCommand(resolver: self, option: option, assetId: assetId)
    }
}
