/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import UIKit
import CommonWallet
import IrohaCommunication

final class CommandDecoratorDemo: DemoFactoryProtocol {
    var title: String {
        return "Command Decorator"
    }

    var completionBlock: DemoCompletionBlock?

    func setupDemo(with completionBlock: @escaping DemoCompletionBlock) throws -> UIViewController {
        let accountId = try IRAccountIdFactory.account(withIdentifier: "julio@demo")
        let assets = try createAssets()

        guard let keypair = IREd25519KeyFactory().createRandomKeypair() else {
            throw DemoFactoryError.keypairGenerationFailed
        }

        guard let signer = IREd25519Sha512Signer(privateKey: keypair.privateKey()) else {
            throw DemoFactoryError.signerCreationFailed
        }

        var account = WalletAccountSettings(accountId: accountId,
                                            assets: assets,
                                            signer: signer,
                                            publicKey: keypair.publicKey())
        account.withdrawOptions = createWithdrawOptions()

        let networkResolver = DemoNetworkResolver()

        let transactionTypes = [
            WalletTransactionType(backendName: "ALL", displayName: "All", typeIcon: nil),
            WalletTransactionType(backendName: "INCOMING", displayName: "Incoming", typeIcon: nil),
            WalletTransactionType(backendName: "OUTGOING", displayName: "Outgoing", typeIcon: nil)
        ]

        let walletBuilder =  CommonWalletBuilder
            .builder(with: account, networkResolver: networkResolver)
            .with(amountFormatter: NumberFormatter.amount)
            .with(transferAmountLimit: 1e+12)
            .with(transactionTypeList: transactionTypes)
            .with(commandDecoratorFactory: DialogCommandDecoratorFactory())

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

        walletBuilder.contactsModuleBuilder
            .with(searchPlaceholder: "Enter username")
            .with(contactsEmptyStateDataSource: DefaultEmptyStateDataSource.contacts)
            .with(searchEmptyStateDataSource: DefaultEmptyStateDataSource.search)
            .with(supportsLiveSearch: true)

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
        let soraAssetId = try IRAssetIdFactory.asset(withIdentifier: "sora#demo")
        let soraAsset = WalletAsset(identifier: soraAssetId,
                                    symbol: "ラ",
                                    details: "Sora economy")

        let d3AssetId = try IRAssetIdFactory.asset(withIdentifier: "d3#demo")
        let d3Asset = WalletAsset(identifier: d3AssetId,
                                  symbol: "元",
                                  details: "Digital identity")

        let vinceraAssetId = try IRAssetIdFactory.asset(withIdentifier: "vincera#demo")
        let vinceraAsset = WalletAsset(identifier: vinceraAssetId,
                                       symbol: "る",
                                       details: "Pay for vine")

        let moneaAssetId = try IRAssetIdFactory.asset(withIdentifier: "monea#demo")
        let moneaAsset = WalletAsset(identifier: moneaAssetId,
                                     symbol: "金",
                                     details: "Fast money transfer")

        return [soraAsset, d3Asset, vinceraAsset, moneaAsset]
    }

    func createWithdrawOptions() -> [WalletWithdrawOption] {
        let icon = UIImage(named: "iconEth")

        let etcTitle = "Send to my Ethereum Classic wallet"
        let etcDetails = "Ethereum Classic wallet address"
        let etcWithdrawOption = WalletWithdrawOption(identifier: UUID().uuidString,
                                                     symbol: "ETC",
                                                     title: etcTitle,
                                                     details: etcDetails,
                                                     icon: icon)

        let ethTitle = "Send to my Ethereum wallet"
        let ethDetails = "Ethereum wallet address"

        let ethWithdrawOption = WalletWithdrawOption(identifier: UUID().uuidString,
                                                     symbol: "ETH",
                                                     title: ethTitle,
                                                     details: ethDetails,
                                                     icon: icon)

        return [ethWithdrawOption, etcWithdrawOption]
    }
}

extension CommandDecoratorDemo: DemoHeaderViewModelDelegate {
    func didSelectClose(for viewModel: DemoHeaderViewModelProtocol) {
        completionBlock?()
    }
}
