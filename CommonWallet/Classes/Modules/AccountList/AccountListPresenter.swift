/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import SoraFoundation

final class AccountListPresenter {
    weak var view: AccountListViewProtocol?
    var coordinator: AccountListCoordinatorProtocol

    let balanceDataProvider: SingleValueProvider<[BalanceData]>
    let viewModelFactory: AccountModuleViewModelFactoryProtocol
    let eventCenter: WalletEventCenterProtocol

    var logger: WalletLoggerProtocol?

    private(set) var assets: [BalanceData]?

    init(view: AccountListViewProtocol,
         coordinator: AccountListCoordinatorProtocol,
         balanceDataProvider: SingleValueProvider<[BalanceData]>,
         viewModelFactory: AccountModuleViewModelFactoryProtocol,
         eventCenter: WalletEventCenterProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.balanceDataProvider = balanceDataProvider
        self.viewModelFactory = viewModelFactory
        self.eventCenter = eventCenter
    }

    private func updateView() {
        do {
            if let assets = assets {
                let locale = localizationManager?.selectedLocale ?? Locale.current
                let viewModel = try viewModelFactory.createViewModel(from: assets,
                                                                     delegate: self,
                                                                     locale: locale)

                view?.didLoad(viewModels: viewModel.models, collapsingRange: viewModel.collapsingRange)
            }

            view?.didCompleteReload()

        } catch {
            logger?.error("View model factory failed: \(error)")
        }
    }

    private func updateView(with error: Error) {
        logger?.debug("Balance data provider error: \(error)")

        view?.didCompleteReload()
    }

    private func setupBalanceDataProvider() {
        let changesBlock = { [weak self] (changes: [DataProviderChange<[BalanceData]>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let items), .update(let items):
                    self?.assets = items
                    self?.updateView()
                default:
                    break
                }
            } else {
                self?.view?.didCompleteReload()
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.updateView(with: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        balanceDataProvider.addObserver(self,
                                        deliverOn: .main,
                                        executing: changesBlock,
                                        failing: failBlock,
                                        options: options)
    }
}

extension AccountListPresenter: AccountListPresenterProtocol {
    func setup() {
        assets = []
        updateView()

        setupBalanceDataProvider()

        eventCenter.add(observer: self)
    }

    func reload() {
        balanceDataProvider.refresh()
    }

    func viewDidAppear() {
        balanceDataProvider.refresh()
    }
}

extension AccountListPresenter: ShowMoreViewModelDelegate {
    func shouldToggleExpansion(from value: Bool, for viewModel: WalletViewModelProtocol) -> Bool {
        view?.set(expanded: !value, animated: true)
        return true
    }
}

extension AccountListPresenter: WalletEventVisitorProtocol {
    func processTransferComplete(event: TransferCompleteEvent) {
        balanceDataProvider.refresh()
    }

    func processWithdrawComplete(event: WithdrawCompleteEvent) {
        balanceDataProvider.refresh()
    }

    func processAccountUpdate(event: AccountUpdateEvent) {
        balanceDataProvider.refresh()
    }
}

extension AccountListPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            updateView()
        }
    }
}
