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
    let amountFormatter: LocalizableResource<NumberFormatter>
    let dateFormatter: LocalizableResource<DateFormatter>
    let feeDisplayStrategy: FeeDisplayStrategyProtocol

    init(view: WalletFormViewProtocol,
         coordinator: WithdrawResultCoordinatorProtocol,
         withdrawInfo: WithdrawInfo,
         asset: WalletAsset,
         withdrawOption: WalletWithdrawOption,
         style: WalletStyleProtocol,
         amountFormatter: LocalizableResource<NumberFormatter>,
         dateFormatter: LocalizableResource<DateFormatter>,
         feeDisplayStrategy: FeeDisplayStrategyProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.withdrawInfo = withdrawInfo
        self.asset = asset
        self.style = style
        self.withdrawOption = withdrawOption
        self.amountFormatter = amountFormatter
        self.dateFormatter = dateFormatter
        self.feeDisplayStrategy = feeDisplayStrategy
    }

    private func createAmountViewModel() -> WalletFormViewModelProtocol {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let details: String

        if let amountDecimal = Decimal(string: withdrawInfo.amount.value),
            let formatterAmount = amountFormatter.value(for: locale)
                .string(from: amountDecimal as NSNumber) {
            details = "\(asset.symbol)\(formatterAmount)"
        } else {
            details = "\(asset.symbol)\(withdrawInfo.amount.value)"
        }

        return WalletFormViewModel(layoutType: .accessory,
                                   title: L10n.Amount.send,
                                   details: details)
    }

    private func createFeeViewModel() -> WalletFormViewModelProtocol? {
        guard let fee = feeDisplayStrategy.decimalValue(from: withdrawInfo.fee?.value) else {
            return nil
        }

        let details: String

        let locale = localizationManager?.selectedLocale ?? Locale.current

        if let formatterFee = amountFormatter.value(for: locale).string(from: fee as NSNumber) {
            details = "\(asset.symbol)\(formatterFee)"
        } else {
            details = "\(asset.symbol)\(fee)"
        }

        return WalletFormViewModel(layoutType: .accessory,
                                   title: L10n.Amount.fee,
                                   details: details)
    }

    private func createTotalAmountViewModel() -> WalletFormViewModelProtocol? {
        guard
            let feeDecimal = feeDisplayStrategy.decimalValue(from: withdrawInfo.fee?.value),
            let amountDecimal = Decimal(string: withdrawInfo.amount.value) else {
                return nil
        }

        let totalAmountDecimal = amountDecimal + feeDecimal

        let locale = localizationManager?.selectedLocale ?? Locale.current

        guard let totalAmount = amountFormatter.value(for: locale)
            .string(from: totalAmountDecimal as NSNumber) else {
            return nil
        }

        let details = "\(asset.symbol)\(totalAmount)"

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
