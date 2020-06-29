/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import CommonWallet

final class DialogCommandDecoratorFactory: WalletCommandDecoratorFactoryProtocol {
    func createSendCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol? {
        let message = "Send command was intercepted by send decorator"
        return DialogCommandDecorator(commandFactory: commandFactory, message: message)
    }

    func createReceiveCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol? {
        let message = "Receive command was intercepted by receive decorator"
        return DialogCommandDecorator(commandFactory: commandFactory, message: message)
    }

    func createAssetDetailsDecorator(with commandFactory: WalletCommandFactoryProtocol,
                                     asset: WalletAsset,
                                     balanceData: BalanceData?) -> WalletCommandDecoratorProtocol? {
        let message = "Asset details command was intercepted by decorator"
        return DialogCommandDecorator(commandFactory: commandFactory, message: message)
    }
}
