/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

public protocol WalletCommandFactoryProtocol: class {
    func prepareWithdrawCommand() -> WalletCommandProtocol
    func prepareSendCommand() -> WalletCommandProtocol
    func prepareReceiveCommand() -> WalletCommandProtocol
    func prepareAssetDetailsCommand(for assetId: IRAssetId) -> WalletCommandProtocol
    func prepareScanReceiverCommand() -> WalletCommandProtocol
}

public protocol CommonWalletContextProtocol: WalletCommandFactoryProtocol {
    func createRootController() throws -> UINavigationController
}
