/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import IrohaCommunication

public protocol WalletCommandFactoryProtocol: class {
    func prepareWithdrawCommand() -> WalletPresentationCommandProtocol
    func prepareSendCommand() -> WalletPresentationCommandProtocol
    func prepareReceiveCommand() -> WalletPresentationCommandProtocol
    func prepareAssetDetailsCommand(for assetId: IRAssetId) -> WalletPresentationCommandProtocol
    func prepareScanReceiverCommand() -> WalletPresentationCommandProtocol
}

public protocol CommonWalletContextProtocol: WalletCommandFactoryProtocol {
    func createRootController() throws -> UINavigationController
}
