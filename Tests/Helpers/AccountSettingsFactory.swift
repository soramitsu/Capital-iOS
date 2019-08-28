/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import CommonWallet
import IrohaCommunication
import Cuckoo

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
        let assetId = try IRAssetIdFactory.asset(withIdentifier: createRandomAssetId())
        return WalletAsset(identifier: assetId,
                           symbol: String(index + 1),
                           details: UUID().uuidString)
    }

    let withdrawOptions: [WalletWithdrawOption]

    if withdrawOptionsCount > 0 {
        withdrawOptions = (0..<withdrawOptionsCount).map { _ in createRandomWithdrawOption() }
    } else {
        withdrawOptions = []
    }

    return try createRandomAccountSettings(for: assets, withdrawOptions: withdrawOptions)
}

func createRandomAccountSettings(for assets: [WalletAsset], withdrawOptions: [WalletWithdrawOption])
    throws -> WalletAccountSettings {
    let account = try IRAccountIdFactory.account(withIdentifier: createRandomAccountId())

    let keypair = IREd25519KeyFactory().createRandomKeypair()!

    let signer = IREd25519Sha512Signer(privateKey: keypair.privateKey())!

    var settings = WalletAccountSettings(accountId: account,
                                         assets: assets,
                                         signer: signer,
                                         publicKey: keypair.publicKey())
    settings.withdrawOptions = withdrawOptions

    return settings
}
