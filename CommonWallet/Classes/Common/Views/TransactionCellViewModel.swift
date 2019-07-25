import Foundation

public protocol TransactionItemViewModelProtocol: class {
    var transactionId: String { get }
    var amount: String { get }
    var title: String { get }
    var incoming: Bool { get }
    var status: AssetTransactionStatus { get }
}

final class TransactionItemViewModel: TransactionItemViewModelProtocol {
    var transactionId: String
    var amount: String = ""
    var title: String = ""
    var incoming: Bool = false
    var status: AssetTransactionStatus = .commited
    
    init(transactionId: String) {
        self.transactionId = transactionId
    }
}

protocol TransactionSectionViewModelProtocol: class {
    var title: String { get }
    var items: [TransactionItemViewModelProtocol] { get }
}

final class TransactionSectionViewModel: TransactionSectionViewModelProtocol {
    var title: String
    var items: [TransactionItemViewModelProtocol]

    init(title: String, items: [TransactionItemViewModelProtocol]) {
        self.title = title
        self.items = items
    }
}
