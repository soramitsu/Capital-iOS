/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import CommonWallet
import SoraFoundation
import IrohaCrypto

final class LocalizedDemo: DemoFactoryProtocol {
    var title: String {
        return "Localized"
    }

    var completionBlock: DemoCompletionBlock?

    private func createWallet(for language: WalletLanguage) throws -> UIViewController {
        let accountId = "julio@demo"
        let assets = try createAssets()

        let keypair = try IRIrohaKeyFactory().createRandomKeypair()

        let signer = IRIrohaSigner(privateKey: keypair.privateKey())

        let account = WalletAccountSettings(accountId: accountId,
                                            assets: assets,
                                            withdrawOptions: createWithdrawOptions())

        let networkResolver = DemoNetworkResolver()

        let withdrawType = WalletTransactionType(backendName: "WITHDRAW",
                                                 displayName: LocalizableResource { _ in "Withdraw" },
                                                 isIncome: false,
                                                 typeIcon: nil)

        let operationSettings = MiddlewareOperationSettings(signer: signer, publicKey: keypair.publicKey())

        let networkFactory = MiddlewareOperationFactory(accountSettings: account,
                                                        operationSettings: operationSettings,
                                                        networkResolver: networkResolver)

        let walletBuilder =  CommonWalletBuilder
            .builder(with: account, networkOperationFactory: networkFactory)
            .with(transactionTypeList: [withdrawType])
            .with(language: language)
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
            .with(supportsLiveSearch: true)

        walletBuilder.transactionDetailsModuleBuilder.with(sendBackTransactionTypes: ["INCOMING"])

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

        let rootController = try walletContext.createRootController()

        return rootController
    }

    func setupDemo(with completionBlock: @escaping DemoCompletionBlock) throws -> UIViewController {
        self.completionBlock = completionBlock

        let alertController = UIAlertController(title: "Select language",
                                                message: nil,
                                                preferredStyle: .actionSheet)

        WalletLanguage.allCases.forEach { language in
            let title = Locale.current.localizedString(forLanguageCode: language.rawValue)
            let action = UIAlertAction(title: title, style: .default) { _ in
                if let walletController = try? self.createWallet(for: language) {
                    self.completionBlock?(walletController)
                }
            }

            alertController.addAction(action)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.completionBlock?(nil)
        }

        alertController.addAction(cancelAction)

        return alertController
    }

    func createAssets() throws -> [WalletAsset] {
        let soraAssetId = "sora#demo"
        let soraAsset = WalletAsset(identifier: soraAssetId,
                                    name: LocalizableResource { _ in "XOR" },
                                    platform: LocalizableResource { _ in "Sora economy" },
                                    symbol: "ラ",
                                    precision: 2)

        let d3AssetId = "d3#demo"
        let d3Asset = WalletAsset(identifier: d3AssetId,
                                  name: LocalizableResource { _ in "D3" },
                                  platform: LocalizableResource { _ in "Digital identity" },
                                  symbol: "元",
                                  precision: 2)

        let vinceraAssetId = "vincera#demo"
        let vinceraAsset = WalletAsset(identifier: vinceraAssetId,
                                       name: LocalizableResource { _ in "PFV" },
                                       platform: LocalizableResource { _ in "Pay for vine" },
                                       symbol: "る",
                                       precision: 2)

        let moneaAssetId = "monea#demo"
        let moneaAsset = WalletAsset(identifier: moneaAssetId,
                                     name: LocalizableResource { _ in "FMT" },
                                     platform: LocalizableResource { _ in "Fast money transfer" },
                                     symbol: "金",
                                     precision: 2)

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

extension LocalizedDemo: DemoHeaderViewModelDelegate {
    func didSelectClose(for viewModel: DemoHeaderViewModelProtocol) {
        completionBlock?(nil)
    }
}
