/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import RobinHood
import IrohaCommunication

struct WithdrawCheckingState: OptionSet {
    typealias RawValue = UInt8

    static let waiting = WithdrawCheckingState(rawValue: 0)
    static let requestedAmount = WithdrawCheckingState(rawValue: 1)
    static let requestedFee = WithdrawCheckingState(rawValue: 2)
    static let completed = WithdrawCheckingState.requestedAmount.union(.requestedFee)

    var rawValue: WithdrawCheckingState.RawValue

    init(rawValue: WithdrawCheckingState.RawValue) {
        self.rawValue = rawValue
    }
}

final class WithdrawAmountPresenter {

    weak var view: WithdrawAmountViewProtocol?
    var coordinator: WithdrawAmountCoordinatorProtocol
    var logger: WalletLoggerProtocol?

    private var assetSelectionViewModel: AssetSelectionViewModel
    private var amountInputViewModel: AmountInputViewModel
    private var descriptionInputViewModel: DescriptionInputViewModel
    private var feeViewModel: FeeViewModel

    private var balances: [BalanceData]?
    private var metadata: WithdrawMetaData?
    private let dataProviderFactory: DataProviderFactoryProtocol
    private let balanceDataProvider: SingleValueProvider<[BalanceData], CDCWSingleValue>
    private var metaDataProvider: SingleValueProvider<WithdrawMetaData, CDCWSingleValue>
    private let assetTitleFactory: AssetSelectionFactoryProtocol
    private let withdrawViewModelFactory: WithdrawAmountViewModelFactoryProtocol
    private let feeCalculationFactory: FeeCalculationFactoryProtocol
    private let assets: [WalletAsset]

    private(set) var selectedAsset: WalletAsset
    private(set) var selectedOption: WalletWithdrawOption

    private(set) var confirmationState: WithdrawCheckingState?

    init(view: WithdrawAmountViewProtocol,
         coordinator: WithdrawAmountCoordinatorProtocol,
         assets: [WalletAsset],
         selectedAsset: WalletAsset,
         selectedOption: WalletWithdrawOption,
         dataProviderFactory: DataProviderFactoryProtocol,
         feeCalculationFactory: FeeCalculationFactoryProtocol,
         withdrawViewModelFactory: WithdrawAmountViewModelFactoryProtocol,
         assetTitleFactory: AssetSelectionFactoryProtocol) throws {

        self.view = view
        self.coordinator = coordinator
        self.selectedAsset = selectedAsset
        self.selectedOption = selectedOption
        self.assets = assets
        self.balanceDataProvider = try dataProviderFactory.createBalanceDataProvider()
        self.metaDataProvider = try dataProviderFactory
            .createWithdrawMetadataProvider(for: selectedAsset.identifier, option: selectedOption.identifier)
        self.dataProviderFactory = dataProviderFactory
        self.withdrawViewModelFactory = withdrawViewModelFactory
        self.feeCalculationFactory = feeCalculationFactory
        self.assetTitleFactory = assetTitleFactory

        descriptionInputViewModel = try withdrawViewModelFactory.createDescriptionViewModel()

        let title = assetTitleFactory.createTitle(for: selectedAsset, balanceData: nil)
        assetSelectionViewModel = AssetSelectionViewModel(assetId: selectedAsset.identifier,
                                                          title: title,
                                                          symbol: selectedAsset.symbol)
        assetSelectionViewModel.canSelect = assets.count > 1

        amountInputViewModel = withdrawViewModelFactory.createAmountViewModel()

        let feeTitle = withdrawViewModelFactory.createFeeTitle(for: selectedAsset, amount: nil)
        feeViewModel = FeeViewModel(title: feeTitle)
        feeViewModel.isLoading = true
    }

    private func updateFeeViewModel(for asset: WalletAsset) {
        guard
            let amount = amountInputViewModel.decimalAmount,
            let feeRateString = metadata?.feeRate,
            let feeRate = Decimal(string: feeRateString) else {
                feeViewModel.title = withdrawViewModelFactory.createFeeTitle(for: asset, amount: nil)
                feeViewModel.isLoading = true
                return
        }

        let fee = amount * feeRate
        feeViewModel.title = withdrawViewModelFactory.createFeeTitle(for: asset, amount: fee)
        feeViewModel.isLoading = false
    }

    private func updateAccessoryViewModel(for asset: WalletAsset) {
        guard
            let feeRate = metadata?.feeRateDecimal,
            let amount = amountInputViewModel.decimalAmount else {
                let accessoryViewModel = withdrawViewModelFactory.createAccessoryViewModel(for: asset, totalAmount: nil)
                view?.didChange(accessoryViewModel: accessoryViewModel)
                return
        }

        let totalAmount = (1 + feeRate) * amount

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

                if confirmationState != nil {
                   confirmationState = nil

                    let message = "Sorry, we couldn't find asset information you want to send. Please, try again later."
                    view?.showError(message: message)
                }

                return
        }

