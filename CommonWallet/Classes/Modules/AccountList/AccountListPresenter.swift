/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

final class AccountListPresenter {
    weak var view: AccountListViewProtocol?
    var coordinator: AccountListCoordinatorProtocol

    let balanceDataProvider: SingleValueProvider<[BalanceData], CDCWSingleValue>
    let viewModelFactory: AccountModuleViewModelFactoryProtocol
    let eventCenter: WalletEventCenterProtocol

    var logger: WalletLoggerProtocol?

    init(view: AccountListViewProtocol,
         coordinator: AccountListCoordinatorProtocol,
         balanceDataProvider: SingleValueProvider<[BalanceData], CDCWSingleValue>,
         viewModelFactory: AccountModuleViewModelFactoryProtocol,
         eventCenter: WalletEventCenterProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.balanceDataProvider = balanceDataProvider
        self.viewModelFactory = viewModelFactory
        self.eventCenter = eventCenter
    }

    private func updateView(with assets: [BalanceData]?) {
        do {
            if let assets = assets {
                let viewModel = try viewModelFactory.createViewModel(from: assets, delegate: self)

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
                    self?.updateView(with: items)
                default:
                    break
                }
            } else {
                self?.updateView(with: nil)
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.updateView(with: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        balanceDataProvider.addCacheObserver(self,
                                             deliverOn: .main,
                                             executing: changesBlock,
                                             failing: failBlock,
                                             options: options)
    }
}

extension AccountListPresenter: AccountListPresenterProtocol {
    func setup() {
        updateView(with: [])
        setupBalanceDataProvider()

        eventCenter.add(observer: self, dispatchIn: nil)
    }

    func reload() {
        balanceDataProvider.refreshCache()
    }

    func viewDidAppear() {
        balanceDataProvider.refreshCache()
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
        balanceDataProvider.refreshCache()
    }

    func processWithdrawComplete(event: WithdrawCompleteEvent) {
        balanceDataProvider.refreshCache()
    }

    func processTransactionsUpdate(event: TransactionsUpdateEvent) {
        balanceDataProvider.refreshCache()
    }
}
