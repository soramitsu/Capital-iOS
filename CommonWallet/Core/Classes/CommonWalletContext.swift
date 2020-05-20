/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation

public protocol WalletCommandFactoryProtocol: class {
    func prepareSendCommand(for assetId: String?) -> WalletPresentationCommandProtocol
    func prepareReceiveCommand(for assetId: String?) -> WalletPresentationCommandProtocol
    func prepareAssetDetailsCommand(for assetId: String) -> AssetDetailsCommadProtocol
    func prepareScanReceiverCommand() -> WalletPresentationCommandProtocol
    func prepareWithdrawCommand(for assetId: String, optionId: String)
        -> WalletPresentationCommandProtocol
    func preparePresentationCommand(for controller: UIViewController)
        -> WalletPresentationCommandProtocol
    func prepareHideCommand(with actionType: WalletHideActionType) -> WalletHideCommandProtocol
    func prepareAccountUpdateCommand() -> WalletCommandProtocol
    func prepareLanguageSwitchCommand(with newLanguage: WalletLanguage) -> WalletCommandProtocol
    func prepareTransactionDetailsCommand(with transaction: AssetTransactionData) -> WalletPresentationCommandProtocol
    func prepareTransfer(with payload: TransferPayload) -> WalletPresentationCommandProtocol
}

public protocol CommonWalletContextProtocol: WalletCommandFactoryProtocol {
    func createRootController() throws -> UINavigationController
}
