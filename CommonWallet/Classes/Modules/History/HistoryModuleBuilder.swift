import Foundation
import SoraUI

public protocol HistoryModuleBuilderProtocol: class {
    @discardableResult
    func with(historyViewStyle: HistoryViewStyleProtocol) -> Self

    @discardableResult
    func with(transactionCellStyle: TransactionCellStyleProtocol) -> Self

    @discardableResult
    func with(transactionHeaderStyle: TransactionHeaderStyleProtocol) -> Self

    @discardableResult
    func with(emptyStateDataSource: EmptyStateDataSource) -> Self

    @discardableResult
    func with(emptyStateDelegate: EmptyStateDelegate) -> Self

    @discardableResult
    func with(supportsFilter: Bool) -> Self
}

final class HistoryModuleBuilder: HistoryModuleBuilderProtocol {
    lazy var walletStyle: WalletStyleProtocol = WalletStyle()

    fileprivate var supportsFilter: Bool = true

    fileprivate weak var emptyStateDelegate: EmptyStateDelegate?
    fileprivate var emptyStateDataSource: EmptyStateDataSource?

    fileprivate lazy var historyViewStyle: HistoryViewStyleProtocol = {
        return HistoryViewStyle.createDefaultStyle(with: walletStyle)
    }()

    fileprivate lazy var transactionCellStyle: TransactionCellStyleProtocol = {
        return TransactionCellStyle.createDefaultStyle(with: walletStyle)
    }()

    fileprivate lazy var transactionHeaderStyle: TransactionHeaderStyleProtocol = {
        return TransactionHeaderStyle.createDefaultStyle(with: walletStyle)
    }()

    func build() -> HistoryConfigurationProtocol {
        return HistoryConfiguration(viewStyle: historyViewStyle,
                                    cellStyle: transactionCellStyle,
                                    headerStyle: transactionHeaderStyle,
                                    supportsFilter: supportsFilter,
                                    emptyStateDataSource: emptyStateDataSource,
                                    emptyStateDelegate: emptyStateDelegate)
    }
}

extension HistoryModuleBuilder {
    func with(historyViewStyle: HistoryViewStyleProtocol) -> Self {
        self.historyViewStyle = historyViewStyle
        return self
    }

    func with(transactionCellStyle: TransactionCellStyleProtocol) -> Self {
        self.transactionCellStyle = transactionCellStyle
        return self
    }

    func with(transactionHeaderStyle: TransactionHeaderStyleProtocol) -> Self {
        self.transactionHeaderStyle = transactionHeaderStyle
        return self
    }

    func with(emptyStateDataSource: EmptyStateDataSource) -> Self {
        self.emptyStateDataSource = emptyStateDataSource
        return self
    }

    func with(emptyStateDelegate: EmptyStateDelegate) -> Self {
        self.emptyStateDelegate = emptyStateDelegate
        return self
    }

    func with(supportsFilter: Bool) -> Self {
        self.supportsFilter = supportsFilter
        return self
    }
}
