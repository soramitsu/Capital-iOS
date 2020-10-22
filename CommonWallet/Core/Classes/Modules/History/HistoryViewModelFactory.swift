/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import SoraFoundation

protocol HistoryViewModelFactoryDelegate: class {
    func historyViewModelFactoryDidChange(_ factory: HistoryViewModelFactoryProtocol)
}

protocol HistoryViewModelFactoryProtocol {
    var delegate: HistoryViewModelFactoryDelegate? { get set }

    func merge(newItems: [AssetTransactionData],
               into existingViewModels: inout [TransactionSectionViewModel],
               locale: Locale) throws
        -> [SectionedListDifference<TransactionSectionViewModel, WalletViewModelProtocol>]
}

enum HistoryViewModelFactoryError: Error {
    case timestampFormattingFailed
}

final class HistoryViewModelFactory {
    let dateFormatterProvider: DateFormatterProviderProtocol
    let itemViewModelFactory: HistoryItemViewModelFactoryProtocol
    let commandFactory: WalletCommandFactoryProtocol

    weak var delegate: HistoryViewModelFactoryDelegate?

    init(dateFormatterProvider: DateFormatterProviderProtocol,
         itemViewModelFactory: HistoryItemViewModelFactoryProtocol,
         commandFactory: WalletCommandFactoryProtocol) {
        self.dateFormatterProvider = dateFormatterProvider
        self.itemViewModelFactory = itemViewModelFactory
        self.commandFactory = commandFactory

        dateFormatterProvider.delegate = self
    }
}

private typealias SearchableSection = (section: TransactionSectionViewModel, index: Int)

extension HistoryViewModelFactory: HistoryViewModelFactoryProtocol {
    func merge(newItems: [AssetTransactionData],
               into existingViewModels: inout [TransactionSectionViewModel],
               locale: Locale) throws
        -> [SectionedListDifference<TransactionSectionViewModel, WalletViewModelProtocol>] {

            var searchableSections = [String: SearchableSection]()
            for (index, section) in existingViewModels.enumerated() {
                searchableSections[section.title] = SearchableSection(section: section, index: index)
            }

            var changes = [SectionedListDifference<TransactionSectionViewModel, WalletViewModelProtocol>]()

            try newItems.forEach { (event) in
                let viewModel = try itemViewModelFactory.createItemFromData(event,
                                                                            commandFactory: commandFactory,
                                                                            locale: locale)

                let eventDate = Date(timeIntervalSince1970: TimeInterval(event.timestamp))
                let sectionTitle = dateFormatterProvider.dateFormatter.value(for: locale).string(from: eventDate)

                if let searchableSection = searchableSections[sectionTitle] {
                    let itemChange = ListDifference.insert(index: searchableSection.section.items.count, new: viewModel)
                    let sectionChange = SectionedListDifference.update(index: searchableSection.index,
                                                                       itemChange: itemChange,
                                                                       section: searchableSection.section)
                    changes.append(sectionChange)

                    searchableSection.section.items.append(viewModel)
                } else {
                    let newSection = TransactionSectionViewModel(title: sectionTitle,
                                                                 items: [viewModel])

                    let change: SectionedListDifference<TransactionSectionViewModel, WalletViewModelProtocol>
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
