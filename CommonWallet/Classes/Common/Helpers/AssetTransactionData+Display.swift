import Foundation

extension AssetTransactionData {
    var displayIdentifier: String {
        return String(transactionId.prefix(8))
    }
}
