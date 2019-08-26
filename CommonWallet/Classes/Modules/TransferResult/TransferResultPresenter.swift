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

    private func provideMainViewModels() {
        let statusViewModel = WalletFormViewModel(layoutType: .accessory,
                                                  title: "Status",
                                                  details: "Pending",
                                                  icon: resolver.style.statusStyleContainer.pending.icon)
        let timeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: "Date and Time",
                                                details: resolver.statusDateFormatter.string(from: Date()))
        let typeViewModel = WalletFormViewModel(layoutType: .accessory,
                                                title: "Type",
                                                details: "Send")
        let receiverViewModel = WalletFormViewModel(layoutType: .accessory,
                                                    title: "Recipient",
                                                    details: transferPayload.receiverName)

        var viewModels = [statusViewModel, timeViewModel, typeViewModel, receiverViewModel]

        if let amount = Decimal(string: transferPayload.transferInfo.amount.value),
            let amountString = resolver.amountFormatter.string(from: amount as NSNumber) {

            let details = transferPayload.assetSymbol + amountString
            let amountViewModel = WalletFormViewModel(layoutType: .accessory,
                                                      title: "Amount",
                                                      details: details,
                                                      icon: resolver.style.amountChangeStyle.decrease)

            viewModels.append(amountViewModel)
        }

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
