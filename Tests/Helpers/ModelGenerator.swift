import Foundation
@testable import CommonWallet
import IrohaCommunication

enum BytesGeneratorError: Error {
    case bytesGenerationFailed
}

func createRandomData(with bytesCount: Int) throws -> Data {
    var data = Data(count: bytesCount)
    let result = data.withUnsafeMutableBytes { (mutableBytes: UnsafeMutablePointer<UInt8>) -> Int32 in
        SecRandomCopyBytes(kSecRandomDefault, bytesCount, mutableBytes)
    }

    if result != errSecSuccess {
        throw BytesGeneratorError.bytesGenerationFailed
    }

    return data
}

func createRandomTransactionHash() throws -> Data {
    return try createRandomData(with: 32)
}

func createRandomTransferInfo() throws -> TransferInfo {
    let source = try IRAccountIdFactory.account(withIdentifier: try createRandomAccountId())
    let destination = try IRAccountIdFactory.account(withIdentifier: try createRandomAccountId())
    let amount = try IRAmountFactory.amount(fromUnsignedInteger: UInt.random(in: 1...1000))
    let asset = try IRAssetIdFactory.asset(withIdentifier: createRandomAssetId())
    let details = UUID().uuidString

    return TransferInfo(source: source,
                        destination: destination,
                        amount: amount,
                        asset: asset,
                        details: details)
}

func createRandomReceiveInfo() throws -> ReceiveInfo {
    let accountId = try IRAccountIdFactory.account(withIdentifier: try createRandomAccountId())
    let amount = try IRAmountFactory.amount(fromUnsignedInteger: UInt.random(in: 1...1000))
    let assetId = try IRAssetIdFactory.asset(withIdentifier: createRandomAssetId())
    let details = UUID().uuidString

    return ReceiveInfo(accountId: accountId,
                       assetId: assetId,
                       amount: amount,
                       details: details)
}

func createRandomAssetTransactionData() throws -> AssetTransactionData {
    let transactionId = try createRandomTransactionHash()
    let status: AssetTransactionStatus = [.commited, .pending, .rejected].randomElement()!
    let assetId = try createRandomAssetId()
    let amount = UInt.random(in: 0...1000)
    let reason: String? = status == .rejected ? UUID().uuidString : nil
    return AssetTransactionData(transactionId: (transactionId as NSData).toHexString(),
                                status: status,
                                assetId: assetId,
                                peerId: UUID().uuidString,
                                peerName: UUID().uuidString,
                                details: UUID().uuidString,
                                amount: NSNumber(value: amount).stringValue,
                                timestamp: Int64(Date().timeIntervalSince1970),
                                incoming: [true, false].randomElement()!,
                                reason: reason)
}

func createRandomTransactionType() -> WalletTransactionType {
    return WalletTransactionType(backendName: UUID().uuidString,
                                 displayName: UUID().uuidString,
                                 typeIcon: nil)
}
