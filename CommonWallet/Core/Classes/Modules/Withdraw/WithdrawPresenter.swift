/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import Foundation
import RobinHood
import SoraFoundation


struct WithdrawCheckingState: OptionSet {
    typealias RawValue = UInt8

    static let waiting: WithdrawCheckingState = []
    static let requestedAmount = WithdrawCheckingState(rawValue: 1)
    static let requestedFee = WithdrawCheckingState(rawValue: 2)
    static let completed = WithdrawCheckingState.requestedAmount.union(.requestedFee)

    var rawValue: WithdrawCheckingState.RawValue

    init(rawValue: WithdrawCheckingState.RawValue) {
        self.rawValue = rawValue
    }
}

final class WithdrawPresenter {

    weak var view: WithdrawViewProtocol?
    var coordinator: WithdrawCoordinatorProtocol
    var logger: WalletLoggerProtocol?

    private var amountInputViewModel: AmountInputViewModel
    private var descriptionInputViewModel: DescriptionInputViewModel

    private var balances: [BalanceData]?
    private var metadata: WithdrawMetaData?
    private let dataProviderFactory: DataProviderFactoryProtocol
    private let balanceDataProvider: SingleValueProvider<[BalanceData]>
    private var metaDataProvider: SingleValueProvider<WithdrawMetaData>
    private let assetSelectionFactory: AssetSelectionFactoryProtocol
    private let withdrawViewModelFactory: WithdrawAmountViewModelFactoryProtocol
    private let feeCalculationFactory: FeeCalculationFactoryProtocol
    private let assets: [WalletAsset]

    private(set) var selectedAsset: WalletAsset
    private(set) var selectedOption: WalletWithdrawOption

    private(set) var confirmationState: WithdrawCheckingState?

    init(view: WithdrawViewProtocol,
         coordinator: WithdrawCoordinatorProtocol,
         assets: [WalletAsset],
         selectedAsset: WalletAsset,
         selectedOption: WalletWithdrawOption,
         dataProviderFactory: DataProviderFactoryProtocol,
         feeCalculationFactory: FeeCalculationFactoryProtocol,
         withdrawViewModelFactory: WithdrawAmountViewModelFactoryProtocol,
         assetSelectionFactory: AssetSelectionFactoryProtocol,
         localizationManager: LocalizationManagerProtocol?) throws {

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
        self.assetSelectionFactory = assetSelectionFactory

        descriptionInputViewModel = try withdrawViewModelFactory.createDescriptionViewModel()

        let locale = localizationManager?.selectedLocale ?? Locale.current

        amountInputViewModel = withdrawViewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                              amount: nil,
                                                                              locale: locale)

