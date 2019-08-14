/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

typealias AccountModuleViewModel = (models: [WalletViewModelProtocol], collapsingRange: Range<Int>)

protocol AccountModuleViewModelFactoryProtocol: class {
    var assets: [WalletAsset] { get }

    func createViewModel(from balances: [BalanceData],
                         delegate: ShowMoreViewModelDelegate?) throws -> AccountModuleViewModel
}

enum AccountModuleViewModelFactoryError: Error {
    case assetsRangeMatching
    case unexpectedAsset
}

final class AccountModuleViewModelFactory {
    let context: AccountListViewModelContextProtocol
    let assets: [WalletAsset]
    let commandFactory: WalletCommandFactoryProtocol

    init(context: AccountListViewModelContextProtocol,
         assets: [WalletAsset],
         commandFactory: WalletCommandFactoryProtocol) {
        self.context = context
        self.assets = assets
        self.commandFactory = commandFactory
    }
}

extension AccountModuleViewModelFactory: AccountModuleViewModelFactoryProtocol {
    func createViewModel(from balances: [BalanceData],
                         delegate: ShowMoreViewModelDelegate?) throws -> AccountModuleViewModel {
        var viewModels = try context.viewModelFactories.map { try $0() }

        var collapsingRange = viewModels.count..<viewModels.count

        if balances.count > 0 {
            let assetViewModels: [AssetViewModelProtocol] = try balances.compactMap { (balance) in
                guard let asset = assets.first(where: { $0.identifier.identifier() == balance.identifier }) else {
                    return nil
                }

                return try context.assetViewModelFactory(asset, balance, commandFactory)
            }

            var assetsBlockLength = assetViewModels.count

            let upper = context.assetsIndex + assetsBlockLength
            let lower = context.assetsIndex + Int(context.minimumVisibleAssets)
            collapsingRange = min(lower, upper)..<upper

            viewModels.insert(contentsOf: assetViewModels, at: context.assetsIndex)

            if !collapsingRange.isEmpty {
                let showMoreViewModel = try context.showMoreViewModelFactory(delegate)
                viewModels.append(showMoreViewModel)

                assetsBlockLength += 1
            }

            let actionsIndex = context.actionsIndex + assetsBlockLength - 1

            let actionsViewModel = try context.actionsViewModelFactory(commandFactory)
            viewModels.insert(actionsViewModel, at: actionsIndex)
        }

        return AccountModuleViewModel(models: viewModels, collapsingRange: collapsingRange)
    }
}
