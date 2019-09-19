/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood


final class TransferResultPresenter {

    weak var view: WalletFormViewProtocol?
    var coordinator: TransferResultCoordinatorProtocol

    private(set) var transferPayload: TransferPayload
    private(set) var resolver: ResolverProtocol

    init(view: WalletFormViewProtocol,
         coordinator: TransferResultCoordinatorProtocol,
         payload: TransferPayload,
         resolver: ResolverProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.resolver = resolver
        self.transferPayload = payload
    }

    private func prepareSingleAmountViewModel(for amount: String) -> WalletFormViewModel {
        return WalletFormViewModel(layoutType: .accessory, title: "Amount",
                                   details: amount,
                                   icon: resolver.style.amountChangeStyle.decrease)
    }

    private func prepareAmountViewModels() -> [WalletFormViewModel] {
        guard
            let decimalAmount = Decimal(string: transferPayload.transferInfo.amount.value),
            let formattedAmount = resolver.amountFormatter.string(from: decimalAmount as NSNumber) else {
                let amount = "\(transferPayload.assetSymbol)\(transferPayload.transferInfo.amount.value)"

                let viewModel = prepareSingleAmountViewModel(for: amount)
                return [viewModel]

        }

        let amount = "\(transferPayload.assetSymbol)\(formattedAmount)"

        guard
            let feeString = transferPayload.transferInfo.fee?.value,
            let decimalFee = Decimal(string: feeString),
            let formattedFee = resolver.amountFormatter.string(from: decimalFee as NSNumber) else {
                let viewModel = prepareSingleAmountViewModel(for: amount)
                return [viewModel]
        }

        let totalAmountDecimal = decimalAmount + decimalFee

        let amountViewModel = WalletFormViewModel(layoutType: .accessory,
                                                  title: "Amount to send",
                                                  details: amount)

        let fee = "\(transferPayload.assetSymbol)\(formattedFee)"

        let feeViewModel = WalletFormViewModel(layoutType: .accessory,
                                               title: "Transaction fee",
                                               details: fee)

        var viewModels = [amountViewModel, feeViewModel]

        if let formattedTotalAmount = resolver.amountFormatter.string(from: totalAmountDecimal as NSNumber) {
            let totalAmount = "\(transferPayload.assetSymbol)\(formattedTotalAmount)"
            let totalAmountViewModel = WalletFormViewModel(layoutType: .accessory,
                                                           title: "Total amount",
                                                           details: totalAmount,
                                                           icon: resolver.style.amountChangeStyle.decrease)
            viewModels.append(totalAmountViewModel)
        }

        return viewModels
    }

    private func provideMainViewModels() {
        let statusViewModel = WalletFormViewModel(layoutType: .accessory,
                                                  title: "Status",
                                                  details: "Pending",
                                                  icon: resolver.style.statusStyleContainer.pending.icon)
        let timeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: "Date and Time",
                                                details: resolver.statusDateFormatter.string(from: Date()))
        let receiverViewModel = WalletFormViewModel(layoutType: .accessory,
                                                    title: "Recipient",
                                                    details: transferPayload.receiverName)

        var viewModels = [statusViewModel, timeViewModel, receiverViewModel]

        let amountViewModels = prepareAmountViewModels()
        viewModels.append(contentsOf: amountViewModels)

        if !transferPayload.transferInfo.details.isEmpty {
            let descriptionViewModel = WalletFormViewModel(layoutType: .details,
                                                           title: "Description",
                                                           details: transferPayload.transferInfo.details)

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


extension TransferResultPresenter: TransferResultPresenterProtocol {
    func setup() {
        provideMainViewModels()
        provideAccessoryViewModel()
    }

    func performAction() {
        coordinator.dismiss()
    }
}
