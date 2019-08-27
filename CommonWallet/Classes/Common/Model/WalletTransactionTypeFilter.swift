import Foundation

struct WalletTransactionTypeFilter: Equatable {
    let backendName: String
    let displayName: String
}

extension WalletTransactionTypeFilter {
    static var all: WalletTransactionTypeFilter {
        return WalletTransactionTypeFilter(backendName: "ALL", displayName: "All")
    }
}

extension WalletTransactionTypeFilter {
    static func createAllFilters(from transactionTypes: [WalletTransactionType]) -> [WalletTransactionTypeFilter] {
        return transactionTypes.reduce(into: [WalletTransactionTypeFilter.all]) { (result, type) in
            let typeFilter = WalletTransactionTypeFilter(backendName: type.backendName,
                                                         displayName: type.displayName)
            return result.append(typeFilter)
        }
    }
}
