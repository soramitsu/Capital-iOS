/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

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

    func prepareSendCommand(for assetId: String?) -> WalletPresentationCommandProtocol {
        return SendCommand(resolver: self, selectedAssetId: assetId)
    }

    func prepareReceiveCommand(for assetId: String?) -> WalletPresentationCommandProtocol {
        return ReceiveCommand(resolver: self, selectedAssetId: assetId)
    }

    func prepareAssetDetailsCommand(for assetId: String) -> AssetDetailsCommadProtocol {
        return AssetDetailsCommand(resolver: self, assetId: assetId)
    }

    func prepareScanReceiverCommand() -> WalletPresentationCommandProtocol {
        return ScanReceiverCommand(resolver: self)
    }

    func prepareWithdrawCommand(for assetId: String, optionId: String)
        -> WalletPresentationCommandProtocol {
            return WithdrawCommand(resolver: self, assetId: assetId, optionId: optionId)
    }

    func preparePresentationCommand(for controller: UIViewController) -> WalletPresentationCommandProtocol {
        return ControllerPresentationCommand(resolver: self, controller: controller)
    }

    func prepareHideCommand(with actionType: WalletHideActionType) -> WalletHideCommandProtocol {
        return ControllerHideCommand(resolver: self, actionType: actionType)
    }

    func prepareAccountUpdateCommand() -> WalletCommandProtocol {
        return AccountUpdateCommand(resolver: self)
    }

    func prepareLanguageSwitchCommand(with newLanguage: WalletLanguage) -> WalletCommandProtocol {
        return LanguageSwitchCommand(resolver: self, language: newLanguage)
    }

    func prepareTransactionDetailsCommand(with transaction: AssetTransactionData) -> WalletPresentationCommandProtocol {
        return TransactionDetailsCommand(resolver: self, transaction: transaction)
    }

    func prepareTransfer(with payload: TransferPayload) -> WalletPresentationCommandProtocol {
        return TransferCommand(resolver: self, payload: payload)
    }
}
