import Foundation

public protocol TransactionDetailsModuleBuilderProtocol: class {
    @discardableResult
    func with(sendBackTransactionTypes: [String]) -> Self
}
