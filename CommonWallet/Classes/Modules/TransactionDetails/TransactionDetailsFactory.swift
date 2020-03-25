/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

public protocol WalletTransactionDetailsFactoryProtocol {
    func createForm(from data: AssetTransactionData,
                    type: WalletTransactionType,
                    asset: WalletAsset) -> [WalletFormViewModelProtocol]
}

final class WalletTransactionDetailsFactory {
    private let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }

    private func populateTransactionId(into viewModelList: inout [WalletFormViewModelProtocol],
                                       data: AssetTransactionData) {
        let actionsFactory = resolver.transactionDetailsConfiguration.fieldActionFactory
        var command: WalletCommandProtocol?

        if let actions = actionsFactory.createActions(for: .transactionId, data: data), actions.count > 0 {
            command = ActionSheetCommand(resolver: resolver,
                                         source: data,
                                         title: LocalizableResource { _ in L10n.Common.optionsTitle },
                                         options: actions)
        }

        let idViewModel = WalletFormViewModel(layoutType: .details,
                                              title: L10n.Transaction.id,
                                              details: data.transactionId,
                                              command: command)
        viewModelList.append(idViewModel)
    }

    private func populateStatus(into viewModelList: inout [WalletFormViewModelProtocol],
                                status: AssetTransactionStatus) {
        let viewModel: WalletFormViewModelProtocol
        switch status {
        case .commited:
            viewModel = WalletFormViewModel(layoutType: .accessory,
                                            title: L10n.Status.title,
                                            details: L10n.Status.success,
                                            detailsColor: resolver.style.statusStyleContainer.approved.color,
                                            icon: resolver.style.statusStyleContainer.approved.icon)
        case .pending:
            viewModel = WalletFormViewModel(layoutType: .accessory,
                                            title: L10n.Status.title,
                                            details: L10n.Status.pending,
                                            detailsColor: resolver.style.statusStyleContainer.pending.color,
                                            icon: resolver.style.statusStyleContainer.pending.icon)
        case .rejected:
            viewModel = WalletFormViewModel(layoutType: .accessory,
                                            title: L10n.Status.title,
                                            details: L10n.Status.rejected,
                                            detailsColor: resolver.style.statusStyleContainer.rejected.color,
                                            icon: resolver.style.statusStyleContainer.rejected.icon)
        }

        viewModelList.append(viewModel)
    }

    private func populateRejected(into viewModelList: inout [WalletFormViewModelProtocol],
                                  data: AssetTransactionData) {
        if data.status == .rejected, let reason = data.reason, !reason.isEmpty {
            let reasonViewModel = WalletFormViewModel(layoutType: .details,
                                                      title: L10n.Transaction.reason,
                                                      details: reason)
            viewModelList.append(reasonViewModel)
        }
    }

    private func populateTime(into viewModelList: inout [WalletFormViewModelProtocol], timestamp: Int64) {
        let transactionDate = Date(timeIntervalSince1970: TimeInterval(timestamp))

        let locale = resolver.localizationManager?.selectedLocale ?? Locale.current
        let timeDetails = resolver.statusDateFormatter.value(for: locale).string(from: transactionDate)

        let timeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: L10n.Transaction.date,
                                                details: timeDetails)
        viewModelList.append(timeViewModel)
    }

    private func populateType(into viewModelList: inout [WalletFormViewModelProtocol],
                              type: WalletTransactionType) {
        let locale = resolver.localizationManager?.selectedLocale ?? Locale.current
        let typeDisplayName = type.displayName.value(for: locale)
        if !typeDisplayName.isEmpty {
            let typeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                    title: L10n.Transaction.type,
                                                    details: typeDisplayName)
            viewModelList.append(typeViewModel)
        }
    }

    private func populatePeer(into viewModelList: inout [WalletFormViewModelProtocol],
                              data: AssetTransactionData,
                              peerIdTitle: String,
                              peerNameTitle: String) {
        if !data.peerId.isEmpty {
            let fieldActionFactory = resolver.transactionDetailsConfiguration.fieldActionFactory
            var command: WalletCommandProtocol?

            if let actions = fieldActionFactory.createActions(for: .peerId, data: data), actions.count > 0 {
                command = ActionSheetCommand(resolver: resolver,
                                             source: data,
                                             title: LocalizableResource { _ in L10n.Common.optionsTitle },
                                             options: actions)
            }

            let peerId = WalletFormViewModel(layoutType: .details,
                                             title: peerIdTitle,
                                             details: data.peerId,
                                             command: command)
            viewModelList.insert(peerId, at: 0)
        }

        let peerName = WalletFormViewModel(layoutType: .accessory,
                                           title: peerNameTitle,
                                           details: data.localizedPeerName)
        viewModelList.append(peerName)
    }

    private func populatePeer(into viewModelList: inout [WalletFormViewModelProtocol],
                              data: AssetTransactionData,
                              type: WalletTransactionType) {
        if type.backendName == WalletTransactionType.incoming.backendName {
            populatePeer(into: &viewModelList,
                         data: data,
                         peerIdTitle: L10n.Transaction.senderId,
                         peerNameTitle: L10n.Transaction.sender)
        }

        if type.backendName == WalletTransactionType.outgoing.backendName {
            populatePeer(into: &viewModelList,
                         data: data,
                         peerIdTitle: L10n.Transaction.recipientId,
                         peerNameTitle: L10n.Transaction.recipient)
        }
    }

    private func populateAmount(into viewModelList: inout [WalletFormViewModelProtocol],
                                asset: WalletAsset,
                                amount: Decimal,
                                title: String,
                                icon: UIImage?) {

        let locale = resolver.localizationManager?.selectedLocale ?? Locale.current

        let amountFormatter = resolver.amountFormatterFactory.createDisplayFormatter(for: asset)
        let amountString = amountFormatter.value(for: locale).string(from: amount as NSNumber) ?? ""

        let details = asset.symbol + amountString

        let viewModel = WalletFormViewModel(layoutType: .accessory, title: title, details: details, icon: icon)
        viewModelList.append(viewModel)
    }

    private func populateAmount(into viewModelList: inout [WalletFormViewModelProtocol],
                                data: AssetTransactionData,
                                type: WalletTransactionType,
                                asset: WalletAsset,
                                feeSettings: FeeDisplaySettingsProtocol) {
        let amount = data.amount.decimalValue

        let icon = type.isIncome ? resolver.style.amountChangeStyle.increase
            : resolver.style.amountChangeStyle.decrease

        if !type.isIncome,
            let fee = feeSettings.displayStrategy.decimalValue(from: data.fee?.decimalValue) {

            let totalAmount = amount + fee

            let locale = resolver.localizationManager?.selectedLocale ?? Locale.current
            let feeTitle = feeSettings.displayName.value(for: locale)

            populateAmount(into: &viewModelList,
                           asset: asset,
                           amount: amount,
                           title: L10n.Transaction.sent,
                           icon: nil)

            populateAmount(into: &viewModelList,
                           asset: asset,
                           amount: fee,
                           title: feeTitle,
                           icon: nil)

            populateAmount(into: &viewModelList,
                           asset: asset,
                           amount: totalAmount,
                           title: L10n.Amount.total,
                           icon: icon)

        } else {
            populateAmount(into: &viewModelList,
                           asset: asset,
                           amount: amount,
                           title: L10n.Amount.title,
                           icon: icon)
        }
    }

    private func populateDetails(into viewModelList: inout [WalletFormViewModelProtocol], text: String) {
        if !text.isEmpty {
            let descriptionViewModel = WalletFormViewModel(layoutType: .details,
                                                           title: L10n.Common.description,
                                                           details: text)

            viewModelList.append(descriptionViewModel)
        }
    }
}

extension WalletTransactionDetailsFactory: WalletTransactionDetailsFactoryProtocol {
    func createForm(from data: AssetTransactionData,
                    type: WalletTransactionType,
                    asset: WalletAsset) -> [WalletFormViewModelProtocol] {

        let senderId = type.isIncome ? data.peerId : resolver.account.accountId.identifier()
        let receiverId = type.isIncome ? resolver.account.accountId.identifier() : data.peerId

        let feeSettings = resolver.feeDisplaySettingsFactory.createFeeSettings(asset: asset,
                                                                               senderId: senderId,
                                                                               receiverId: receiverId)

        var viewModels: [WalletFormViewModelProtocol] = []

        populateTransactionId(into: &viewModels, data: data)

        populateStatus(into: &viewModels, status: data.status)

        populateRejected(into: &viewModels, data: data)

        populateTime(into: &viewModels, timestamp: data.timestamp)

        populateType(into: &viewModels, type: type)

        populatePeer(into: &viewModels, data: data, type: type)

        populateAmount(into: &viewModels, data: data, type: type, asset: asset, feeSettings: feeSettings)

        populateDetails(into: &viewModels, text: data.details)

        return viewModels
    }
}
