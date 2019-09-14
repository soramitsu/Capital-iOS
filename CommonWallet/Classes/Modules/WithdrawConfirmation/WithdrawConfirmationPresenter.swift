/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

final class WithdrawConfirmationPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: WithdrawConfirmationCoordinatorProtocol

    let walletService: WalletServiceProtocol
    let withdrawInfo: WithdrawInfo
    let asset: WalletAsset
    let withdrawOption: WalletWithdrawOption
    let style: WalletStyleProtocol
    let amountFormatter: NumberFormatter

    init(view: WalletFormViewProtocol,
         coordinator: WithdrawConfirmationCoordinatorProtocol,
         walletService: WalletServiceProtocol,
         withdrawInfo: WithdrawInfo,
         asset: WalletAsset,
         withdrawOption: WalletWithdrawOption,
         style: WalletStyleProtocol,
         amountFormatter: NumberFormatter) {
        self.view = view
        self.coordinator = coordinator
        self.walletService = walletService
        self.withdrawInfo = withdrawInfo
        self.asset = asset
        self.withdrawOption = withdrawOption
        self.style = style
        self.amountFormatter = amountFormatter
    }

    private func createAmountViewModel() -> WalletFormViewModelProtocol {
        let details: String

        if let amountDecimal = Decimal(string: withdrawInfo.amount.value),
            let formatterAmount = amountFormatter.string(from: amountDecimal as NSNumber) {
            details = "\(asset.symbol)\(formatterAmount)"
        } else {
            details = "\(asset.symbol)\(withdrawInfo.amount.value)"
        }

        return WalletFormViewModel(layoutType: .accessory,
                                   title: "Amount to send",
                                   details: details)
    }

    private func createFeeViewModel() -> WalletFormViewModelProtocol? {
        guard let fee = withdrawInfo.fee else {
            return nil
        }

        let details: String

        if let feeDecimal = Decimal(string: fee.value),
            let formatterFee = amountFormatter.string(from: feeDecimal as NSNumber) {
            details = "\(asset.symbol)\(formatterFee)"
        } else {
            details = "\(asset.symbol)\(fee.value)"
        }

        return WalletFormViewModel(layoutType: .accessory,
                                   title: "Transaction fee",
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
        let accessoryViewModel = AccessoryViewModel(title: "", action: "Next")

        guard let fee = withdrawInfo.fee,
            let feeDecimal = Decimal(string: fee.value),
            let amountDecimal = Decimal(string: withdrawInfo.amount.value) else {
            return accessoryViewModel
        }

        let totalAmount = amountDecimal + feeDecimal

        guard let totalAmountString = amountFormatter.string(from: totalAmount as NSNumber) else {
            return accessoryViewModel
        }

        accessoryViewModel.title = "Total amount \(asset.symbol)\(totalAmountString)"
        accessoryViewModel.numberOfLines = 2

        return accessoryViewModel
    }

    private func updateView() {
        var viewModels: [WalletFormViewModelProtocol] = []

        let titleViewModel = WalletFormViewModel(layoutType: .accessory,
                                                 title: "Please check and confirm details",
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

    private func handleWithdraw(result: OperationResult<Void>) {
        switch result {
        case .success:
            coordinator.showResult(for: withdrawInfo, asset: asset, option: withdrawOption)
        case .error:
            view?.showError(message: "Withdraw failed. Please, try again later.")
        }
    }
}


extension WithdrawConfirmationPresenter: WithdrawConfirmationPresenterProtocol {
    func setup() {
        updateView()
    }

    func performAction() {
        view?.didStartLoading()

        _ = walletService.withdraw(info: withdrawInfo, runCompletionIn: .main) { [weak self] result in
            self?.view?.didStopLoading()

            if let result = result {
                self?.handleWithdraw(result: result)
            }
        }
    }
}
