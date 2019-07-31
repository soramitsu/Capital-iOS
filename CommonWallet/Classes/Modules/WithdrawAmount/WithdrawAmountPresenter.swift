/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import RobinHood

final class WithdrawAmountPresenter {
    enum InputState {
        case initial
        case requestingFee
        case checkingAmount
    }

    weak var view: WithdrawAmountViewProtocol?
    var coordinator: WithdrawAmountCoordinatorProtocol
    var logger: WalletLoggerProtocol?

    private var assetSelectionViewModel: AssetSelectionViewModel
    private var amountInputViewModel: AmountInputViewModel
    private var descriptionInputViewModel: DescriptionInputViewModel
    private var feeViewModel: WithdrawFeeViewModel

    private var balances: [BalanceData]?
    private var metadata: WithdrawalData?
    private let dataProviderFactory: DataProviderFactoryProtocol
    private let balanceDataProvider: SingleValueProvider<[BalanceData], CDCWSingleValue>
    private var metaDataProvider: SingleValueProvider<WithdrawalData, CDCWSingleValue>
    private let assetTitleFactory: AssetSelectionFactoryProtocol
    private let withdrawViewModelFactory: WithdrawAmountViewModelFactoryProtocol
    private let assets: [WalletAsset]

    private(set) var payload: WithdrawPayload

    private var state: InputState = .initial

    init(view: WithdrawAmountViewProtocol,
         coordinator: WithdrawAmountCoordinatorProtocol,
         payload: WithdrawPayload,
         assets: [WalletAsset],
         dataProviderFactory: DataProviderFactoryProtocol,
         withdrawViewModelFactory: WithdrawAmountViewModelFactoryProtocol,
         assetTitleFactory: AssetSelectionFactoryProtocol) throws {
        self.view = view
        self.coordinator = coordinator
        self.payload = payload
        self.assets = assets
        self.balanceDataProvider = try dataProviderFactory.createBalanceDataProvider()
        self.metaDataProvider = try dataProviderFactory
            .createWithdrawMetadataProvider(for: payload.asset.identifier, option: payload.option.identifier)
        self.dataProviderFactory = dataProviderFactory
        self.withdrawViewModelFactory = withdrawViewModelFactory
        self.assetTitleFactory = assetTitleFactory

        let title = assetTitleFactory.createTitle(for: payload.asset, balanceData: nil)
        assetSelectionViewModel = AssetSelectionViewModel(assetId: payload.asset.identifier,
                                                          title: title,
                                                          symbol: payload.asset.symbol)
        assetSelectionViewModel.canSelect = assets.count > 1

        amountInputViewModel = withdrawViewModelFactory.createAmountViewModel()

        let feeTitle = withdrawViewModelFactory.createFeeTitle(for: payload.asset, amount: nil)
        feeViewModel = WithdrawFeeViewModel(title: feeTitle)
        feeViewModel.isLoading = true

        descriptionInputViewModel = withdrawViewModelFactory.createDescriptionViewModel()
    }

    private func updateFeeViewModel(for asset: WalletAsset) {
        guard
            let balanceData = balances?.first(where: { $0.identifier == asset.identifier.identifier() }),
            let balance = Decimal(string: balanceData.balance),
            let feeRateString = metadata?.feeRate,
            let feeRate = Decimal(string: feeRateString) else {
                feeViewModel.title = withdrawViewModelFactory.createFeeTitle(for: asset, amount: nil)
                feeViewModel.isLoading = true
                return
        }

        let amount = balance * feeRate
        feeViewModel.title = withdrawViewModelFactory.createFeeTitle(for: asset, amount: amount)
        feeViewModel.isLoading = false
    }

    private func updateAccessoryViewModel(for asset: WalletAsset) {
        guard
            let balanceData = balances?.first(where: { $0.identifier == asset.identifier.identifier() }),
            let balance = Decimal(string: balanceData.balance),
            let feeRateString = metadata?.feeRate,
            let feeRate = Decimal(string: feeRateString),
            let amount = amountInputViewModel.decimalAmount else {
                let accessoryViewModel = withdrawViewModelFactory.createAccessoryViewModel(for: asset, totalAmount: nil)
                view?.didChange(accessoryViewModel: accessoryViewModel)
                return
        }

        let fee = balance * feeRate
        let totalAmount = amount + fee

        let accessoryViewModel = withdrawViewModelFactory.createAccessoryViewModel(for: asset, totalAmount: totalAmount)
        view?.didChange(accessoryViewModel: accessoryViewModel)
    }

    private func updateSelectedAssetViewModel(for newAsset: WalletAsset) {
        assetSelectionViewModel.isSelecting = false

        assetSelectionViewModel.assetId = newAsset.identifier

        let balanceData = balances?.first { $0.identifier == newAsset.identifier.identifier() }
        let title = assetTitleFactory.createTitle(for: newAsset, balanceData: balanceData)

        assetSelectionViewModel.title = title

        assetSelectionViewModel.symbol = newAsset.symbol
    }

