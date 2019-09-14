/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

public protocol WalletAccountSettingsProtocol {
    var accountId: IRAccountId { get }
    var assets: [WalletAsset] { get }
    var withdrawOptions: [WalletWithdrawOption] { get }
    var signer: IRSignatureCreatorProtocol { get }
    var publicKey: IRPublicKeyProtocol { get }
    var transactionQuorum: UInt { get }
}

public struct WalletAccountSettings: WalletAccountSettingsProtocol {
    public var accountId: IRAccountId
    public var assets: [WalletAsset]
    public var signer: IRSignatureCreatorProtocol
    public var publicKey: IRPublicKeyProtocol

    public var withdrawOptions: [WalletWithdrawOption] = []
    public var transactionQuorum: UInt = 1

    public init(accountId: IRAccountId,
                assets: [WalletAsset],
                signer: IRSignatureCreatorProtocol,
                publicKey: IRPublicKeyProtocol) {
        self.accountId = accountId
        self.assets = assets
        self.signer = signer
        self.publicKey = publicKey
    }
}

extension WalletAccountSettingsProtocol {
    func asset(for identifier: String) -> WalletAsset? {
        return assets.first { $0.identifier.identifier() == identifier }
    }

    func withdrawOption(for identifier: String) -> WalletWithdrawOption? {
        return withdrawOptions.first { $0.identifier == identifier }
    }
}
