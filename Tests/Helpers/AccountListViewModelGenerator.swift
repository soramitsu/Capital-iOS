/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
@testable import CommonWallet

func createAccountListAssetViewModel(asset: WalletAsset, balanceData: BalanceData, commandFactory: WalletCommandFactoryProtocol)
    throws -> AssetViewModelProtocol {
        let assetCommand = commandFactory.prepareAssetDetailsCommand(for: asset.identifier)
        let cardStyle = CardAssetStyle.createDefaultCardStyle(with: WalletStyle())
        let viewModel = AssetViewModel(cellReuseIdentifier: UUID().uuidString,
                                       itemHeight: CGFloat.random(in: 0...100),
                                       style: .card(cardStyle),
                                       command: assetCommand)
        viewModel.amount = balanceData.balance
        viewModel.details = asset.details
        viewModel.symbol = asset.symbol

        return viewModel
}

func createAccountListShowMoreViewModel(delegate: ShowMoreViewModelDelegate?) throws -> ShowMoreViewModelProtocol {
    let viewModel = ShowMoreViewModel(cellReuseIdentifier: UUID().uuidString,
                                      itemHeight: CGFloat.random(in: 0...100),
                                      style: WalletTextStyle(font: .walletHeader1, color: .black))
    viewModel.delegate = delegate
    return viewModel
}

func createAccountListActionsViewModel(commandFactory: WalletCommandFactoryProtocol) throws -> ActionsViewModelProtocol {
    let sendCommand = commandFactory.prepareSendCommand()
    let receiveCommand = commandFactory.prepareReceiveCommand()
    let textStyle = WalletTextStyle(font: .walletHeader1, color: .black)
    let viewModel = ActionsViewModel(cellReuseIdentifier: UUID().uuidString,
                                     itemHeight: CGFloat.random(in: 0...100),
                                     style: ActionsCellStyle(sendText: textStyle, receiveText: textStyle),
                                     sendCommand: sendCommand,
                                     receiveCommand: receiveCommand)

    return viewModel
}

func createAccountListViewModelContext(with minimumVisibleAssets: UInt) -> AccountListViewModelContext {
    return AccountListViewModelContext(assetViewModelFactory: createAccountListAssetViewModel,
                                       showMoreViewModelFactory: createAccountListShowMoreViewModel,
                                       actionsViewModelFactory: createAccountListActionsViewModel,
                                       minimumVisibleAssets: minimumVisibleAssets)
}
