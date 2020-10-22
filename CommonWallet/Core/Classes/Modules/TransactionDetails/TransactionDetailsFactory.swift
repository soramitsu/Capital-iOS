/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

protocol WalletTransactionDetailsFactoryProtocol {
    func createViewModelsFromTransaction(data: AssetTransactionData,
                                         commandFactory: WalletCommandFactoryProtocol,
                                         locale: Locale) -> [WalletFormViewBindingProtocol]

    func createAccessoryViewModelFromTransaction(data: AssetTransactionData,
                                                 commandFactory: WalletCommandFactoryProtocol,
                                                 locale: Locale) -> AccessoryViewModelProtocol?
}

struct WalletTransactionDetailsFactory {
    let transactionTypes: [WalletTransactionType]
    let assets: [WalletAsset]
    let feeDisplayFactory: FeeDisplaySettingsFactoryProtocol
    let generatingIconStyle: WalletNameIconStyleProtocol
    let amountFormatterFactory: NumberFormatterFactoryProtocol
    let localizableDataFormatter: LocalizableResource<DateFormatter>
    let sendBackTypes: [String]
    let sendAgainTypes: [String]

    private func populateTransactionId(into viewModelList: inout [WalletFormViewBindingProtocol],
                                       data: AssetTransactionData) {
        let headerViewModel = WalletFormDetailsHeaderModel(title: L10n.Transaction.id)
        viewModelList.append(headerViewModel)

        let viewModel = MultilineTitleIconViewModel(text: data.transactionId)
        let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
        viewModelList.append(separator)
    }

    private func populateStatus(into viewModelList: inout [WalletFormViewBindingProtocol],
                                data: AssetTransactionData) {
        let viewModel: WalletNewFormDetailsViewModel
        switch data.status {
        case .commited:
            viewModel = WalletNewFormDetailsViewModel(title: L10n.Status.title,
                                                      titleIcon: nil,
                                                      details: L10n.Status.success,
                                                      detailsIcon: nil)
        case .pending:
            viewModel = WalletNewFormDetailsViewModel(title: L10n.Status.title,
                                                      titleIcon: nil,
                                                      details: L10n.Status.pending,
                                                      detailsIcon: nil)
        case .rejected:
            viewModel = WalletNewFormDetailsViewModel(title: L10n.Status.title,
                                                      titleIcon: nil,
                                                      details: L10n.Status.rejected,
                                                      detailsIcon: nil)
        }

        let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
        viewModelList.append(separator)
    }

    private func populateRejected(into viewModelList: inout [WalletFormViewBindingProtocol],
                                  data: AssetTransactionData) {
        if data.status == .rejected, let reason = data.reason, !reason.isEmpty {
            let headerViewModel = WalletFormDetailsHeaderModel(title: L10n.Transaction.reason)
            viewModelList.append(headerViewModel)

            let viewModel = MultilineTitleIconViewModel(text: reason)
            let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
            viewModelList.append(separator)
        }
    }

    private func populateTime(into viewModelList: inout [WalletFormViewBindingProtocol],
                              data: AssetTransactionData,
                              locale: Locale) {
        let transactionDate = Date(timeIntervalSince1970: TimeInterval(data.timestamp))

        let timeDetails = localizableDataFormatter.value(for: locale).string(from: transactionDate)

        let viewModel = WalletNewFormDetailsViewModel(title: L10n.Transaction.date,
                                                      titleIcon: nil,
                                                      details: timeDetails,
                                                      detailsIcon: nil)

        let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
        viewModelList.append(separator)
    }

    private func populateType(into viewModelList: inout [WalletFormViewBindingProtocol],
                              data: AssetTransactionData,
                              locale: Locale) {
        guard let transactionType = transactionTypes.first(where: { $0.backendName == data.type }) else {
            return
        }

        let typeDisplayName = transactionType.displayName.value(for: locale)
        if !typeDisplayName.isEmpty {
            let viewModel = WalletNewFormDetailsViewModel(title: L10n.Transaction.type,
                                                          titleIcon: nil,
                                                          details: typeDisplayName,
                                                          detailsIcon: nil)

            let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
            viewModelList.append(separator)
        }
    }

