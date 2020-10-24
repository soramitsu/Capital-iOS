/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol HistoryItemViewModelFactoryProtocol {
    func createItemFromData(_ data: AssetTransactionData,
                            commandFactory: WalletCommandFactoryProtocol,
                            locale: Locale) throws -> WalletViewModelProtocol
}

enum HistoryItemViewModelFactoryError: Error {
    case amountFormattingFailed
}

struct HistoryItemViewModelFactory: HistoryItemViewModelFactoryProtocol {
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let includesFeeInAmount: Bool
    let transactionTypes: [WalletTransactionType]
    let assets: [WalletAsset]

    func createItemFromData(_ data: AssetTransactionData,
                            commandFactory: WalletCommandFactoryProtocol,
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

        let command = commandFactory.prepareTransactionDetailsCommand(with: data)

        let viewModel = TransactionItemViewModel(cellReuseIdentifier: HistoryModuleConstants.historyCellIdentifier,
                                                 itemHeight: HistoryModuleConstants.historyCellHeight,
                                                 amount: amountDisplayString,
                                                 title: title,
                                                 incoming: incoming,
                                                 status: data.status,
                                                 icon: icon,
                                                 command: command)

        return viewModel
    }
}
