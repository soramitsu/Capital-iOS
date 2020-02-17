/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import SoraFoundation


final class TransactionDetailsPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: TransactionDetailsCoordinatorProtocol

    let resolver: ResolverProtocol
    let configuration: TransactionDetailsConfigurationProtocol
    let transactionData: AssetTransactionData
    let transactionType: WalletTransactionType
    let accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol
    let feeDisplaySettings: FeeDisplaySettingsProtocol

    init(view: WalletFormViewProtocol,
         coordinator: TransactionDetailsCoordinatorProtocol,
         configuration: TransactionDetailsConfigurationProtocol,
         resolver: ResolverProtocol,
         transactionData: AssetTransactionData,
         transactionType: WalletTransactionType,
         accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol,
         feeDisplaySettings: FeeDisplaySettingsProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.configuration = configuration
        self.resolver = resolver
        self.transactionData = transactionData
        self.transactionType = transactionType
        self.accessoryViewModelFactory = accessoryViewModelFactory
        self.feeDisplaySettings = feeDisplaySettings
    }

    private func createStatusViewModel(for status: AssetTransactionStatus) -> WalletFormViewModel {
        switch status {
        case .commited:
            return WalletFormViewModel(layoutType: .accessory,
                                       title: L10n.Status.title,
                                       details: L10n.Status.success,
                                       detailsColor: resolver.style.statusStyleContainer.approved.color,
                                       icon: resolver.style.statusStyleContainer.approved.icon)
        case .pending:
            return WalletFormViewModel(layoutType: .accessory,
                                       title: L10n.Status.title,
                                       details: L10n.Status.pending,
                                       detailsColor: resolver.style.statusStyleContainer.pending.color,
                                       icon: resolver.style.statusStyleContainer.pending.icon)
        case .rejected:
            return WalletFormViewModel(layoutType: .accessory,
                                       title: L10n.Status.title,
                                       details: L10n.Status.rejected,
                                       detailsColor: resolver.style.statusStyleContainer.rejected.color,
                                       icon: resolver.style.statusStyleContainer.rejected.icon)
        }
    }

    private func createAmountViewModel(for amount: Decimal, title: String, hasIcon: Bool) -> WalletFormViewModel {
        let asset = resolver.account.assets.first {
            $0.identifier.identifier() == transactionData.assetId
        }

        let locale = localizationManager?.selectedLocale ?? Locale.current

        let assetSymbol = asset?.symbol ?? ""

        let amountString: String

        if let asset = asset {
            let amountFormatter = resolver.amountFormatterFactory.createDisplayFormatter(for: asset)
            amountString = amountFormatter.value(for: locale).string(from: amount as NSNumber) ?? ""
        } else {
            amountString = ""
        }

        let details = assetSymbol + amountString

        var icon: UIImage?

        if hasIcon {
            icon = transactionType.isIncome ? resolver.style.amountChangeStyle.increase
                : resolver.style.amountChangeStyle.decrease
        }

        return WalletFormViewModel(layoutType: .accessory,
                                   title: title,
                                   details: details,
                                   icon: icon)
    }

    private func createPeerViewModel() -> WalletFormViewModel? {
        if transactionType.backendName == WalletTransactionType.incoming.backendName {
            return WalletFormViewModel(layoutType: .accessory,
                                       title: L10n.Transaction.sender,
                                       details: transactionData.peerName)
        }

        if transactionType.backendName == WalletTransactionType.outgoing.backendName {
            return WalletFormViewModel(layoutType: .accessory,
                                       title: L10n.Transaction.recipient,
                                       details: transactionData.peerName)
        }

        return nil
    }

    private func createAmountViewModels() -> [WalletFormViewModel] {
        let amount = transactionData.amount.decimalValue

        if !transactionType.isIncome,
            let fee = feeDisplaySettings.displayStrategy.decimalValue(from: transactionData.fee?.decimalValue) {
            
            let totalAmount = amount + fee

            let locale = localizationManager?.selectedLocale ?? Locale.current
            let feeTitle = feeDisplaySettings.displayName.value(for: locale)

            return [createAmountViewModel(for: amount, title: L10n.Transaction.sent, hasIcon: false),
                    createAmountViewModel(for: fee, title: feeTitle, hasIcon: false),
                    createAmountViewModel(for: totalAmount, title: L10n.Amount.total, hasIcon: true)]
        } else {
            return [createAmountViewModel(for: amount, title: L10n.Amount.title, hasIcon: true)]
        }
    }

    private func createAccessoryViewModel() -> AccessoryViewModel {
        let nameComponents = transactionData.peerName.components(separatedBy: " ")
        let firstName = nameComponents.first ?? ""
        let lastName = nameComponents.last ?? ""

        return accessoryViewModelFactory.createViewModel(from: transactionData.peerName,
                                                         firstName: firstName,
                                                         lastName: lastName,
                                                         action: L10n.Transaction.sendBack)
    }

    private func updateView() {
        var viewModels = [WalletFormViewModel]()

        let idViewModel = WalletFormViewModel(layoutType: .accessory,
                                              title: L10n.Transaction.id,
                                              details: transactionData.displayIdentifier)
        viewModels.append(idViewModel)

        let statusViewModel: WalletFormViewModel = createStatusViewModel(for: transactionData.status)
        viewModels.append(statusViewModel)

        if transactionData.status == .rejected, let reason = transactionData.reason, !reason.isEmpty {
            let reasonViewModel = WalletFormViewModel(layoutType: .details,
                                                      title: L10n.Transaction.reason,
                                                      details: reason)
            viewModels.append(reasonViewModel)
        }

        let transactionDate = Date(timeIntervalSince1970: TimeInterval(transactionData.timestamp))

        let locale = localizationManager?.selectedLocale ?? Locale.current
        let details = resolver.statusDateFormatter.value(for: locale).string(from: transactionDate)

        let timeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: L10n.Transaction.date,
                                                details: details)
        viewModels.append(timeViewModel)

        let typeDisplayName = transactionType.displayName.value(for: locale)
        if !typeDisplayName.isEmpty {
            let typeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                    title: L10n.Transaction.type,
                                                    details: typeDisplayName)
            viewModels.append(typeViewModel)
        }

        if let peerViewModel = createPeerViewModel() {
            viewModels.append(peerViewModel)
        }

        viewModels.append(contentsOf: createAmountViewModels())

        if !transactionData.details.isEmpty {
            let descriptionViewModel = WalletFormViewModel(layoutType: .details,
                                                           title: L10n.Common.description,
                                                           details: transactionData.details)

            viewModels.append(descriptionViewModel)
        }

        view?.didReceive(viewModels: viewModels)

        if transactionType.isIncome,
            configuration.sendBackTransactionTypes.contains(transactionType.backendName) {
            let accessoryViewModel = createAccessoryViewModel()
            view?.didReceive(accessoryViewModel: accessoryViewModel)
        }
    }
}


extension TransactionDetailsPresenter: TransactionDetailsPresenterProtocol {
    func setup() {
        updateView()
    }

    func performAction() {
        guard
            let accountId = try? IRAccountIdFactory.account(withIdentifier: transactionData.peerId),
            let assetId = try? IRAssetIdFactory.asset(withIdentifier: transactionData.assetId) else {
            return
        }

        let receiverInfo = ReceiveInfo(accountId: accountId,
                                       assetId: assetId,
                                       amount: nil,
                                       details: nil)

        let payload = AmountPayload(receiveInfo: receiverInfo,
                                    receiverName: transactionData.peerName)

        coordinator.send(to: payload)
    }
}


extension TransactionDetailsPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            updateView()
        }
    }
}
