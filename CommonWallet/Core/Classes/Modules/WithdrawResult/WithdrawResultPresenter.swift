/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

final class WithdrawResultPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: WithdrawResultCoordinatorProtocol

    let withdrawInfo: WithdrawInfo
    let asset: WalletAsset
    let withdrawOption: WalletWithdrawOption
    let style: WalletStyleProtocol
    let amountFormatter: LocalizableResource<TokenAmountFormatter>
    let dateFormatter: LocalizableResource<DateFormatter>
    let feeDisplaySettings: FeeDisplaySettingsProtocol

    init(view: WalletFormViewProtocol,
         coordinator: WithdrawResultCoordinatorProtocol,
         withdrawInfo: WithdrawInfo,
         asset: WalletAsset,
         withdrawOption: WalletWithdrawOption,
         style: WalletStyleProtocol,
         amountFormatter: LocalizableResource<TokenAmountFormatter>,
         dateFormatter: LocalizableResource<DateFormatter>,
         feeDisplaySettings: FeeDisplaySettingsProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.withdrawInfo = withdrawInfo
        self.asset = asset
        self.style = style
        self.withdrawOption = withdrawOption
        self.amountFormatter = amountFormatter
        self.dateFormatter = dateFormatter
        self.feeDisplaySettings = feeDisplaySettings
    }

    private func createAmountViewModel() -> WalletFormViewModelProtocol {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let details: String

        let amountDecimal = withdrawInfo.amount.decimalValue

        if let formatterAmount = amountFormatter.value(for: locale)
                .string(from: amountDecimal) {
            details = formatterAmount
        } else {
            details = "\(asset.symbol)\(withdrawInfo.amount.stringValue)"
        }

        return WalletFormViewModel(layoutType: .accessory,
                                   title: L10n.Amount.send,
                                   details: details)
    }

    private func createFeeViewModel() -> WalletFormViewModelProtocol? {
        guard let fee = feeDisplaySettings.displayStrategy
            .decimalValue(from: withdrawInfo.fees.first?.value.decimalValue) else {
            return nil
        }

        let details: String

        let locale = localizationManager?.selectedLocale ?? Locale.current

        if let formatterFee = amountFormatter.value(for: locale).string(from: fee) {
            details = formatterFee
        } else {
            details = "\(asset.symbol)\(fee)"
        }

        let title = feeDisplaySettings.displayName.value(for: locale)

        return WalletFormViewModel(layoutType: .accessory,
                                   title: title,
                                   details: details)
    }

    private func createTotalAmountViewModel() -> WalletFormViewModelProtocol? {
        guard let feeDecimal = feeDisplaySettings.displayStrategy
            .decimalValue(from: withdrawInfo.fees.first?.value.decimalValue) else {
                return nil
        }

        let amountDecimal = withdrawInfo.amount.decimalValue

        let totalAmountDecimal = amountDecimal + feeDecimal

        let locale = localizationManager?.selectedLocale ?? Locale.current

        guard let details = amountFormatter.value(for: locale)
            .string(from: totalAmountDecimal) else {
            return nil
        }

        return WalletFormViewModel(layoutType: .accessory,
                                   title: L10n.Amount.total,
                                   details: details,
                                   icon: style.amountChangeStyle.decrease)
    }

    private func createDescriptionViewModel() -> WalletFormViewModelProtocol? {
        guard !withdrawInfo.details.isEmpty else {
            return nil
        }

        return WalletFormViewModel(layoutType: .details,
                                   title: withdrawOption.details,
                                   details: withdrawInfo.details)
    }

    private func provideFormViewModels() {
        var viewModels: [WalletFormViewModelProtocol] = []

        let statusViewModel = WalletFormViewModel(layoutType: .accessory,
                                                  title: L10n.Status.title,
                                                  details: L10n.Status.pending,
                                                  icon: style.statusStyleContainer.pending.icon)
        viewModels.append(statusViewModel)

        let locale = localizationManager?.selectedLocale ?? Locale.current

        let details = dateFormatter.value(for: locale).string(from: Date())
        let timeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: L10n.Transaction.date,
                                                details: details)
        viewModels.append(timeViewModel)

        let amountViewModel = createAmountViewModel()
        viewModels.append(amountViewModel)

        if let feeViewModel = createFeeViewModel() {
            viewModels.append(feeViewModel)
        }

        if let totalAmountViewModel = createTotalAmountViewModel() {
            viewModels.append(totalAmountViewModel)
        }

        if let descriptionViewModel = createDescriptionViewModel() {
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


extension WithdrawResultPresenter: WithdrawResultPresenterProtocol {
    func setup() {
        provideFormViewModels()
        provideAccessoryViewModel()
    }

    func performAction() {
        coordinator.dismiss()
    }
}


extension WithdrawResultPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            provideFormViewModels()
            provideAccessoryViewModel()
        }
    }
}
