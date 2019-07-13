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

    var logger: WalletLoggerProtocol?

    init(view: AccountListViewProtocol,
         coordinator: AccountListCoordinatorProtocol,
         balanceDataProvider: SingleValueProvider<[BalanceData], CDCWSingleValue>,
         viewModelFactory: AccountModuleViewModelFactoryProtocol) {
        self.view = view
        self.coordinator = coordinator
        self.balanceDataProvider = balanceDataProvider
        self.viewModelFactory = viewModelFactory
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
    }

    func reload() {
        balanceDataProvider.refreshCache()
    }

    func viewDidAppear() {
        balanceDataProvider.refreshCache()
    }
}

extension AccountListPresenter: AccountModuleViewDelegate {
    func shouldToggleExpansion(from value: Bool, for viewModel: WalletViewModelProtocol) -> Bool {
        view?.set(expanded: !value, animated: true)
        return true
    }

    func didSelect(assetViewModel: AssetViewModelProtocol) {
        // TODO: CAP-68
    }

    func didRequestSend(for viewModel: ActionsViewModelProtocol) {
        coordinator.send()
    }

    func didRequestReceive(for viewModel: ActionsViewModelProtocol) {
        coordinator.receive()
    }
}
