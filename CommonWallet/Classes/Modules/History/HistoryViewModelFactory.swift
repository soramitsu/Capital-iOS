/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

protocol HistoryViewModelFactoryProtocol {
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
    private(set) var dateFormatter: DateFormatter
    private(set) var amountFormatter: NumberFormatter
    private(set) var assets: [String: WalletAssetProtocol]

    init(dateFormatter: DateFormatter, amountFormatter: NumberFormatter, assets: [WalletAssetProtocol]) {
        self.dateFormatter = dateFormatter
        self.amountFormatter = amountFormatter

        self.assets = assets.reduce(into: [String: WalletAssetProtocol]()) { (result, asset) in
            let key = asset.identifier.identifier()
            result[key] = asset
        }
    }

    private func createViewModel(from transaction: AssetTransactionData) throws -> TransactionItemViewModel {
        let viewModel = TransactionItemViewModel(transactionId: transaction.transactionId)

        guard let amountValue = Decimal(string: transaction.amount) else {
            throw HistoryViewModelFactoryError.invalidEventAmount
        }

        guard let amountDisplayString = amountFormatter.string(from: (abs(amountValue) as NSNumber)) else {
            throw HistoryViewModelFactoryError.amountFormattingFailed
        }

        viewModel.title = transaction.peerName
        viewModel.incoming = transaction.incoming
        viewModel.status = transaction.status

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
                let sectionTitle = dateFormatter.string(from: eventDate)

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
