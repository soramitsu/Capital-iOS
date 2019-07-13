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

func createRandomAccountSettings(for assetsCount: Int) throws -> WalletAccountSettings {
    let assets = try (0..<assetsCount).map { (index) -> WalletAsset in
        let assetId = try IRAssetIdFactory.asset(withIdentifier: createRandomAssetId())
        return WalletAsset(identifier: assetId,
                           symbol: String(index + 1),
                           details: UUID().uuidString)
    }

    return try createRandomAccountSettings(for: assets)
}

func createRandomAccountSettings(for assets: [WalletAssetProtocol]) throws -> WalletAccountSettings {
    let account = try IRAccountIdFactory.account(withIdentifier: createRandomAccountId())

    let keypair = IREd25519KeyFactory().createRandomKeypair()!

    let signer = IREd25519Sha512Signer(privateKey: keypair.privateKey())!

    return WalletAccountSettings(accountId: account,
                                 assets: assets,
                                 signer: signer,
                                 publicKey: keypair.publicKey())
}
