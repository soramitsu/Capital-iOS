import Foundation

protocol TransactionDetailsConfigurationProtocol {
    var sendBackTransactionTypes: [String] { get }
}


struct TransactionDetailsConfiguration: TransactionDetailsConfigurationProtocol {
    var sendBackTransactionTypes: [String]
}
