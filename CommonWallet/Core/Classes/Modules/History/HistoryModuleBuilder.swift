/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI
import SoraFoundation

public protocol HistoryModuleBuilderProtocol: class {
    var itemCellIdentifier: String { get }

    @discardableResult
    func with<Cell>(cellClass: Cell.Type?,
                    for reuseIdentifier: String) -> Self where Cell: UITableViewCell & WalletViewProtocol

    @discardableResult
    func with(cellNib: UINib?, for reuseIdentifier: String) -> Self

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

    @discardableResult
    func with(includesFeeInAmount: Bool) -> Self

    @discardableResult
    func with(itemViewModelFactory: HistoryItemViewModelFactoryProtocol) -> Self

    @discardableResult
    func with(localizableTitle: LocalizableResource<String>) -> Self

    @discardableResult
    func with(viewFactoryOverriding: HistoryViewFactoryOverriding) -> Self

    @discardableResult
    func with(backgroundHeight: CGFloat?) -> Self
}

final class HistoryModuleBuilder: HistoryModuleBuilderProtocol {
    lazy var walletStyle: WalletStyleProtocol = WalletStyle()

    fileprivate var supportsFilter: Bool = true

    fileprivate var includesFeeInAmount: Bool = true

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

    fileprivate var registeredCellsMetadata = [String: Any]()

    fileprivate var itemViewModelFactory: HistoryItemViewModelFactoryProtocol?

    fileprivate var localizableTitle: LocalizableResource<String>?

    fileprivate var viewFactoryOverriding: HistoryViewFactoryOverriding?

    /*
     * We don't want to change height dynamically due to performance issue, so set max by default.
     * Pass nil to bind to superview.
     */
    fileprivate var backgroundHeight: CGFloat? = UIScreen.main.bounds.height

    init() {
        registerItemCell()
    }

    func build() -> HistoryConfigurationProtocol {
        return HistoryConfiguration(viewStyle: historyViewStyle,
                                    cellStyle: transactionCellStyle,
                                    headerStyle: transactionHeaderStyle,
                                    supportsFilter: supportsFilter,
                                    includesFeeInAmount: includesFeeInAmount,
                                    emptyStateDataSource: emptyStateDataSource,
                                    emptyStateDelegate: emptyStateDelegate,
                                    registeredCellsMetadata: registeredCellsMetadata,
                                    itemViewModelFactory: itemViewModelFactory,
                                    localizableTitle: localizableTitle,
                                    viewFactoryOverriding: viewFactoryOverriding,
                                    backgroundHeight: backgroundHeight)
    }

    fileprivate func registerItemCell() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: HistoryModuleConstants.historyCellNibName, bundle: bundle)

        registeredCellsMetadata[HistoryModuleConstants.historyCellIdentifier] = nib
    }
}

extension HistoryModuleBuilder {
    var itemCellIdentifier: String {
        HistoryModuleConstants.historyCellIdentifier
    }

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

    func with(includesFeeInAmount: Bool) -> Self {
        self.includesFeeInAmount = includesFeeInAmount
        return self
    }

    func with<Cell>(cellClass: Cell.Type?,
                    for reuseIdentifier: String) -> Self where Cell: UITableViewCell & WalletViewProtocol {
        registeredCellsMetadata[reuseIdentifier] = cellClass
        return self
    }

    func with(cellNib: UINib?, for reuseIdentifier: String) -> Self {
        registeredCellsMetadata[reuseIdentifier] = cellNib
        return self
    }

    func with(itemViewModelFactory: HistoryItemViewModelFactoryProtocol) -> Self {
        self.itemViewModelFactory = itemViewModelFactory
        return self
    }

    func with(localizableTitle: LocalizableResource<String>) -> Self {
        self.localizableTitle = localizableTitle
        return self
    }

    func with(viewFactoryOverriding: HistoryViewFactoryOverriding) -> Self {
        self.viewFactoryOverriding = viewFactoryOverriding
        return self
    }

    func with(backgroundHeight: CGFloat?) -> Self {
        self.backgroundHeight = backgroundHeight
        return self
    }
}
