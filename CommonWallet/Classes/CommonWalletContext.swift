/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

public protocol WalletCommandFactoryProtocol: class {
    func prepareSendCommand() -> WalletPresentationCommandProtocol
    func prepareReceiveCommand() -> WalletPresentationCommandProtocol
    func prepareAssetDetailsCommand(for assetId: IRAssetId) -> WalletPresentationCommandProtocol
    func prepareScanReceiverCommand(defaultAssetId: IRAssetId) -> WalletPresentationCommandProtocol
    func prepareWithdrawCommand(for option: WalletWithdrawOption, assetId: IRAssetId)
        -> WalletPresentationCommandProtocol
}

public protocol CommonWalletContextProtocol: WalletCommandFactoryProtocol {
    func createRootController() throws -> UINavigationController
}