    private func handleBalanceResponse(with optionalBalances: [BalanceData]?) {
        defer {
            state = .initial
        }

        if let balances = optionalBalances {
            self.balances = balances
        }

        guard let balances = self.balances else {
            return
        }

        guard
            let assetId = assetSelectionViewModel.assetId,
            let asset = assets.first(where: { $0.identifier.identifier() == assetId.identifier() }),
            let balanceData = balances.first(where: { $0.identifier == assetId.identifier()}) else {

                if case .checkingAmount = state {
                    let message = "Sorry, we couldn't find asset information you want to send. Please, try again later."
                    view?.showError(message: message)
                }

                return
        }

        assetSelectionViewModel.title = assetTitleFactory.createTitle(for: asset, balanceData: balanceData)

        if case .checkingAmount = state {
            view?.didStopLoading()

            completeConfirmation()
        }
    }

    private func handleBalanceResponse(with error: Error) {
        if case .checkingAmount = state {
            view?.didStopLoading()

            state = .initial

            let message = "Sorry, balance checking request failed. Please, try again later."
            view?.showError(message: message)
        }
    }

    private func setupBalanceDataProvider() {
        let changesBlock = { [weak self] (changes: [DataProviderChange<[BalanceData]>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let items), .update(let items):
                    self?.handleBalanceResponse(with: items)
                default:
                    break
                }
            } else {
                self?.handleBalanceResponse(with: nil)
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.handleBalanceResponse(with: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        balanceDataProvider.addCacheObserver(self,
                                             deliverOn: .main,
                                             executing: changesBlock,
                                             failing: failBlock,
                                             options: options)
    }

    private func updateMetadataProvider(for asset: WalletAsset) throws {
        let metaDataProvider = try dataProviderFactory.createWithdrawMetadataProvider(for: asset.identifier,
                                                                                      option: payload.option.identifier)
        self.metaDataProvider = metaDataProvider

        setupMetadata(provider: metaDataProvider)
    }

    private func handleWithdraw(metadata: WithdrawalData?) {
        self.metadata = metadata

        updateFeeViewModel(for: payload.asset)
        updateAccessoryViewModel(for: payload.asset)
    }

    private func handleWithdrawMetadata(error: Error) {

    }

    private func setupMetadata(provider: SingleValueProvider<WithdrawalData, CDCWSingleValue>) {
        let changesBlock = { [weak self] (changes: [DataProviderChange<WithdrawalData>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let item), .update(let item):
                    self?.handleWithdraw(metadata: item)
                default:
                    break
                }
            } else {
                self?.handleBalanceResponse(with: nil)
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.handleWithdrawMetadata(error: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        provider.addCacheObserver(self,
                                  deliverOn: .main,
                                  executing: changesBlock,
                                  failing: failBlock,
                                  options: options)
    }

    private func completeConfirmation() {

    }
}

extension WithdrawAmountPresenter: WithdrawAmountPresenterProtocol {
    func setup() {
        amountInputViewModel.observable.add(observer: self)

        view?.set(title: withdrawViewModelFactory.createWithdrawTitle())
        view?.set(assetViewModel: assetSelectionViewModel)
        view?.set(amountViewModel: amountInputViewModel)
        view?.set(feeViewModel: feeViewModel)
        view?.set(descriptionViewModel: descriptionInputViewModel)

        updateAccessoryViewModel(for: payload.asset)

        setupBalanceDataProvider()
        setupMetadata(provider: metaDataProvider)
    }

    func confirm() {}

    func presentAssetSelection() {
        var initialIndex = 0

        if let assetId = assetSelectionViewModel.assetId {
            initialIndex = assets.firstIndex(where: { $0.identifier.identifier() == assetId.identifier() }) ?? 0
        }

        let titles: [String] = assets.map { (asset) in
            let balanceData = balances?.first { $0.identifier == asset.identifier.identifier() }
            return assetTitleFactory.createTitle(for: asset, balanceData: balanceData)
        }

        coordinator.presentPicker(for: titles, initialIndex: initialIndex, delegate: self)

        assetSelectionViewModel.isSelecting = true
    }
}

extension WithdrawAmountPresenter: ModalPickerViewDelegate {
    func modalPickerViewDidCancel(_ view: ModalPickerView) {
        assetSelectionViewModel.isSelecting = false
    }

    func modalPickerView(_ view: ModalPickerView, didSelectRowAt index: Int, in context: AnyObject?) {
        do {
            let newAsset = assets[index]

            try updateMetadataProvider(for: newAsset)

            payload.asset = newAsset

            updateSelectedAssetViewModel(for: newAsset)
            updateFeeViewModel(for: newAsset)
            updateAccessoryViewModel(for: newAsset)
        } catch {
            logger?.error("Unexpected error when new asset selected \(error)")
        }
    }
}

extension WithdrawAmountPresenter: AmountInputViewModelObserver {
    func amountInputDidChange() {
        updateFeeViewModel(for: payload.asset)
        updateAccessoryViewModel(for: payload.asset)
    }
}
