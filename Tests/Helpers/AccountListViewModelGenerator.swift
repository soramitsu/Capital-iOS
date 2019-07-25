/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
@testable import CommonWallet

func createAccountListAssetViewModel(asset: WalletAsset, balanceData: BalanceData, delegate: AssetViewModelDelegate?)
    throws -> AssetViewModelProtocol {
        let cardStyle = CardAssetStyle.createDefaultCardStyle(with: WalletStyle())
        let viewModel = AssetViewModel(cellReuseIdentifier: UUID().uuidString,
                                       itemHeight: CGFloat.random(in: 0...100),
                                       style: .card(cardStyle))
        viewModel.amount = balanceData.balance
        viewModel.details = asset.details
        viewModel.symbol = asset.symbol
        viewModel.delegate = delegate

        return viewModel
}

func createAccountListShowMoreViewModel(delegate: ShowMoreViewModelDelegate?) throws -> ShowMoreViewModelProtocol {
    let viewModel = ShowMoreViewModel(cellReuseIdentifier: UUID().uuidString,
                                      itemHeight: CGFloat.random(in: 0...100),
                                      style: WalletTextStyle(font: .walletHeader1, color: .black))
    viewModel.delegate = delegate
    return viewModel
}

func createAccountListActionsViewModel(delegate: ActionsViewModelDelegate?) throws -> ActionsViewModelProtocol {
    let textStyle = WalletTextStyle(font: .walletHeader1, color: .black)
    let viewModel = ActionsViewModel(cellReuseIdentifier: UUID().uuidString,
                                     itemHeight: CGFloat.random(in: 0...100),
                                     style: ActionsCellStyle(sendText: textStyle, receiveText: textStyle))

    viewModel.delegate = delegate
    return viewModel
}

func createAccountListViewModelContext(with minimumVisibleAssets: UInt) -> AccountListViewModelContext {
    return AccountListViewModelContext(assetViewModelFactory: createAccountListAssetViewModel,
                                       showMoreViewModelFactory: createAccountListShowMoreViewModel,
                                       actionsViewModelFactory: createAccountListActionsViewModel,
                                       minimumVisibleAssets: minimumVisibleAssets)
}
