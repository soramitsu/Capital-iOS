/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol AccountListViewModelFactoryProtocol: class {
    func createAssetViewModel(for asset: WalletAsset,
                              balance: BalanceData,
                              commandFactory: WalletCommandFactoryProtocol,
                              locale: Locale) -> WalletViewModelProtocol?
    func createActionsViewModel(for assetId: String?,
                                commandFactory: WalletCommandFactoryProtocol,
                                locale: Locale) -> WalletViewModelProtocol?
    func createShowMoreViewModel(for delegate: ShowMoreViewModelDelegate?,
                                 locale: Locale) -> WalletViewModelProtocol?
}

public extension AccountListViewModelFactoryProtocol {
    func createAssetViewModel(for asset: WalletAsset,
                              balance: BalanceData,
                              commandFactory: WalletCommandFactoryProtocol,
                              locale: Locale)
        -> WalletViewModelProtocol? {
        return nil
    }

    func createActionsViewModel(for assetId: String?,
                                commandFactory: WalletCommandFactoryProtocol,
                                locale: Locale) -> WalletViewModelProtocol? {
        return nil
    }

    func createShowMoreViewModel(for delegate: ShowMoreViewModelDelegate?,
                                 locale: Locale) -> WalletViewModelProtocol? {
        return nil
    }
}
