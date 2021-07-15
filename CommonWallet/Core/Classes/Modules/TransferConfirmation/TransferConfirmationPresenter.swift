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
    let balanceDataProvider: SingleValueProvider<[BalanceData]>
    let metadataProvider: SingleValueProvider<TransferMetaData>
    let transferValidator: TransferValidating

    let logger: WalletLoggerProtocol?
    private var balances: [BalanceData]?
    private var metadata: TransferMetaData?

    init(view: WalletNewFormViewProtocol,
         coordinator: TransferConfirmationCoordinatorProtocol,
         service: WalletServiceProtocol,
         payload: ConfirmationPayload,
         eventCenter: WalletEventCenterProtocol,
         viewModelFactory: TransferConfirmationViewModelFactoryProtocol,
         balanceDataProvider: SingleValueProvider<[BalanceData]>,
         metadataProvider: SingleValueProvider<TransferMetaData>,
         transferValidator: TransferValidating,
         logger: WalletLoggerProtocol? = nil) {
        self.view = view
        self.coordinator = coordinator
        self.service = service
        self.payload = payload
        self.eventCenter = eventCenter
        self.viewModelFactory = viewModelFactory
        self.balanceDataProvider = balanceDataProvider
        self.metadataProvider = metadataProvider
        self.transferValidator = transferValidator
        self.logger = logger
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

    private func setupBalanceDataProvider() {
        let changesBlock = { [weak self] (changes: [DataProviderChange<[BalanceData]>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let items), .update(let items):
                    self?.balances = items
                default:
                    break
                }
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.logger?.error(error.localizedDescription)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        balanceDataProvider.addObserver(
            self,
            deliverOn: .main,
            executing: changesBlock,
            failing: failBlock,
            options: options
        )
    }

    private func setupMetadataProvider() {
        let changesBlock = { [weak self] (changes: [DataProviderChange<TransferMetaData>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let item), .update(let item):
                    self?.metadata = item
                default:
                    break
                }
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.logger?.error(error.localizedDescription)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        metadataProvider.addObserver(
            self,
            deliverOn: .main,
            executing: changesBlock,
            failing: failBlock,
            options: options
        )
    }

    private func validateTransfer(completion: (Result<Void, Error>) -> Void) {
        guard let balances = balances, let metadata = metadata else {
            // balances & metadata had been validated at previous screen
            // so we can try to proceed without extra validation
            completion(.success(()))
            return
        }

        do {
            let _ = try transferValidator.validate(
                info: payload.transferInfo,
                balances: balances,
                metadata: metadata
            )
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }

    private func performTransfer() {
        view?.didStartLoading()

        service.transfer(info: payload.transferInfo, runCompletionIn: .main) { [weak self] (optionalResult) in
            self?.view?.didStopLoading()

            if let result = optionalResult {
                self?.handleTransfer(result: result)
            }
        }
    }
}


extension TransferConfirmationPresenter: TransferConfirmationPresenterProtocol {
    
    func setup() {
        provideFormViewModels()
        provideAccessoryViewModel()
        setupBalanceDataProvider()
        setupMetadataProvider()
    }
    
    func performAction() {
        validateTransfer { [weak self] result in
            switch result {
            case .success:
                self?.performTransfer()
            case let .failure(error):
                guard let view = view else {
                    logger?.error(error.localizedDescription)
                    return
                }

                let locale = localizationManager?.selectedLocale
                if !view.attemptShowError(error, locale: locale) {
                    logger?.error(error.localizedDescription)
                }
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
