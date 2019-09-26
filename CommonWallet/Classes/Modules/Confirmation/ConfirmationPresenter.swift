/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood


final class ConfirmationPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: ConfirmationCoordinatorProtocol
    
    let payload: TransferPayload
    let service: WalletServiceProtocol
    let resolver: ResolverProtocol
    let accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol
    let eventCenter: WalletEventCenterProtocol

    var logger: WalletLoggerProtocol?

    init(view: WalletFormViewProtocol,
         coordinator: ConfirmationCoordinatorProtocol,
         service: WalletServiceProtocol,
         resolver: ResolverProtocol,
         payload: TransferPayload,
         accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol,
         eventCenter: WalletEventCenterProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
        self.payload = payload
        self.resolver = resolver
        self.accessoryViewModelFactory = accessoryViewModelFactory
        self.eventCenter = eventCenter
    }

    private func handleTransfer(result: OperationResult<Bool>) {
        switch result {
        case .success:
            eventCenter.notify(with: TransferCompleteEvent(payload: payload))
            
            coordinator.showResult(payload: payload)
        case .error:
            view?.showError(message: "Transaction failed. Please, try again later.")
        }
    }

    private func prepareFeeViewModel() -> WalletFormViewModel? {
        guard
            let feeString = payload.transferInfo.fee?.value,
            let feeDecimal = Decimal(string: feeString),
            let formattedAmount = resolver.amountFormatter.string(from: feeDecimal as NSNumber) else {
            return nil
        }

        let details = "\(payload.assetSymbol)\(formattedAmount)"

        return WalletFormViewModel(layoutType: .accessory,
                                   title: "Transaction Fee",
                                   details: details)
    }

    private func prepareSingleAmountViewModel(for amount: String) -> WalletFormViewModel {
        return WalletFormViewModel(layoutType: .accessory, title: "Amount",
                                   details: amount,
                                   icon: resolver.style.amountChangeStyle.decrease)
    }

    private func prepareAmountViewModels() -> [WalletFormViewModel] {
        guard
            let decimalAmount = Decimal(string: payload.transferInfo.amount.value),
            let formattedAmount = resolver.amountFormatter.string(from: decimalAmount as NSNumber) else {
                let amount = "\(payload.assetSymbol)\(payload.transferInfo.amount.value)"

                let viewModel = prepareSingleAmountViewModel(for: amount)
                return [viewModel]

        }

        let amount = "\(payload.assetSymbol)\(formattedAmount)"

        guard
            let feeString = payload.transferInfo.fee?.value,
            let decimalFee = Decimal(string: feeString),
            let formattedFee = resolver.amountFormatter.string(from: decimalFee as NSNumber) else {
                let viewModel = prepareSingleAmountViewModel(for: amount)
                return [viewModel]
        }

        let totalAmountDecimal = decimalAmount + decimalFee

        let amountViewModel = WalletFormViewModel(layoutType: .accessory,
                                                  title: "Amount to send",
                                                  details: amount)

        let fee = "\(payload.assetSymbol)\(formattedFee)"

        let feeViewModel = WalletFormViewModel(layoutType: .accessory,
                                               title: "Transaction fee",
                                               details: fee)

        var viewModels = [amountViewModel, feeViewModel]

        if let formattedTotalAmount = resolver.amountFormatter.string(from: totalAmountDecimal as NSNumber) {
            let totalAmount = "\(payload.assetSymbol)\(formattedTotalAmount)"
            let totalAmountViewModel = WalletFormViewModel(layoutType: .accessory,
                                                           title: "Total amount",
                                                           details: totalAmount,
                                                           icon: resolver.style.amountChangeStyle.decrease)
            viewModels.append(totalAmountViewModel)
        }

        return viewModels
    }

    func provideMainViewModels() {
        var viewModels: [WalletFormViewModel] = []

        viewModels.append(WalletFormViewModel(layoutType: .accessory,
                                              title: "Please check and confirm details",
                                              details: nil))

        let amountViewModels = prepareAmountViewModels()

        viewModels.append(contentsOf: amountViewModels)

        if !payload.transferInfo.details.isEmpty {
            viewModels.append(WalletFormViewModel(layoutType: .details,
                                                  title: "Description",
                                                  details: payload.transferInfo.details))
        }

        view?.didReceive(viewModels: viewModels)
    }

    func provideAccessoryViewModel() {
        let viewModel = accessoryViewModelFactory.createViewModel(from: payload.receiverName,
                                                                  fullName: payload.receiverName,
                                                                  action: "Next")
        view?.didReceive(accessoryViewModel: viewModel)
    }
}


extension ConfirmationPresenter: ConfirmationPresenterProtocol {
    
    func setup() {
        provideMainViewModels()
        provideAccessoryViewModel()
    }
    
    func performAction() {
        view?.didStartLoading()

        service.transfer(info: payload.transferInfo, runCompletionIn: .main) { [weak self] (optionalResult) in
            self?.view?.didStopLoading()

            if let result = optionalResult {
                self?.handleTransfer(result: result)
            }
        }
    }
}
