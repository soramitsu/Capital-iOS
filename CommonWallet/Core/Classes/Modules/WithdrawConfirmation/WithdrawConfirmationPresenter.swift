/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import SoraFoundation


final class WithdrawConfirmationPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: WithdrawConfirmationCoordinatorProtocol

    let walletService: WalletServiceProtocol
    let withdrawInfo: WithdrawInfo
    let asset: WalletAsset
    let withdrawOption: WalletWithdrawOption
    let style: WalletStyleProtocol
    let amountFormatter: LocalizableResource<TokenAmountFormatter>
    let eventCenter: WalletEventCenterProtocol
    let feeDisplaySettings: FeeDisplaySettingsProtocol

    init(view: WalletFormViewProtocol,
         coordinator: WithdrawConfirmationCoordinatorProtocol,
         walletService: WalletServiceProtocol,
         withdrawInfo: WithdrawInfo,
         asset: WalletAsset,
         withdrawOption: WalletWithdrawOption,
         style: WalletStyleProtocol,
         amountFormatter: LocalizableResource<TokenAmountFormatter>,
         eventCenter: WalletEventCenterProtocol,
         feeDisplaySettings: FeeDisplaySettingsProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.walletService = walletService
        self.withdrawInfo = withdrawInfo
        self.asset = asset
        self.withdrawOption = withdrawOption
        self.style = style
        self.amountFormatter = amountFormatter
        self.eventCenter = eventCenter
        self.feeDisplaySettings = feeDisplaySettings
    }

    private func createAmountViewModel() -> WalletFormViewModelProtocol {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let details: String

        if let formatterAmount = amountFormatter.value(for: locale)
                .string(from: withdrawInfo.amount.decimalValue) {
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

    private func createDescriptionViewModel() -> WalletFormViewModelProtocol? {
        guard !withdrawInfo.details.isEmpty else {
            return nil
        }

        return WalletFormViewModel(layoutType: .details,
                                   title: withdrawOption.details,
                                   details: withdrawInfo.details)
    }

    private func createAccessoryViewModel() -> AccessoryViewModelProtocol {
        var accessoryViewModel = AccessoryViewModel(title: "", action: L10n.Withdraw.title)

        guard let feeDecimal = feeDisplaySettings.displayStrategy
            .decimalValue(from: withdrawInfo.fees.first?.value.decimalValue) else {
            return accessoryViewModel
        }

        let amountDecimal = withdrawInfo.amount.decimalValue

        let totalAmount = amountDecimal + feeDecimal

        let locale = localizationManager?.selectedLocale ?? Locale.current

        guard let totalAmountString = amountFormatter.value(for: locale)
            .string(from: totalAmount) else {
            return accessoryViewModel
        }

        accessoryViewModel.title = L10n.Withdraw.totalAmount(asset.symbol,
                                                             totalAmountString)
        accessoryViewModel.numberOfLines = 2

        return accessoryViewModel
    }

    private func updateView() {
        var viewModels: [WalletFormViewModelProtocol] = []

        let titleViewModel = WalletFormViewModel(layoutType: .accessory,
                                                 title: L10n.Confirmation.hint,
                                                 details: nil)
        viewModels.append(titleViewModel)

        let amountViewModel = createAmountViewModel()
        viewModels.append(amountViewModel)

        if let feeViewModel = createFeeViewModel() {
            viewModels.append(feeViewModel)
        }

        if let descriptionViewModel = createDescriptionViewModel() {
            viewModels.append(descriptionViewModel)
        }

        view?.didReceive(viewModels: viewModels)

        let accesoryViewModel = createAccessoryViewModel()
        view?.didReceive(accessoryViewModel: accesoryViewModel)
    }

    private func handleWithdraw(result: Result<Data, Error>) {
        switch result {
        case .success:
            eventCenter.notify(with: WithdrawCompleteEvent(withdrawInfo: withdrawInfo))

            coordinator.showResult(for: withdrawInfo, asset: asset, option: withdrawOption)
        case .failure:
            view?.showError(message: L10n.Withdraw.Error.fail)
        }
    }
}


extension WithdrawConfirmationPresenter: WithdrawConfirmationPresenterProtocol {
    func setup() {
        updateView()
    }

    func performAction() {
        view?.didStartLoading()

        walletService.withdraw(info: withdrawInfo, runCompletionIn: .main) { [weak self] result in
            self?.view?.didStopLoading()

            if let result = result {
                self?.handleWithdraw(result: result)
            }
        }
    }
}


extension WithdrawConfirmationPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            updateView()
        }
    }
}
