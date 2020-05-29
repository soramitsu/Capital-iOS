/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
@testable import CommonWallet
import SoraFoundation

enum BytesGeneratorError: Error {
    case bytesGenerationFailed
}

func createRandomData(with bytesCount: Int) throws -> Data {
    var data = Data(count: bytesCount)

    let result = data.withUnsafeMutableBytes { (mutableBytes: UnsafeMutableRawBufferPointer) -> Int32 in
        guard let address = mutableBytes.baseAddress else {
            return errSecParam
        }

        return SecRandomCopyBytes(kSecRandomDefault, bytesCount, address)
    }

    if result != errSecSuccess {
        throw BytesGeneratorError.bytesGenerationFailed
    }

    return data
}

func createRandomTransactionHash() throws -> Data {
    return try createRandomData(with: 32)
}

func createRandomTransferInfo(for accountId: String? = nil) throws -> TransferInfo {
    let source: String

    if let accountId = accountId {
        source = accountId
    } else {
        source = try createRandomAccountId()
    }

    let destination = try createRandomAccountId()
    let amount = AmountDecimal(value: Decimal(UInt.random(in: 1...1000)))
    let asset = try createRandomAssetId()
    let details = UUID().uuidString

    let fees: [Fee]
    let shouldIncludeFee = [false, true].randomElement()!

    if shouldIncludeFee {
        let fee = AmountDecimal(value: Decimal(UInt.random(in: 1...10000)))
        let feeAccount = try createRandomAccountId()

        let feeDescription = FeeDescription(identifier: UUID().uuidString,
                                            assetId: asset,
                                            type: FeeType.fixed.rawValue,
                                            parameters: [fee],
                                            accountId: feeAccount)

        fees = [Fee(value: fee, feeDescription: feeDescription)]
    } else {
        fees = []
    }

    return TransferInfo(source: source,
                        destination: destination,
                        amount: amount,
                        asset: asset,
                        details: details,
                        fees: fees)
}

func createRandomWithdrawInfo() throws -> WithdrawInfo {
    let destinationAccount = try createRandomAccountId()
    let amount = AmountDecimal(value: Decimal(UInt.random(in: 1...1000)))
    let asset = try createRandomAssetId()
    let details = UUID().uuidString

    let fees: [Fee]
    let shouldIncludeFee = [false, true].randomElement()!

    if shouldIncludeFee {
        let fee = AmountDecimal(value: Decimal(UInt.random(in: 1...10000)))
        let feeAccount = try createRandomAccountId()

        let feeDescription = FeeDescription(identifier: UUID().uuidString,
                                            assetId: asset,
                                            type: FeeType.fixed.rawValue,
                                            parameters: [fee],
                                            accountId: feeAccount)

        fees = [Fee(value: fee, feeDescription: feeDescription)]
    } else {
        fees = []
    }

    return WithdrawInfo(destinationAccountId: destinationAccount,
                        assetId: asset,
                        amount: amount,
                        details: details,
                        fees: fees)
}

func createRandomReceiveInfo() throws -> ReceiveInfo {
    let accountId = try createRandomAccountId()
    let amount = AmountDecimal(value: Decimal(UInt.random(in: 1...1000)))
    let assetId = try createRandomAssetId()
    let details = UUID().uuidString

    return ReceiveInfo(accountId: accountId,
                       assetId: assetId,
                       amount: amount,
                       details: details)
}

func createRandomAssetTransactionData(includeFee: Bool = true) throws -> AssetTransactionData {
    let transactionId = try createRandomTransactionHash()
    let status: AssetTransactionStatus = [.commited, .pending, .rejected].randomElement()!
    let assetId = try createRandomAssetId()
    let amount = AmountDecimal(value: Decimal(UInt.random(in: 0...1000)))
    let fee: AmountDecimal? = includeFee ? AmountDecimal(value: Decimal(UInt.random(in: 0...1000))) : nil
    let reason: String? = status == .rejected ? UUID().uuidString : nil
    return AssetTransactionData(transactionId: (transactionId as NSData).toHexString(),
                                status: status,
                                assetId: assetId,
                                peerId: UUID().uuidString,
                                peerFirstName: nil,
                                peerLastName: nil,
                                peerName: UUID().uuidString,
                                details: UUID().uuidString,
                                amount: amount,
                                fee: fee,
                                timestamp: Int64(Date().timeIntervalSince1970),
                                type: WalletTransactionType.required.randomElement()!.backendName,
                                reason: reason)
}

func createRandomTransactionType() -> WalletTransactionType {
    return WalletTransactionType(backendName: UUID().uuidString,
                                 displayName: LocalizableResource { _ in UUID().uuidString },
                                 isIncome: [false, true].randomElement()!,
                                 typeIcon: nil)
}

func createRandomWithdrawMetadataInfo() throws -> WithdrawMetadataInfo {
    let assetId = try createRandomAssetId()
    let option = UUID().uuidString

    return WithdrawMetadataInfo(assetId: assetId, option: option)
}

func createRandomTransferMetadataInfo() throws -> TransferMetadataInfo {
    let assetId = try createRandomAssetId()
    let sender = try createRandomAccountId()
    let receiver = try createRandomAccountId()

    return TransferMetadataInfo(assetId: assetId,
                                sender: sender,
                                receiver: receiver)
}
