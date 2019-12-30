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
    let amountFormatter: LocalizableResource<NumberFormatter>
    let eventCenter: WalletEventCenterProtocol

    init(view: WalletFormViewProtocol,
         coordinator: WithdrawConfirmationCoordinatorProtocol,
         walletService: WalletServiceProtocol,
         withdrawInfo: WithdrawInfo,
         asset: WalletAsset,
         withdrawOption: WalletWithdrawOption,
         style: WalletStyleProtocol,
         amountFormatter: LocalizableResource<NumberFormatter>,
         eventCenter: WalletEventCenterProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.walletService = walletService
        self.withdrawInfo = withdrawInfo
        self.asset = asset
        self.withdrawOption = withdrawOption
        self.style = style
        self.amountFormatter = amountFormatter
        self.eventCenter = eventCenter
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
        guard let fee = withdrawInfo.fee else {
            return nil
        }

        let details: String

        let locale = localizationManager?.selectedLocale ?? Locale.current

        if let feeDecimal = Decimal(string: fee.value),
            let formatterFee = amountFormatter.value(for: locale)
                .string(from: feeDecimal as NSNumber) {
            details = "\(asset.symbol)\(formatterFee)"
        } else {
            details = "\(asset.symbol)\(fee.value)"
        }

        return WalletFormViewModel(layoutType: .accessory,
                                   title: L10n.Amount.fee,
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
        let accessoryViewModel = AccessoryViewModel(title: "", action: L10n.Withdraw.title)

        guard let fee = withdrawInfo.fee,
            let feeDecimal = Decimal(string: fee.value),
            let amountDecimal = Decimal(string: withdrawInfo.amount.value) else {
            return accessoryViewModel
        }

        let totalAmount = amountDecimal + feeDecimal

        let locale = localizationManager?.selectedLocale ?? Locale.current

        guard let totalAmountString = amountFormatter.value(for: locale)
            .string(from: totalAmount as NSNumber) else {
            return accessoryViewModel
        }

        accessoryViewModel.title = L10n.Withdraw.totalAmount(asset.symbol, totalAmountString)
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

    private func handleWithdraw(result: Result<Void, Error>) {
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