    private func populatePeerId(into viewModelList: inout [WalletFormViewBindingProtocol],
                                data: AssetTransactionData) {

        guard
            !data.peerId.isEmpty,
            let transactionType = transactionTypes.first(where: { $0.backendName == data.type }) else {
            return
        }

        if transactionType == WalletTransactionType.incoming {
            let headerViewModel = WalletFormDetailsHeaderModel(title: L10n.Transaction.senderId)
            viewModelList.append(headerViewModel)

            let viewModel = MultilineTitleIconViewModel(text: data.peerId)
            let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
            viewModelList.append(separator)
        }

        if transactionType == WalletTransactionType.outgoing {
            let headerViewModel = WalletFormDetailsHeaderModel(title: L10n.Transaction.recipientId)
            viewModelList.append(headerViewModel)

            let viewModel = MultilineTitleIconViewModel(text: data.peerId)
            let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
            viewModelList.append(separator)
        }
    }

    private func populatePeerName(into viewModelList: inout [WalletFormViewBindingProtocol],
                                  data: AssetTransactionData) {
        guard
            let transactionType = transactionTypes.first(where: { $0.backendName == data.type }) else {
            return
        }

        if transactionType == WalletTransactionType.incoming {
            let viewModel = WalletNewFormDetailsViewModel(title: L10n.Transaction.sender,
                                                          details: data.localizedPeerName)
            let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
            viewModelList.append(separator)
        }

        if transactionType == WalletTransactionType.outgoing {
            let viewModel = WalletNewFormDetailsViewModel(title: L10n.Transaction.recipient,
                                                          details: data.localizedPeerName)
            let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
            viewModelList.append(separator)
        }
    }

    private func populateAmountReceived(into viewModelList: inout [WalletFormViewBindingProtocol],
                                        data: AssetTransactionData,
                                        locale: Locale) {
        guard let asset = assets.first(where: { $0.identifier == data.assetId }) else {
            return
        }

        let amount = data.amount.decimalValue

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset)

        guard let displayAmount = formatter.value(for: locale).string(from: amount) else {
            return
        }

        let viewModel = WalletNewFormDetailsViewModel(title: L10n.Amount.title,
                                                      titleIcon: nil,
                                                      details: displayAmount,
                                                      detailsIcon: nil)

        let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
        viewModelList.append(separator)
    }

    private func populateAmountSent(into viewModelList: inout [WalletFormViewBindingProtocol],
                                    data: AssetTransactionData,
                                    locale: Locale) {
        guard let asset = assets.first(where: { $0.identifier == data.assetId }) else {
            return
        }

        let amount = data.amount.decimalValue

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset)

        guard let displayAmount = formatter.value(for: locale).string(from: amount) else {
            return
        }

        let viewModel = WalletNewFormDetailsViewModel(title: L10n.Transaction.sent,
                                                      titleIcon: nil,
                                                      details: displayAmount,
                                                      detailsIcon: nil)

        let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
        viewModelList.append(separator)
    }

    private func populateMainFeeAmount(in viewModelList: inout [WalletFormViewBindingProtocol],
                                       data: AssetTransactionData,
                                       locale: Locale) {
        let asset = assets.first(where: { $0.identifier == data.assetId })

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset).value(for: locale)

        for fee in data.fees where fee.assetId == data.assetId {

            let feeDisplaySettings = feeDisplayFactory
                .createFeeSettingsForId(fee.identifier)

            guard let decimalAmount = feeDisplaySettings
                .displayStrategy.decimalValue(from: fee.amount.decimalValue) else {
                continue
            }

            guard let amount = formatter.string(from: decimalAmount) else {
                continue
            }

            let title = feeDisplaySettings.displayName.value(for: locale)

            let viewModel = WalletNewFormDetailsViewModel(title: title,
                                                          titleIcon: nil,
                                                          details: amount,
                                                          detailsIcon: nil)

            let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
            viewModelList.append(separator)
        }
    }

    func populateSecondaryFees(in viewModelList: inout [WalletFormViewBindingProtocol],
                               data: AssetTransactionData,
                               locale: Locale) {
        for fee in data.fees where fee.assetId != data.assetId {

            let asset = assets.first(where: { $0.identifier == fee.assetId })

            let formatter = amountFormatterFactory.createTokenFormatter(for: asset).value(for: locale)

            let feeDisplaySettings = feeDisplayFactory
                .createFeeSettingsForId(fee.identifier)

            guard let decimalAmount = feeDisplaySettings
                .displayStrategy.decimalValue(from: fee.amount.decimalValue) else {
                continue
            }

            guard let amount = formatter.string(from: decimalAmount) else {
                continue
            }

            let title = feeDisplaySettings.displayName.value(for: locale)

            let viewModel = WalletNewFormDetailsViewModel(title: title,
                                                          titleIcon: nil,
                                                          details: amount,
                                                          detailsIcon: nil)

            let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.top])
            viewModelList.append(separator)
        }
    }

    func populateTotalAmount(in viewModelList: inout [WalletFormViewBindingProtocol],
                             data: AssetTransactionData,
                             locale: Locale) {
        let asset = assets.first(where: { $0.identifier == data.assetId })

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset).value(for: locale)

        let totalAmountDecimal: Decimal = data.fees
            .reduce(data.amount.decimalValue) { (result, fee) in
            if fee.assetId == data.assetId {
                return result + fee.amount.decimalValue
            } else {
                return result
            }
        }

        guard let totalAmount = formatter.string(from: totalAmountDecimal) else {
            return
        }

        let viewModel = WalletFormSpentAmountModel(title: L10n.Amount.total,
                                                   amount: totalAmount)

        let separator = WalletFormSeparatedViewModel(content: viewModel, borderType: [.bottom])
        viewModelList.append(separator)
    }

    func populateNote(in viewModelList: inout [WalletFormViewBindingProtocol],
                      data: AssetTransactionData) {
        guard !data.details.isEmpty else {
            return
        }

        let headerViewModel = WalletFormDetailsHeaderModel(title: L10n.Common.description)
        viewModelList.append(headerViewModel)

        let viewModel = MultilineTitleIconViewModel(text: data.details)
        viewModelList.append(viewModel)
    }
}

