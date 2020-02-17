/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import RobinHood
import SoraFoundation


final class ConfirmationPresenter {
    weak var view: WalletFormViewProtocol?
    var coordinator: ConfirmationCoordinatorProtocol
    
    let payload: TransferPayload
    let service: WalletServiceProtocol
    let resolver: ResolverProtocol
    let accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol
    let eventCenter: WalletEventCenterProtocol
    let feeDisplaySettings: FeeDisplaySettingsProtocol

    var logger: WalletLoggerProtocol?

    init(view: WalletFormViewProtocol,
         coordinator: ConfirmationCoordinatorProtocol,
         service: WalletServiceProtocol,
         resolver: ResolverProtocol,
         payload: TransferPayload,
         accessoryViewModelFactory: ContactAccessoryViewModelFactoryProtocol,
         eventCenter: WalletEventCenterProtocol,
         feeDisplaySettings: FeeDisplaySettingsProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
        self.payload = payload
        self.resolver = resolver
        self.accessoryViewModelFactory = accessoryViewModelFactory
        self.eventCenter = eventCenter
        self.feeDisplaySettings = feeDisplaySettings
    }

    private func handleTransfer(result: Result<Void, Error>) {
        switch result {
        case .success:
            eventCenter.notify(with: TransferCompleteEvent(payload: payload))
            
            coordinator.showResult(payload: payload)
        case .failure:
            view?.showError(message: L10n.Transaction.Error.fail)
        }
    }

    private func prepareSingleAmountViewModel(for amount: String) -> WalletFormViewModel {
        return WalletFormViewModel(layoutType: .accessory, title: L10n.Amount.title,
                                   details: amount,
                                   icon: resolver.style.amountChangeStyle.decrease)
    }

    private func prepareAmountViewModels() -> [WalletFormViewModel] {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let asset = resolver.account.assets.first {
            $0.identifier.identifier() == payload.transferInfo.asset.identifier()
        }

        let amountFormatter = resolver.amountFormatterFactory.createDisplayFormatter(for: asset)

        let decimalAmount = payload.transferInfo.amount.decimalValue

        guard let formattedAmount = amountFormatter.value(for: locale)
                .string(from: decimalAmount as NSNumber) else {
                let amount = "\(payload.assetSymbol)\(payload.transferInfo.amount.stringValue)"
                let viewModel = prepareSingleAmountViewModel(for: amount)
                return [viewModel]

        }

        let amount = "\(payload.assetSymbol)\(formattedAmount)"

        guard
            let decimalFee = feeDisplaySettings.displayStrategy
                .decimalValue(from: payload.transferInfo.fee?.decimalValue),
            let formattedFee = amountFormatter.value(for: locale)
                .string(from: decimalFee as NSNumber) else {
                let viewModel = prepareSingleAmountViewModel(for: amount)
                return [viewModel]
        }

        let totalAmountDecimal = decimalAmount + decimalFee

        let amountViewModel = WalletFormViewModel(layoutType: .accessory,
                                                  title: L10n.Amount.send,
                                                  details: amount)

        let fee = "\(payload.assetSymbol)\(formattedFee)"

        let feeTitle = feeDisplaySettings.displayName.value(for: locale)

        let feeViewModel = WalletFormViewModel(layoutType: .accessory,
                                               title: feeTitle,
                                               details: fee)

        var viewModels = [amountViewModel, feeViewModel]

        if let formattedTotalAmount = amountFormatter.value(for: locale)
            .string(from: totalAmountDecimal as NSNumber) {
            let totalAmount = "\(payload.assetSymbol)\(formattedTotalAmount)"
            let totalAmountViewModel = WalletFormViewModel(layoutType: .accessory,
                                                           title: L10n.Amount.total,
                                                           details: totalAmount,
                                                           icon: resolver.style.amountChangeStyle.decrease)
            viewModels.append(totalAmountViewModel)
        }

        return viewModels
    }

    func provideMainViewModels() {
        var viewModels: [WalletFormViewModel] = []

        viewModels.append(WalletFormViewModel(layoutType: .accessory,
                                              title: L10n.Confirmation.hint,
                                              details: nil))

        let amountViewModels = prepareAmountViewModels()

        viewModels.append(contentsOf: amountViewModels)

        if !payload.transferInfo.details.isEmpty {
            viewModels.append(WalletFormViewModel(layoutType: .details,
                                                  title: L10n.Common.description,
                                                  details: payload.transferInfo.details))
        }

        view?.didReceive(viewModels: viewModels)
    }

    func provideAccessoryViewModel() {
        let viewModel = accessoryViewModelFactory.createViewModel(from: payload.receiverName,
                                                                  fullName: payload.receiverName,
                                                                  action: L10n.Common.send)
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

extension ConfirmationPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            provideMainViewModels()
            provideAccessoryViewModel()
        }
    }
}
