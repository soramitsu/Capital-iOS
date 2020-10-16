/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol WalletCommandDecoratorProtocol: WalletCommandProtocol {
    var undelyingCommand: WalletCommandProtocol? { get set }
}

public protocol WalletCommandDecoratorFactoryProtocol: class {
    func createSendCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol?
    func createReceiveCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol?
    func createAssetDetailsDecorator(with commandFactory: WalletCommandFactoryProtocol,
                                     asset: WalletAsset,
                                     balanceData: BalanceData?) -> WalletCommandDecoratorProtocol?

    func createTransferConfirmationDecorator(with commandFactory: WalletCommandFactoryProtocol,
                                             payload: ConfirmationPayload) -> WalletCommandDecoratorProtocol?
}

public extension WalletCommandDecoratorFactoryProtocol {
    func createSendCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol? {
        nil
    }

    func createReceiveCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol? {
        nil
    }

    func createAssetDetailsDecorator(with commandFactory: WalletCommandFactoryProtocol,
                                     asset: WalletAsset,
                                     balanceData: BalanceData?) -> WalletCommandDecoratorProtocol? {
        nil
    }

    func createTransferConfirmationDecorator(with commandFactory: WalletCommandFactoryProtocol,
                                             payload: ConfirmationPayload)
        -> WalletCommandDecoratorProtocol? {
        nil
    }
}
