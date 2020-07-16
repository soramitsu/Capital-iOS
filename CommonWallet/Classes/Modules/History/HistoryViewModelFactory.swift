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
        -> [SectionedListDifference<TransactionSectionViewModel, TransactionItemViewModel>]
}

enum HistoryViewModelFactoryError: Error {
    case amountFormattingFailed
    case timestampFormattingFailed
}

final class HistoryViewModelFactory {
    private(set) var dateFormatterProvider: DateFormatterProviderProtocol
    private(set) var amountFormatterFactory: NumberFormatterFactoryProtocol
    private(set) var assets: [String: WalletAsset]
    private(set) var transactionTypes: [String: WalletTransactionType]
    private(set) var includesFeeInAmount: Bool
    private lazy var dateFormatter: DateFormatter = {
        let item = DateFormatter()
        item.dateStyle = .long
        return item
    }()

    weak var delegate: HistoryViewModelFactoryDelegate?

    init(dateFormatterProvider: DateFormatterProviderProtocol,
         amountFormatterFactory: NumberFormatterFactoryProtocol,
         assets: [WalletAsset],
         transactionTypes: [WalletTransactionType],
         includesFeeInAmount: Bool) {
        self.dateFormatterProvider = dateFormatterProvider
        self.amountFormatterFactory = amountFormatterFactory
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

    private func createViewModel(from transaction: AssetTransactionData,
                                 locale: Locale) throws -> TransactionItemViewModel {
        let viewModel = TransactionItemViewModel(transactionId: transaction.transactionId)

        let amountValue = transaction.amount.decimalValue

        var totalAmountValue = amountValue

        if  includesFeeInAmount,
            let transactionType = transactionTypes[transaction.type],
            !transactionType.isIncome,
            let feeValue = transaction.fee?.decimalValue {

            totalAmountValue += feeValue
        }

        let amountDisplayString: String

        if let asset = assets[transaction.assetId] {
            let amountFormatter = amountFormatterFactory.createDisplayFormatter(for: asset)

            guard let displayString = amountFormatter.value(for: locale)
                .string(from: (totalAmountValue as NSNumber)) else {
                throw HistoryViewModelFactoryError.amountFormattingFailed
            }

            amountDisplayString = displayString
        } else {
            amountDisplayString = AmountDecimal(value: totalAmountValue).stringValue
        }

        if transaction.peerFirstName != nil || transaction.peerLastName != nil {
            let firstName = transaction.peerFirstName ?? ""
            let lastName = transaction.peerLastName ?? ""
            
            viewModel.title = L10n.Common.fullName(firstName, lastName)
        } else {
            viewModel.title = transaction.peerName ?? ""
        }

        viewModel.status = transaction.status

        if let transactionType = transactionTypes[transaction.type] {
            viewModel.incoming = transactionType.isIncome
            viewModel.icon = transactionType.typeIcon
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
    private func sectionTtitle(for date: Date, locale: Locale) -> String {
        let calendar = Calendar.current
        if calendar.isDateInToday(date) {
            return L10n.Common.today
        }
        if calendar.isDateInYesterday(date) {
            return L10n.Common.yesterday
        }
        dateFormatter.locale = locale
        return dateFormatter.string(from: date)
    }
    
    func merge(newItems: [AssetTransactionData],
               into existingViewModels: inout [TransactionSectionViewModel],
               locale: Locale) throws
        -> [SectionedListDifference<TransactionSectionViewModel, TransactionItemViewModel>] {

            var searchableSections = [String: SearchableSection]()
            for (index, section) in existingViewModels.enumerated() {
                searchableSections[section.title] = SearchableSection(section: section, index: index)
            }

            var changes = [SectionedListDifference<TransactionSectionViewModel, TransactionItemViewModel>]()

            try newItems.forEach { (event) in
                let viewModel = try self.createViewModel(from: event, locale: locale)

                let eventDate = Date(timeIntervalSince1970: TimeInterval(event.timestamp))
                let sectionTitle = sectionTtitle(for: eventDate, locale: locale)

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
