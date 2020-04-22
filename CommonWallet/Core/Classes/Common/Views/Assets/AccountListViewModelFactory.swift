/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol AccountListViewModelFactoryProtocol: class {
    func createAssetViewModel(for asset: WalletAsset,
                              balance: BalanceData,
                              commandFactory: WalletCommandFactoryProtocol) -> AssetViewModelProtocol?
    func createActionsViewModel(for assetId: String?,
                                commandFactory: WalletCommandFactoryProtocol) -> ActionsViewModelProtocol?
    func createShowMoreViewModel(for delegate: ShowMoreViewModelDelegate?) -> WalletViewModelProtocol?
}

extension AccountListViewModelFactoryProtocol {
    func createAssetViewModel(for asset: WalletAsset,
                              balance: BalanceData,
                              commandFactory: WalletCommandFactoryProtocol)
        -> AssetViewModelProtocol? {
        return nil
    }

    func createActionsViewModel(for assetId: String?,
                                commandFactory: WalletCommandFactoryProtocol) -> ActionsViewModelProtocol? {
        return nil
    }

    func createShowMoreViewModel(for delegate: ShowMoreViewModelDelegate?) -> WalletViewModelProtocol? {
        return nil
    }
}
