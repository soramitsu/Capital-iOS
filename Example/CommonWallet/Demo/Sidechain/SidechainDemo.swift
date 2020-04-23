/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import CommonWallet
import IrohaCrypto
import SoraFoundation

final class SidechainDemo: DemoFactoryProtocol {
    var title: String {
        return "Sidechain"
    }

    var completionBlock: DemoCompletionBlock?

    func setupDemo(with completionBlock: @escaping DemoCompletionBlock) throws -> UIViewController {
        let accountId = "john@demo"
        let assets = try createAssets()

        let keypair = try IRIrohaKeyFactory().createRandomKeypair()

        let signer = IRIrohaSigner(privateKey: keypair.privateKey())

        var account = WalletAccountSettings(accountId: accountId, assets: assets)
        account.withdrawOptions = createWithdrawOptions()

        let networkResolver = DemoNetworkResolver()

        let withdrawType = WalletTransactionType(backendName: "WITHDRAW",
                                                 displayName: LocalizableResource { _ in "Withdraw" },
                                                 isIncome: false,
                                                 typeIcon: UIImage(named: "iconEth"))

        let operationSettings = MiddlewareOperationSettings(signer: signer, publicKey: keypair.publicKey())

        let networkFactory = MiddlewareOperationFactory(accountSettings: account,
                                                        operationSettings: operationSettings,
                                                        networkResolver: networkResolver)

        let walletBuilder =  CommonWalletBuilder
            .builder(with: account, networkOperationFactory: networkFactory)
            .with(transactionTypeList: [withdrawType])
            .with(inputValidatorFactory: DemoInputValidatorFactory())

        let demoTitleStyle = WalletTextStyle(font: UIFont(name: "HelveticaNeue-Bold", size: 16.0)!,
                                             color: .black)
        let demoHeaderViewModel = DemoHeaderViewModel(title: "Wallet",
                                                      style: demoTitleStyle)
        demoHeaderViewModel.delegate = self

        let demoHeaderNib = UINib(nibName: "DemoHeaderCell", bundle: Bundle(for: type(of: self)))
        try walletBuilder.accountListModuleBuilder
            .inserting(viewModelFactory: { demoHeaderViewModel }, at: 0)
            .with(cellNib: demoHeaderNib, for: demoHeaderViewModel.cellReuseIdentifier)

        walletBuilder.historyModuleBuilder
            .with(emptyStateDataSource: DefaultEmptyStateDataSource.history)
            .with(supportsFilter: true)

        let searchPlaceholder = LocalizableResource { _ in "Enter username" }
        walletBuilder.contactsModuleBuilder
            .with(searchPlaceholder: searchPlaceholder)
            .with(contactsEmptyStateDataSource: DefaultEmptyStateDataSource.contacts)
            .with(searchEmptyStateDataSource: DefaultEmptyStateDataSource.search)
            .with(scanPosition: .barButton)
            .with(withdrawOptionsPosition: .notInclude)
            .with(supportsLiveSearch: true)

        walletBuilder.receiveModuleBuilder
            .with(shouldIncludeDescription: true)

        walletBuilder.transactionDetailsModuleBuilder.with(sendBackTransactionTypes: ["INCOMING"])
        walletBuilder.transactionDetailsModuleBuilder.with(sendAgainTransactionTypes: ["OUTGOING"])

        let caretColor = UIColor(red: 208.0 / 255.0, green: 2.0 / 255.0, blue: 27.0 / 255.0, alpha: 1.0)
        walletBuilder.styleBuilder.with(caretColor: caretColor)

        walletBuilder.styleBuilder
            .with(header1: .demoHeader1)
            .with(header2: .demoHeader2)
            .with(header3: .demoHeader3)
            .with(header4: .demoHeader4)
            .with(bodyRegular: .demoBodyRegular)
            .with(small: .demoSmall)

        let walletContext = try walletBuilder.build()

        try mock(networkResolver: networkResolver, with: assets)

        self.completionBlock = completionBlock

        let rootController = try walletContext.createRootController()

        return rootController
    }

    func createAssets() throws -> [WalletAsset] {
        let soraAssetId = "sora#demo"
        let soraAsset = WalletAsset(identifier: soraAssetId,
                                    symbol: "ラ",
                                    details: LocalizableResource { _ in "Sora economy" },
                                    precision: 8)

        let d3AssetId = "d3#demo"
        let d3Asset = WalletAsset(identifier: d3AssetId,
                                  symbol: "元",
                                  details: LocalizableResource { _ in "Digital identity" },
                                  precision: 2)

        let vinceraAssetId = "vincera#demo"
        let vinceraAsset = WalletAsset(identifier: vinceraAssetId,
                                       symbol: "る",
                                       details: LocalizableResource { _ in "Pay for vine" },
                                       precision: 2)

        let moneaAssetId = "monea#demo"
        let moneaAsset = WalletAsset(identifier: moneaAssetId,
                                     symbol: "金",
                                     details: LocalizableResource { _ in "Fast money transfer" },
                                     precision: 5)

        return [soraAsset, d3Asset, vinceraAsset, moneaAsset]
    }

    func createWithdrawOptions() -> [WalletWithdrawOption] {
        let icon = UIImage(named: "iconEth")

        let etcLongTitle = "Send to my Ethereum Classic wallet"
        let etcShortTitle = "Withdraw to ETC"
        let etcDetails = "Ethereum Classic wallet address"
        let etcWithdrawOption = WalletWithdrawOption(identifier: UUID().uuidString,
                                                     symbol: "ETC",
                                                     shortTitle: etcShortTitle,
                                                     longTitle: etcLongTitle,
                                                     details: etcDetails,
                                                     icon: icon)

        let ethShortTitle = "Withdraw to ETH"
        let ethLongTitle = "Send to my Ethereum wallet"
        let ethDetails = "Ethereum wallet address"

        let ethWithdrawOption = WalletWithdrawOption(identifier: UUID().uuidString,
                                                     symbol: "ETH",
                                                     shortTitle: ethShortTitle,
                                                     longTitle: ethLongTitle,
                                                     details: ethDetails,
                                                     icon: icon)

        return [ethWithdrawOption, etcWithdrawOption]
    }
}

extension SidechainDemo: DemoHeaderViewModelDelegate {
    func didSelectClose(for viewModel: DemoHeaderViewModelProtocol) {
        completionBlock?(nil)
    }
}
