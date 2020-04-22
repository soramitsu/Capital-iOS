/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import CommonWallet
import SoraFoundation
import Cuckoo
import IrohaCrypto

func createRandomAccountId() throws -> String {
    let accountData = try createRandomData(with: 16)
    let accountName = (accountData as NSData).toHexString()
    return "\(accountName)@account"
}

func createRandomAssetId() throws -> String {
    let assetData = try createRandomData(with: 16)
    let assetName = (assetData as NSData).toHexString()
    return "\(assetName)#asset"
}

func createRandomWithdrawOption() -> WalletWithdrawOption {
    return WalletWithdrawOption(identifier: UUID().uuidString,
                                symbol: UUID().uuidString,
                                shortTitle: UUID().uuidString,
                                longTitle: UUID().uuidString,
                                details: UUID().uuidString,
                                icon: nil)
}

func createRandomAccountSettings(for assetsCount: Int, withdrawOptionsCount: Int = 0)
    throws -> WalletAccountSettings {
    let assets = try (0..<assetsCount).map { (index) -> WalletAsset in
        let assetId = try createRandomAssetId()
        return WalletAsset(identifier: assetId,
                           symbol: String(index + 1),
                           details: LocalizableResource { _ in UUID().uuidString },
                           precision: (0..<10).randomElement()!)
    }

    let withdrawOptions: [WalletWithdrawOption]

    if withdrawOptionsCount > 0 {
        withdrawOptions = (0..<withdrawOptionsCount).map { _ in createRandomWithdrawOption() }
    } else {
        withdrawOptions = []
    }

    return try createRandomAccountSettings(for: assets, withdrawOptions: withdrawOptions)
}

func createRandomAccountSettings(for assets: [WalletAsset], withdrawOptions: [WalletWithdrawOption]) throws -> WalletAccountSettings {
    let account = try createRandomAccountId()

    return WalletAccountSettings(accountId: account, assets: assets, withdrawOptions: withdrawOptions)
}

func createRandomOperationSettings() throws -> MiddlewareOperationSettings {
    let keypair = try IRIrohaKeyFactory().createRandomKeypair()
    let signer = IRIrohaSigner(privateKey: keypair.privateKey())

    return MiddlewareOperationSettings(signer: signer, publicKey: keypair.publicKey())
}