extension WalletTransactionDetailsFactory: WalletTransactionDetailsFactoryProtocol {
    func createViewModelsFromTransaction(data: AssetTransactionData,
                                         commandFactory: WalletCommandFactoryProtocol,
                                         locale: Locale) -> [WalletFormViewBindingProtocol] {
        guard let transactionType = transactionTypes
            .first(where: { $0.backendName == data.type }) else {
            return []
        }

        var viewModelList: [WalletFormViewBindingProtocol] = []

        populatePeerId(into: &viewModelList, data: data)
        populateTransactionId(into: &viewModelList, data: data)
        populateStatus(into: &viewModelList, data: data)
        populateRejected(into: &viewModelList, data: data)
        populateTime(into: &viewModelList, data: data, locale: locale)
        populateType(into: &viewModelList, data: data, locale: locale)
        populatePeerName(into: &viewModelList, data: data)

        if transactionType.isIncome {
            populateAmountReceived(into: &viewModelList,
                                   data: data,
                                   locale: locale)
        } else {
            populateAmountSent(into: &viewModelList, data: data, locale: locale)
            populateMainFeeAmount(in: &viewModelList, data: data, locale: locale)
            populateTotalAmount(in: &viewModelList, data: data, locale: locale)
        }

        populateNote(in: &viewModelList, data: data)

        if !transactionType.isIncome {
            populateSecondaryFees(in: &viewModelList, data: data, locale: locale)
        }

        return viewModelList
    }

    func createAccessoryViewModelFromTransaction(data: AssetTransactionData,
                                                 commandFactory: WalletCommandFactoryProtocol,
                                                 locale: Locale) -> AccessoryViewModelProtocol? {
        guard let transactionType = transactionTypes.first(where: { $0.backendName == data.type }) else {
            return nil
        }

        guard let asset = assets.first(where: { $0.identifier == data.assetId }) else {
            return nil
        }

        if transactionType.isIncome,
            sendBackTypes.contains(transactionType.backendName),
            asset.modes.contains(.transfer) {
            let peerName = data.localizedPeerName
            let icon = UIImage.createAvatar(fullName: peerName, style: generatingIconStyle)
            return AccessoryViewModel(title: peerName,
                                      action: L10n.Transaction.sendBack,
                                      icon: icon)
        }

        if !transactionType.isIncome,
            sendAgainTypes.contains(transactionType.backendName),
            asset.modes.contains(.transfer) {
            let peerName = data.localizedPeerName
            let icon = UIImage.createAvatar(fullName: peerName, style: generatingIconStyle)
            return AccessoryViewModel(title: peerName,
                                      action: L10n.Transaction.sendBack,
                                      icon: icon)
        }

        return nil
    }
}
