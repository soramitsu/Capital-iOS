/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation
import CommonWallet

struct HistoryDemoHistoryModuleConstants {
    static let historyCellIdentifier = "historyDemoTransactionCellId"
    static let historyCellHeight: CGFloat = 55.0
}

class HistoryDemoTransactionItemViewModel: WalletViewModelProtocol {
    let cellReuseIdentifier: String
    let itemHeight: CGFloat
    let amount: String
    let title: String
    let incoming: Bool
    let status: AssetTransactionStatus
    let icon: UIImage?
    let command: WalletCommandProtocol?
    let purpose: String?
    let date: String?

    init(cellReuseIdentifier: String,
         itemHeight: CGFloat,
         amount: String,
         title: String,
         incoming: Bool,
         status: AssetTransactionStatus,
         icon: UIImage?,
         command: WalletCommandProtocol?,
         purpose: String? = nil,
         date: String? = nil) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.amount = amount
        self.title = title
        self.incoming = incoming
        self.status = status
        self.icon = icon
        self.command = command
        self.purpose = purpose
        self.date = date
    }
}

enum HistoryItemViewModelFactoryError: Error {
    case amountFormattingFailed
    case commandFactoryNil
}

class HistoryDemoItemViewModelFactory: HistoryItemViewModelFactoryProtocol {
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let includesFeeInAmount: Bool
    let transactionTypes: [WalletTransactionType]
    let assets: [WalletAsset]
    let localizableDateFormatter: LocalizableResource<DateFormatter>
    weak var commandFactory: WalletCommandFactoryProtocol?
    
    init(amountFormatterFactory: NumberFormatterFactoryProtocol,
         includesFeeInAmount: Bool,
         transactionTypes: [WalletTransactionType],
         assets: [WalletAsset],
         localizableDateFormatter: LocalizableResource<DateFormatter>) {
        self.amountFormatterFactory = amountFormatterFactory
        self.includesFeeInAmount = includesFeeInAmount
        self.transactionTypes = transactionTypes
        self.assets = assets
        self.localizableDateFormatter = localizableDateFormatter
    }

    func createItemFromData(_ data: AssetTransactionData,
                            locale: Locale) throws
        -> WalletViewModelProtocol {
        let amountValue = data.amount.decimalValue

        var totalAmountValue = amountValue

        let optionalTransactionType = transactionTypes.first { $0.backendName == data.type }

        if  includesFeeInAmount,
            let transactionType = optionalTransactionType,
            !transactionType.isIncome {

            let totalFee = data.fees.reduce(Decimal(0)) { result, item in
                if item.assetId == data.assetId {
                    return result + item.amount.decimalValue
                } else {
                    return result
                }
            }

            totalAmountValue += totalFee
        }

        let amountDisplayString: String

        if let asset = assets.first(where: { $0.identifier == data.assetId }) {
            let amountFormatter = amountFormatterFactory.createTokenFormatter(for: asset)

            guard let displayString = amountFormatter.value(for: locale)
                .string(from: totalAmountValue) else {
                throw HistoryItemViewModelFactoryError.amountFormattingFailed
            }

            amountDisplayString = displayString
        } else {
            amountDisplayString = AmountDecimal(value: totalAmountValue).stringValue
        }

        let title: String

        if data.peerFirstName != nil || data.peerLastName != nil {
            let firstName = data.peerFirstName ?? ""
            let lastName = data.peerLastName ?? ""

            title = L10n.Common.fullName(firstName, lastName)
        } else {
            title = data.peerName ?? ""
        }

        let incoming: Bool
        let icon: UIImage?

        if let transactionType = optionalTransactionType {
            incoming = transactionType.isIncome
            icon = transactionType.typeIcon
        } else {
            incoming = false
            icon = nil
        }

        guard let command = commandFactory?.prepareTransactionDetailsCommand(with: data) else {
            throw(HistoryItemViewModelFactoryError.commandFactoryNil)
        }
        let eventDate = Date(timeIntervalSince1970: TimeInterval(data.timestamp))
        let dateString = localizableDateFormatter.value(for: locale).string(from: eventDate)

        let viewModel = HistoryDemoTransactionItemViewModel(cellReuseIdentifier: HistoryDemoHistoryModuleConstants.historyCellIdentifier,
                                                 itemHeight: HistoryDemoHistoryModuleConstants.historyCellHeight,
                                                 amount: amountDisplayString,
                                                 title: title,
                                                 incoming: incoming,
                                                 status: data.status,
                                                 icon: icon,
                                                 command: command,
                                                 purpose: data.details,
                                                 date: dateString)

        return viewModel
    }
}
