/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import SoraFoundation


final class TransferResultPresenter {

    weak var view: WalletFormViewProtocol?
    var coordinator: TransferResultCoordinatorProtocol

    let transferPayload: ConfirmationPayload
    let resolver: ResolverProtocol
    let feeDisplaySettings: FeeDisplaySettingsProtocol

    init(view: WalletFormViewProtocol,
         coordinator: TransferResultCoordinatorProtocol,
         payload: ConfirmationPayload,
         resolver: ResolverProtocol,
         feeDisplaySettings: FeeDisplaySettingsProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.resolver = resolver
        self.transferPayload = payload
        self.feeDisplaySettings = feeDisplaySettings
    }

    private func prepareSingleAmountViewModel(for amount: String) -> WalletFormViewModel {
        return WalletFormViewModel(layoutType: .accessory, title: L10n.Amount.title,
                                   details: amount,
                                   icon: resolver.style.amountChangeStyle.decrease)
    }

    private func prepareAmountViewModels() -> [WalletFormViewModel] {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let asset = resolver.account.assets.first {
            $0.identifier == transferPayload.transferInfo.asset
        }

        let amountFormatter = resolver.amountFormatterFactory.createTokenFormatter(for: asset)

        let decimalAmount = transferPayload.transferInfo.amount.decimalValue

        guard let amount = amountFormatter.value(for: locale)
            .string(from: decimalAmount) else {
                let amount = "\(transferPayload.transferInfo.amount.stringValue)"
                let viewModel = prepareSingleAmountViewModel(for: amount)
                return [viewModel]

        }

        // TODO: move to multi fee variant when ui ready

        guard
            let decimalFee = feeDisplaySettings.displayStrategy
                .decimalValue(from: transferPayload.transferInfo.fees.first?.value.decimalValue),
            let fee = amountFormatter.value(for: locale)
                .string(from: decimalFee) else {
                let viewModel = prepareSingleAmountViewModel(for: amount)
                return [viewModel]
        }

        let totalAmountDecimal = decimalAmount + decimalFee

        let amountViewModel = WalletFormViewModel(layoutType: .accessory,
                                                  title: L10n.Amount.send,
                                                  details: amount)

        let feeTitle = feeDisplaySettings.displayName.value(for: locale)

        let feeViewModel = WalletFormViewModel(layoutType: .accessory,
                                               title: feeTitle,
                                               details: fee)

        var viewModels = [amountViewModel, feeViewModel]

        if let totalAmount = amountFormatter.value(for: locale)
            .string(from: totalAmountDecimal) {
            let totalAmountViewModel = WalletFormViewModel(layoutType: .accessory,
                                                           title: L10n.Amount.total,
                                                           details: totalAmount,
                                                           icon: resolver.style.amountChangeStyle.decrease)
            viewModels.append(totalAmountViewModel)
        }

        return viewModels
    }

    private func provideMainViewModels() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let statusViewModel = WalletFormViewModel(layoutType: .accessory,
                                                  title: L10n.Status.title,
                                                  details: L10n.Status.pending,
                                                  icon: resolver.style.statusStyleContainer.pending.icon)

        let details = resolver.statusDateFormatter.value(for: locale).string(from: Date())
        let timeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: L10n.Transaction.date,
                                                details: details)
        let receiverViewModel = WalletFormViewModel(layoutType: .accessory,
                                                    title: L10n.Transaction.recipient,
                                                    details: transferPayload.receiverName)

        var viewModels = [statusViewModel, timeViewModel, receiverViewModel]

        let amountViewModels = prepareAmountViewModels()
        viewModels.append(contentsOf: amountViewModels)

        if !transferPayload.transferInfo.details.isEmpty {
            let descriptionViewModel = WalletFormViewModel(layoutType: .details,
                                                           title: L10n.Common.description,
                                                           details: transferPayload.transferInfo.details)

            viewModels.append(descriptionViewModel)
        }

        view?.didReceive(viewModels: viewModels)
    }

    private func provideAccessoryViewModel() {
        let viewModel = AccessoryViewModel(title: L10n.Transaction.pendingDescription,
                                           action: L10n.Common.done)
        view?.didReceive(accessoryViewModel: viewModel)
    }
}


extension TransferResultPresenter: TransferResultPresenterProtocol {
    func setup() {
        provideMainViewModels()
        provideAccessoryViewModel()
    }

    func performAction() {
        coordinator.dismiss()
    }
}

extension TransferResultPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            provideMainViewModels()
            provideAccessoryViewModel()
        }
    }
}