        assetSelectionViewModel.title = assetTitleFactory.createTitle(for: asset, balanceData: balanceData)

        if let currentState = confirmationState {
            confirmationState = currentState.union(.requestedAmount)
            completeConfirmation()
        }
    }

    private func handleBalanceResponse(with error: Error) {
        if confirmationState != nil {
            confirmationState = nil

            view?.didStopLoading()

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

    private func handleWithdraw(metadata: WithdrawMetaData?) {
        if metadata != nil {
            self.metadata = metadata
        }

        updateFeeViewModel(for: selectedAsset)
        updateAccessoryViewModel(for: selectedAsset)

        if let currentState = confirmationState {
            confirmationState = currentState.union(.requestedFee)
            completeConfirmation()
        }
    }

    private func handleWithdrawMetadata(error: Error) {
        if confirmationState != nil {
            view?.didStopLoading()

            confirmationState = nil
        }

        let message = "Sorry, we coudn't contact withdraw provider. Please, try again later."
        view?.showError(message: message)
    }

    private func updateMetadataProvider(for asset: WalletAsset) throws {
        let metaDataProvider = try dataProviderFactory.createWithdrawMetadataProvider(for: asset.identifier,
                                                                                      option: selectedOption.identifier)
        self.metaDataProvider = metaDataProvider

        setupMetadata(provider: metaDataProvider)
    }

    private func setupMetadata(provider: SingleValueProvider<WithdrawMetaData, CDCWSingleValue>) {
        let changesBlock = { [weak self] (changes: [DataProviderChange<WithdrawMetaData>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let item), .update(let item):
                    self?.handleWithdraw(metadata: item)
                default:
                    break
                }
            } else {
                self?.handleWithdraw(metadata: nil)
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

    private func prepareWithdrawInfo() -> WithdrawInfo? {
        do {
            guard
                let sendingAmount = amountInputViewModel.decimalAmount,
                let metadata = metadata,
                let feeRate = metadata.feeRateDecimal else {
                    logger?.error("Either amount or metadata missing to complete withdraw")
                    return nil
            }

            let feeCalculator = try feeCalculationFactory.createStrategy(for: metadata.feeType,
                                                                         assetId: selectedAsset.identifier,
                                                                         parameters: [feeRate])
            let fee = try feeCalculator.calculate(for: sendingAmount)
            let totalAmount = sendingAmount + fee

            guard
                let balanceData = balances?.first(where: { $0.identifier == selectedAsset.identifier.identifier()}),
                let currentAmount =  Decimal(string: balanceData.balance),
                totalAmount <= currentAmount else {
                    let message = "Sorry, you don't have enough funds to transfer specified amount."
                    view?.showError(message: message)
                    return nil
            }

            let destinationAccountId = try IRAccountIdFactory.account(withIdentifier: metadata.providerAccountId)

            var feeAccountId: IRAccountId?
            var feeAmount: IRAmount?

            if fee > 0.0 {
                if let accountIdString = metadata.feeAccountId {
                    feeAccountId = try IRAccountIdFactory.account(withIdentifier: accountIdString)
                }

                feeAmount = try IRAmountFactory.amount(from: (fee as NSNumber).stringValue)
            }

            let amount = try IRAmountFactory.amount(from: (sendingAmount as NSNumber).stringValue)

            let info = WithdrawInfo(destinationAccountId: destinationAccountId,
                                    assetId: selectedAsset.identifier,
                                    amount: amount,
                                    details: descriptionInputViewModel.text,
                                    feeAccountId: feeAccountId,
                                    fee: feeAmount)

            return info
        } catch {
            logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }

    private func completeConfirmation() {
        guard confirmationState == .completed else {
            return
        }

        confirmationState = nil

        view?.didStopLoading()

        if let info = prepareWithdrawInfo() {
            coordinator.confirm(with: info, asset: selectedAsset, option: selectedOption)
        }
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

        updateAccessoryViewModel(for: selectedAsset)

        setupBalanceDataProvider()
        setupMetadata(provider: metaDataProvider)
    }

    func confirm() {
        guard confirmationState == nil else {
            return
        }

        view?.didStartLoading()

        confirmationState = .waiting

        balanceDataProvider.refreshCache()
        metaDataProvider.refreshCache()
    }

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

            if newAsset.identifier.identifier() != selectedAsset.identifier.identifier() {
                self.metadata = nil

                try updateMetadataProvider(for: newAsset)

                self.selectedAsset = newAsset

                updateSelectedAssetViewModel(for: newAsset)
                updateFeeViewModel(for: newAsset)
                updateAccessoryViewModel(for: newAsset)
            }
        } catch {
            logger?.error("Unexpected error when new asset selected \(error)")
        }
    }
}

extension WithdrawAmountPresenter: AmountInputViewModelObserver {
    func amountInputDidChange() {
        updateFeeViewModel(for: selectedAsset)
        updateAccessoryViewModel(for: selectedAsset)
    }
}