        self.localizationManager = localizationManager
    }

    private func updateAmountInputViewModel() {
        let amount = amountInputViewModel.decimalAmount

        let locale = localizationManager?.selectedLocale ?? Locale.current

        amountInputViewModel.observable.remove(observer: self)

        amountInputViewModel = withdrawViewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                              amount: amount,
                                                                              locale: locale)

        amountInputViewModel.observable.add(observer: self)

        view?.set(amountViewModel: amountInputViewModel)
    }

    private func setupFeeViewModel(for asset: WalletAsset) {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        guard
            let amount = amountInputViewModel.decimalAmount,
            let metadata = metadata else {
                let viewModel = withdrawViewModelFactory.createFeeViewModel(for: asset,
                                                                        amount: nil,
                                                                        locale: locale)
                view?.set(feeViewModels: [viewModel])
                return
        }

        do {

            // TODO: move to multi fee variant when ui ready
            let feeResult = try calculateFeeResults(for: metadata, amount: amount).first

            let viewModel = withdrawViewModelFactory.createFeeViewModel(for: asset,
                                                                        amount: feeResult?.fee,
                                                                        locale: locale)
            view?.set(feeViewModels: [viewModel])
        } catch {
            let viewModel = withdrawViewModelFactory.createFeeViewModel(for: asset,
                                                                        amount: nil,
                                                                        locale: locale)
            view?.set(feeViewModels: [viewModel])
        }

    }

    private func updateDescriptionViewModel() {
        do {
            let text = descriptionInputViewModel.text
            descriptionInputViewModel = try withdrawViewModelFactory.createDescriptionViewModel()
            _ = descriptionInputViewModel.didReceiveReplacement(text,
                                                                for: NSRange(location: 0, length: 0))

            view?.set(descriptionViewModel: descriptionInputViewModel)
        } catch {
            logger?.error("Can't update description view model")
        }
    }

    private func updateAccessoryViewModel(for asset: WalletAsset) {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        guard
            let metadata = metadata,
            let amount = amountInputViewModel.decimalAmount else {
                let accessoryViewModel = withdrawViewModelFactory.createAccessoryViewModel(for: asset,
                                                                                           totalAmount: nil,
                                                                                           locale: locale)
                view?.set(accessoryViewModel: accessoryViewModel)
                return
        }

        let totalAmount: Decimal

        // TODO: move to multi fee variant when ui ready

        if let feeResult = try? calculateFeeResults(for: metadata, amount: amount).first {
            totalAmount = feeResult.total
        } else {
            totalAmount = amount
        }

        let accessoryViewModel = withdrawViewModelFactory.createAccessoryViewModel(for: asset,
                                                                                   totalAmount: totalAmount,
                                                                                   locale: locale)
        view?.set(accessoryViewModel: accessoryViewModel)
    }

    private func setupSelectedAssetViewModel(isSelecting: Bool) {
        let locale = localizationManager?.selectedLocale ?? Locale.current
        let balanceData = balances?.first { $0.identifier == selectedAsset.identifier }

        let viewModel = assetSelectionFactory.createViewModel(for: selectedAsset,
                                                              balanceData: balanceData,
                                                              locale: locale,
                                                              isSelecting: isSelecting,
                                                              canSelect: assets.count > 0)

        view?.set(assetViewModel: viewModel)
    }

    private func handleBalanceResponse(with optionalBalances: [BalanceData]?) {
        if let balances = optionalBalances {
            self.balances = balances
        }

        guard let balances = self.balances else {
            return
        }

        guard balances.first(where: { $0.identifier == selectedAsset.identifier}) != nil else {

                if confirmationState != nil {
                   confirmationState = nil

                    view?.showError(message: L10n.Withdraw.Error.noAsset)
                }

                return
        }

        setupSelectedAssetViewModel(isSelecting: false)

        if let currentState = confirmationState {
            confirmationState = currentState.union(.requestedAmount)
            completeConfirmation()
        }
    }

    private func handleBalanceResponse(with error: Error) {
        if confirmationState != nil {
            confirmationState = nil

            view?.didStopLoading()

            view?.showError(message: L10n.Withdraw.Error.balance)
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
        balanceDataProvider.addObserver(self,
                                        deliverOn: .main,
                                        executing: changesBlock,
                                        failing: failBlock,
                                        options: options)
    }

    private func handleWithdraw(metadata: WithdrawMetaData?) {
        if metadata != nil {
            self.metadata = metadata
        }

        setupFeeViewModel(for: selectedAsset)
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

        view?.showError(message: L10n.Withdraw.Error.connection)
    }

    private func updateMetadataProvider(for asset: WalletAsset) throws {
        let metaDataProvider = try dataProviderFactory.createWithdrawMetadataProvider(for: asset.identifier,
                                                                                      option: selectedOption.identifier)
        self.metaDataProvider = metaDataProvider

        setupMetadata(provider: metaDataProvider)
    }

    private func setupMetadata(provider: SingleValueProvider<WithdrawMetaData>) {
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
        provider.addObserver(self,
                             deliverOn: .main,
                             executing: changesBlock,
                             failing: failBlock,
                             options: options)
    }

    private func prepareWithdrawInfo() -> WithdrawInfo? {
        do {
            guard
                let inputAmount = amountInputViewModel.decimalAmount,
                let metadata = metadata else {
                    logger?.error("Either amount or metadata missing to complete withdraw")
                    return nil
            }

            guard validateAndReportLimitConstraints(for: inputAmount) else {
                return nil
            }

            var fees: [Fee] = []
            let sendingAmount: Decimal
            let totalAmount: Decimal

            // TODO: move to multi fee variant when ui ready

            if
                let feeResult = try calculateFeeResults(for: metadata, amount: inputAmount).first,
                let feeDescription = metadata.feeDescriptions.first {

                sendingAmount = feeResult.sending
                totalAmount = feeResult.total

                if feeResult.fee > 0 {
                    let fee = Fee(value: AmountDecimal(value: feeResult.fee),
                                  feeDescription: feeDescription)
                    fees.append(fee)
                }
            } else {
                sendingAmount = inputAmount
                totalAmount = inputAmount
            }

            guard validateAndReportBalanceConstraints(for: totalAmount) else {
                    return nil
            }

            let destinationAccountId = metadata.providerAccountId

            let amount = AmountDecimal(value: sendingAmount)

            let info = WithdrawInfo(destinationAccountId: destinationAccountId,
                                    assetId: selectedAsset.identifier,
                                    amount: amount,
                                    details: descriptionInputViewModel.text,
                                    fees: fees)

            return info
        } catch {
            logger?.error("Did receive unexpected error \(error)")
            return nil
        }
    }

    private func validateAndReportLimitConstraints(for amount: Decimal) -> Bool {
        guard amount >= withdrawViewModelFactory.minimumLimit(for: selectedAsset) else {
            let locale = localizationManager?.selectedLocale ?? Locale.current
            let message = withdrawViewModelFactory.createMinimumLimitErrorDetails(for: selectedAsset,
                                                                                  locale: locale)
            view?.showError(message: message)
            return false
        }

        return true
    }

    private func validateAndReportBalanceConstraints(for amount: Decimal) -> Bool {
        guard
            let balanceData = balances?
                .first(where: { $0.identifier == selectedAsset.identifier}),
            amount <= balanceData.balance.decimalValue else {
                view?.showError(message: L10n.Withdraw.Error.tooPoor)
                return false
        }

        return true
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

    private func calculateFeeResults(for metadata: WithdrawMetaData, amount: Decimal) throws
        -> [FeeCalculationResult] {
        try metadata.feeDescriptions.map { feeDescription in
            let calculator = try feeCalculationFactory
                .createWithdrawFeeStrategyForDescription(feeDescription,
                                                         assetId: selectedAsset.identifier,
                                                         optionId: selectedOption.identifier,
                                                         precision: selectedAsset.precision)

            return try calculator.calculate(for: amount)
        }
    }
}

extension WithdrawPresenter: OperationDefinitionPresenterProtocol {
    func setup() {
        amountInputViewModel.observable.add(observer: self)

        setupSelectedAssetViewModel(isSelecting: false)

        view?.set(amountViewModel: amountInputViewModel)

        setupFeeViewModel(for: selectedAsset)

        view?.set(descriptionViewModel: descriptionInputViewModel)

        updateAccessoryViewModel(for: selectedAsset)

        setupBalanceDataProvider()
        setupMetadata(provider: metaDataProvider)
    }

    func proceed() {
        guard confirmationState == nil else {
            return
        }

        view?.didStartLoading()

        confirmationState = .waiting

        balanceDataProvider.refresh()
        metaDataProvider.refresh()
    }

    func presentAssetSelection() {
        let initialIndex = assets.firstIndex(where: { $0.identifier == selectedAsset.identifier }) ?? 0

        let titles: [String] = assets.map { (asset) in
            let balanceData = balances?.first { $0.identifier == asset.identifier }

            let locale = localizationManager?.selectedLocale ?? Locale.current
            return assetSelectionFactory.createTitle(for: asset, balanceData: balanceData, locale: locale)
        }

        coordinator.presentPicker(for: titles, initialIndex: initialIndex, delegate: self)

        setupSelectedAssetViewModel(isSelecting: true)
    }

    func presentFeeEditing(at index: Int) {}
}

extension WithdrawPresenter: ModalPickerViewDelegate {
    func modalPickerViewDidCancel(_ view: ModalPickerView) {
        setupSelectedAssetViewModel(isSelecting: false)
    }

    func modalPickerView(_ view: ModalPickerView, didSelectRowAt index: Int, in context: AnyObject?) {
        do {
            let newAsset = assets[index]

            if newAsset.identifier != selectedAsset.identifier {
                self.metadata = nil

                try updateMetadataProvider(for: newAsset)

                self.selectedAsset = newAsset

                setupSelectedAssetViewModel(isSelecting: false)

                setupFeeViewModel(for: newAsset)
                updateAccessoryViewModel(for: newAsset)
                updateAmountInputViewModel()
            }
        } catch {
            logger?.error("Unexpected error when new asset selected \(error)")
        }
    }
}

extension WithdrawPresenter: AmountInputViewModelObserver {
    func amountInputDidChange() {
        setupFeeViewModel(for: selectedAsset)
        updateAccessoryViewModel(for: selectedAsset)
    }
}

extension WithdrawPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            updateAmountInputViewModel()
            setupFeeViewModel(for: selectedAsset)
            updateAccessoryViewModel(for: selectedAsset)
            updateDescriptionViewModel()

            setupSelectedAssetViewModel(isSelecting: false)
        }
    }
}