/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import IrohaCrypto

public protocol MiddlewareOperationSettingsProtocol {
    var signer: IRSignatureCreatorProtocol { get }
    var publicKey: IRPublicKeyProtocol { get }
    var transactionQuorum: UInt { get }
}

public struct MiddlewareOperationSettings: MiddlewareOperationSettingsProtocol {
    public let signer: IRSignatureCreatorProtocol
    public let publicKey: IRPublicKeyProtocol
    public let transactionQuorum: UInt

    public init(signer: IRSignatureCreatorProtocol, publicKey: IRPublicKeyProtocol, transactionQuorum: UInt = 1) {
        self.signer = signer
        self.publicKey = publicKey
        self.transactionQuorum = transactionQuorum
    }
}
