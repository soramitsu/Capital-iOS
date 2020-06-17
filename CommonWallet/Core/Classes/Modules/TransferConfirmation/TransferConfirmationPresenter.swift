/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import SoraFoundation


final class TransferConfirmationPresenter {
    weak var view: WalletNewFormViewProtocol?
    var coordinator: TransferConfirmationCoordinatorProtocol
    
    let payload: ConfirmationPayload
    let service: WalletServiceProtocol
    let viewModelFactory: TransferConfirmationViewModelFactoryProtocol
    let eventCenter: WalletEventCenterProtocol

    var logger: WalletLoggerProtocol?

    init(view: WalletNewFormViewProtocol,
         coordinator: TransferConfirmationCoordinatorProtocol,
         service: WalletServiceProtocol,
         payload: ConfirmationPayload,
         eventCenter: WalletEventCenterProtocol,
         viewModelFactory: TransferConfirmationViewModelFactoryProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
        self.payload = payload
        self.eventCenter = eventCenter
        self.viewModelFactory = viewModelFactory
    }

    private func handleTransfer(result: Result<Data, Error>) {
        switch result {
        case .success:
            eventCenter.notify(with: TransferCompleteEvent(payload: payload))
            
            coordinator.proceed(payload: payload)
        case .failure:
            view?.showError(message: L10n.Transaction.Error.fail)
        }
    }

    private func provideFormViewModels() {
        let locale = localizationManager?.selectedLocale ?? Locale.current
        let formViewModels = viewModelFactory.createViewModelsFromPayload(payload,
                                                                          locale: locale)
        view?.didReceive(viewModels: formViewModels)
    }

    private func provideAccessoryViewModel() {
        let locale = localizationManager?.selectedLocale ?? Locale.current
        let accessoryViewModel = viewModelFactory.createAccessoryViewModelFromPayload(payload,
                                                                                      locale: locale)
        view?.didReceive(accessoryViewModel: accessoryViewModel)
    }
}


extension TransferConfirmationPresenter: TransferConfirmationPresenterProtocol {
    
    func setup() {
        provideFormViewModels()
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

extension TransferConfirmationPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            provideFormViewModels()
            provideAccessoryViewModel()
        }
    }
}
