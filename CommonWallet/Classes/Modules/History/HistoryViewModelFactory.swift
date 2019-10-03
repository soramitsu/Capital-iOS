/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

protocol HistoryViewModelFactoryDelegate: class {
    func historyViewModelFactoryDidChange(_ factory: HistoryViewModelFactoryProtocol)
}

protocol HistoryViewModelFactoryProtocol {
    var delegate: HistoryViewModelFactoryDelegate? { get set }

    func merge(newItems: [AssetTransactionData],
               into existingViewModels: inout [TransactionSectionViewModel]) throws
        -> [SectionedListDifference<TransactionSectionViewModel, TransactionItemViewModel>]
}

enum HistoryViewModelFactoryError: Error {
    case invalidEventAmount
    case amountFormattingFailed
    case timestampFormattingFailed
}

final class HistoryViewModelFactory {
    private(set) var dateFormatterProvider: DateFormatterProviderProtocol
    private(set) var amountFormatter: NumberFormatter
    private(set) var assets: [String: WalletAsset]
    private(set) var transactionTypes: [String: WalletTransactionType]
    private(set) var includesFeeInAmount: Bool

    weak var delegate: HistoryViewModelFactoryDelegate?

    init(dateFormatterProvider: DateFormatterProviderProtocol,
         amountFormatter: NumberFormatter,
         assets: [WalletAsset],
         transactionTypes: [WalletTransactionType],
         includesFeeInAmount: Bool) {
        self.dateFormatterProvider = dateFormatterProvider
        self.amountFormatter = amountFormatter
        self.includesFeeInAmount = includesFeeInAmount

        self.assets = assets.reduce(into: [String: WalletAsset]()) { (result, asset) in
            let key = asset.identifier.identifier()
            result[key] = asset
        }

        self.transactionTypes = transactionTypes.reduce(into: [String: WalletTransactionType]()) { (result, type) in
            result[type.backendName] = type
        }

        dateFormatterProvider.delegate = self
    }

    private func createViewModel(from transaction: AssetTransactionData) throws -> TransactionItemViewModel {
        let viewModel = TransactionItemViewModel(transactionId: transaction.transactionId)

        guard let amountValue = Decimal(string: transaction.amount) else {
            throw HistoryViewModelFactoryError.invalidEventAmount
        }

        var totalAmountValue = amountValue

        if  includesFeeInAmount,
            let transactionType = transactionTypes[transaction.type],
            !transactionType.isIncome,
            let feeString = transaction.fee,
            let feeValue = Decimal(string: feeString) {

            totalAmountValue += feeValue
        }

        guard let amountDisplayString = amountFormatter.string(from: (totalAmountValue as NSNumber)) else {
            throw HistoryViewModelFactoryError.amountFormattingFailed
        }

        viewModel.title = transaction.peerName
        viewModel.status = transaction.status

        if let transactionType = transactionTypes[transaction.type] {
            viewModel.incoming = transactionType.isIncome
        }

        if let asset = assets[transaction.assetId] {
            viewModel.amount = asset.symbol + amountDisplayString
        } else {
            viewModel.amount = amountDisplayString
        }

        return viewModel
    }
}

private typealias SearchableSection = (section: TransactionSectionViewModel, index: Int)

extension HistoryViewModelFactory: HistoryViewModelFactoryProtocol {
    func merge(newItems: [AssetTransactionData],
               into existingViewModels: inout [TransactionSectionViewModel]) throws
        -> [SectionedListDifference<TransactionSectionViewModel, TransactionItemViewModel>] {

            var searchableSections = [String: SearchableSection]()
            for (index, section) in existingViewModels.enumerated() {
                searchableSections[section.title] = SearchableSection(section: section, index: index)
            }

            var changes = [SectionedListDifference<TransactionSectionViewModel, TransactionItemViewModel>]()

            try newItems.forEach { (event) in
                let viewModel = try self.createViewModel(from: event)

                let eventDate = Date(timeIntervalSince1970: TimeInterval(event.timestamp))
                let sectionTitle = dateFormatterProvider.dateFormatter.string(from: eventDate)

                if let searchableSection = searchableSections[sectionTitle] {
                    let itemChange = ListDifference.insert(index: searchableSection.section.items.count, new: viewModel)
                    let sectionChange = SectionedListDifference.update(index: searchableSection.index,
                                                                       itemChange: itemChange,
                                                                       newSection: searchableSection.section)
                    changes.append(sectionChange)

                    searchableSection.section.items.append(viewModel)
                } else {
                    let newSection = TransactionSectionViewModel(title: sectionTitle,
                                                                 items: [viewModel])

                    let change: SectionedListDifference<TransactionSectionViewModel, TransactionItemViewModel>
                        = .insert(index: searchableSections.count, newSection: newSection)

                    changes.append(change)

                    let searchableSection = SearchableSection(section: newSection, index: existingViewModels.count)
                    searchableSections[newSection.title] = searchableSection

                    existingViewModels.append(newSection)
                }
            }

            return changes
    }
}

extension HistoryViewModelFactory: DateFormatterProviderDelegate {
    func providerDidChangeDateFormatter(_ provider: DateFormatterProviderProtocol) {
        delegate?.historyViewModelFactoryDidChange(self)
    }
}
