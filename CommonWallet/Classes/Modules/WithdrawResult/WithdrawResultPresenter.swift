/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

final class WithdrawResultPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: WithdrawResultCoordinatorProtocol

    let withdrawInfo: WithdrawInfo
    let asset: WalletAsset
    let withdrawOption: WalletWithdrawOption
    let style: WalletStyleProtocol
    let amountFormatter: NumberFormatter
    let dateFormatter: DateFormatter

    init(view: WalletFormViewProtocol,
         coordinator: WithdrawResultCoordinatorProtocol,
         withdrawInfo: WithdrawInfo,
         asset: WalletAsset,
         withdrawOption: WalletWithdrawOption,
         style: WalletStyleProtocol,
         amountFormatter: NumberFormatter,
         dateFormatter: DateFormatter) {
        self.view = view
        self.coordinator = coordinator
        self.withdrawInfo = withdrawInfo
        self.asset = asset
        self.style = style
        self.withdrawOption = withdrawOption
        self.amountFormatter = amountFormatter
        self.dateFormatter = dateFormatter
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

    private func createTotalAmountViewModel() -> WalletFormViewModelProtocol? {
        guard
            let fee = withdrawInfo.fee,
            let feeDecimal = Decimal(string: fee.value),
            let amountDecimal = Decimal(string: withdrawInfo.amount.value) else {
                return nil
        }

        let totalAmountDecimal = amountDecimal + feeDecimal

        guard let totalAmount = amountFormatter.string(from: totalAmountDecimal as NSNumber) else {
            return nil
        }

        let details = "\(asset.symbol)\(totalAmount)"

        return WalletFormViewModel(layoutType: .accessory,
                                   title: "Total amount",
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
                                                  title: "Status",
                                                  details: "Pending",
                                                  icon: style.statusStyleContainer.pending.icon)
        viewModels.append(statusViewModel)

        let timeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: "Date and Time",
                                                details: dateFormatter.string(from: Date()))
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
        let viewModel = AccessoryViewModel(title: "Funds are being sent",
                                           action: "Done")
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
