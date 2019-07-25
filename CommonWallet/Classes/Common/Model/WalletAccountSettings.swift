/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

public protocol WalletAccountSettingsProtocol {
    var accountId: IRAccountId { get }
    var assets: [WalletAsset] { get }
    var signer: IRSignatureCreatorProtocol { get }
    var publicKey: IRPublicKeyProtocol { get }
    var transactionQuorum: UInt { get }
}

public struct WalletAccountSettings: WalletAccountSettingsProtocol {
    public let accountId: IRAccountId
    public let assets: [WalletAsset]
    public let signer: IRSignatureCreatorProtocol
    public let publicKey: IRPublicKeyProtocol
    public let transactionQuorum: UInt

    public init(accountId: IRAccountId,
                assets: [WalletAsset],
                signer: IRSignatureCreatorProtocol,
                publicKey: IRPublicKeyProtocol,
                transactionQuorum: UInt = 1) {
        self.accountId = accountId
        self.assets = assets
        self.signer = signer
        self.publicKey = publicKey
        self.transactionQuorum = transactionQuorum
    }
}

extension WalletAccountSettingsProtocol {
    func asset(for identifier: String) -> WalletAsset? {
        return assets.first { $0.identifier.identifier() == identifier }
    }
}
