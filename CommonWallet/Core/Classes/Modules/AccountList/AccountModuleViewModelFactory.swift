/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

typealias AccountModuleViewModel = (models: [WalletViewModelProtocol], collapsingRange: Range<Int>)

protocol AccountModuleViewModelFactoryProtocol: class {
    var assets: [WalletAsset] { get }

    func createViewModel(from balances: [BalanceData],
                         delegate: ShowMoreViewModelDelegate?,
                         locale: Locale) throws -> AccountModuleViewModel
}

enum AccountModuleViewModelFactoryError: Error {
    case assetsRangeMatching
    case unexpectedAsset
}

final class AccountModuleViewModelFactory {
    let context: AccountListViewModelContextProtocol
    let assets: [WalletAsset]
    let commandFactory: WalletCommandFactoryProtocol
    let commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol?
    let amountFormatterFactory: NumberFormatterFactoryProtocol

    init(context: AccountListViewModelContextProtocol,
         assets: [WalletAsset],
         commandFactory: WalletCommandFactoryProtocol,
         commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol?,
         amountFormatterFactory: NumberFormatterFactoryProtocol) {
        self.context = context
        self.assets = assets
        self.commandFactory = commandFactory
        self.commandDecoratorFactory = commandDecoratorFactory
        self.amountFormatterFactory = amountFormatterFactory
    }

    private func createDefaultAssetViewModel(for asset: WalletAsset,
                                             balanceData: BalanceData,
                                             locale: Locale) -> AssetViewModelProtocol {
        var assetDetailsCommand: WalletCommandProtocol? = assets.count > 1 ?
        commandFactory.prepareAssetDetailsCommand(for: asset.identifier) : nil

        if
            let assetCommandDecorator = commandDecoratorFactory?
                .createAssetDetailsDecorator(with: commandFactory,
                                             asset: asset,
                                             balanceData: balanceData) {
            assetCommandDecorator.undelyingCommand = assetDetailsCommand
            assetDetailsCommand = assetCommandDecorator
        }

        let assetCellStyle = context.assetCellStyleFactory.createCellStyle(for: asset)

        let viewModel = AssetViewModel(cellReuseIdentifier: AccountModuleConstants.assetCellIdentifier,
                                       itemHeight: AccountModuleConstants.assetCellHeight,
                                       style: assetCellStyle,
                                       command: assetDetailsCommand)

        viewModel.assetId = asset.identifier

        let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

        let decimalBalance = balanceData.balance.decimalValue

        if let balanceString = amountFormatter.value(for: locale).string(from: decimalBalance as NSNumber) {
            viewModel.amount = balanceString
        } else {
            viewModel.amount = balanceData.balance.stringValue
        }

        let name = asset.name.value(for: locale)

        if let platform = asset.platform?.value(for: locale) {
            viewModel.details = "\(platform) \(name)"
        } else {
            viewModel.details = name
        }

        viewModel.symbol = asset.symbol

        return viewModel
    }

    private func createDefaultActionsViewModel() -> ActionsViewModelProtocol {
        let assetId = assets.count == 1 ? assets.first?.identifier : nil

        var sendCommand: WalletCommandProtocol = commandFactory.prepareSendCommand(for: assetId)

        if let sendDecorator = commandDecoratorFactory?.createSendCommandDecorator(with: commandFactory) {
            sendDecorator.undelyingCommand = sendCommand
            sendCommand = sendDecorator
        }

        let sendViewModel = ActionViewModel(title: L10n.Common.send,
                                            style: context.actionsStyle.sendText,
                                            command: sendCommand)

        var receiveCommand: WalletCommandProtocol = commandFactory.prepareReceiveCommand(for: assetId)

        if let receiveDecorator = commandDecoratorFactory?.createReceiveCommandDecorator(with: commandFactory) {
            receiveDecorator.undelyingCommand = receiveCommand
            receiveCommand = receiveDecorator
        }

        let receiveViewModel = ActionViewModel(title: L10n.Common.receive,
                                               style: context.actionsStyle.receiveText,
                                               command: receiveCommand)

        return ActionsViewModel(cellReuseIdentifier: AccountModuleConstants.actionsCellIdentifier,
                                itemHeight: AccountModuleConstants.actionsCellHeight,
                                sendViewModel: sendViewModel,
                                receiveViewModel: receiveViewModel)
    }

    private func createDefaultShowMoreViewModel(with delegate: ShowMoreViewModelDelegate?)
        -> ShowMoreViewModelProtocol {
        let viewModel = ShowMoreViewModel(cellReuseIdentifier: AccountModuleConstants.showMoreCellIdentifier,
                                          itemHeight: AccountModuleConstants.showMoreCellHeight,
                                          style: context.showMoreCellStyle)
        viewModel.delegate = delegate
        return viewModel
    }
}

extension AccountModuleViewModelFactory: AccountModuleViewModelFactoryProtocol {
    func createViewModel(from balances: [BalanceData],
                         delegate: ShowMoreViewModelDelegate?,
                         locale: Locale) throws -> AccountModuleViewModel {

        var viewModels = try context.viewModelFactoryContainer.viewModelFactories.map { try $0() }

        var collapsingRange = viewModels.count..<viewModels.count

        if balances.count > 0 {
            let assetViewModels: [WalletViewModelProtocol] = balances.compactMap { (balance) in
                guard let asset = assets.first(where: { $0.identifier == balance.identifier }) else {
                    return nil
                }

                if let assetViewModel = context.accountListViewModelFactory?
                    .createAssetViewModel(for: asset,
                                          balance: balance,
                                          commandFactory: commandFactory,
                                          locale: locale) {
                    return assetViewModel
                } else {
                    return createDefaultAssetViewModel(for: asset, balanceData: balance, locale: locale)
                }
            }

            var assetsBlockLength = assetViewModels.count

            let upper = context.viewModelFactoryContainer.assetsIndex + assetsBlockLength
            let lower = context.viewModelFactoryContainer.assetsIndex + Int(context.minimumVisibleAssets)
            collapsingRange = min(lower, upper)..<upper

            viewModels.insert(contentsOf: assetViewModels, at: context.viewModelFactoryContainer.assetsIndex)

            if !collapsingRange.isEmpty {
                if let showMoreViewModel = context.accountListViewModelFactory?
                    .createShowMoreViewModel(for: delegate,
                                             locale: locale) {
                    viewModels.append(showMoreViewModel)
                } else {
                    let showMoreViewModel = createDefaultShowMoreViewModel(with: delegate)
                    viewModels.append(showMoreViewModel)
                }

                assetsBlockLength += 1
            }

            if assets.contains(where: { $0.modes.contains(.transfer) }) {
                let assetId: String?

                if assets.count == 1 {
                    assetId = assets.first?.identifier
                } else {
                    assetId = nil
                }

                let actionsIndex = context.viewModelFactoryContainer.actionsIndex + assetsBlockLength - 1

                if let actionsViewModel = context.accountListViewModelFactory?
                    .createActionsViewModel(for: assetId,
                                            commandFactory: commandFactory,
                                            locale: locale) {
                    viewModels.insert(actionsViewModel, at: actionsIndex)
                } else {
                    let actionsViewModel = createDefaultActionsViewModel()
                    viewModels.insert(actionsViewModel, at: actionsIndex)
                }
            }
        }

        return AccountModuleViewModel(models: viewModels, collapsingRange: collapsingRange)
    }
}
