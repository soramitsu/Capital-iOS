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

    private var assetSelectionViewModel: AssetSelectionViewModel
    private var amountInputViewModel: AmountInputViewModel
    private var descriptionInputViewModel: DescriptionInputViewModel
    private var feeViewModel: FeeViewModel

    private var balances: [BalanceData]?
    private var metadata: WithdrawMetaData?
    private let dataProviderFactory: DataProviderFactoryProtocol
    private let balanceDataProvider: SingleValueProvider<[BalanceData]>
    private var metaDataProvider: SingleValueProvider<WithdrawMetaData>
    private let assetTitleFactory: AssetSelectionFactoryProtocol
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
         assetTitleFactory: AssetSelectionFactoryProtocol,
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
        self.assetTitleFactory = assetTitleFactory

        descriptionInputViewModel = try withdrawViewModelFactory.createDescriptionViewModel()

        let locale = localizationManager?.selectedLocale ?? Locale.current

        let title = assetTitleFactory.createTitle(for: selectedAsset, balanceData: nil, locale: locale)
        assetSelectionViewModel = AssetSelectionViewModel(assetId: selectedAsset.identifier,
                                                          title: title,
                                                          symbol: selectedAsset.symbol)
        assetSelectionViewModel.canSelect = assets.count > 1

        amountInputViewModel = withdrawViewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                              amount: nil,
                                                                              locale: locale)

        let feeTitle = withdrawViewModelFactory.createFeeTitle(for: selectedAsset,
                                                               amount: nil,
                                                               locale: locale)
        feeViewModel = FeeViewModel(title: feeTitle)
        feeViewModel.isLoading = true

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

    private func updateFeeViewModel(for asset: WalletAsset) {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        guard
            let amount = amountInputViewModel.decimalAmount,
            let metadata = metadata else {
                feeViewModel.title = withdrawViewModelFactory.createFeeTitle(for: asset,
                                                                             amount: nil,
                                                                             locale: locale)
                feeViewModel.isLoading = true
                return
        }

        do {

            // TODO: move to multi fee variant when ui ready
            let feeResult = try calculateFeeResults(for: metadata, amount: amount).first

            feeViewModel.title = withdrawViewModelFactory.createFeeTitle(for: asset,
                                                                         amount: feeResult?.fee,
                                                                         locale: locale)
            feeViewModel.isLoading = false
        } catch {
            feeViewModel.title = withdrawViewModelFactory.createFeeTitle(for: asset,
                                                                         amount: nil,
                                                                         locale: locale)
            feeViewModel.isLoading = true
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

    private func updateSelectedAssetViewModel(for newAsset: WalletAsset) {
        assetSelectionViewModel.isSelecting = false

        assetSelectionViewModel.assetId = newAsset.identifier

        let balanceData = balances?.first { $0.identifier == newAsset.identifier }

        let locale = localizationManager?.selectedLocale ?? Locale.current
        let title = assetTitleFactory.createTitle(for: newAsset, balanceData: balanceData, locale: locale)

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
            let asset = assets.first(where: { $0.identifier == assetId }),
            let balanceData = balances.first(where: { $0.identifier == assetId}) else {

                if confirmationState != nil {
                   confirmationState = nil

                    view?.showError(message: L10n.Withdraw.Error.noAsset)
                }

                return
        }

        let locale = localizationManager?.selectedLocale ?? Locale.current

        assetSelectionViewModel.title = assetTitleFactory.createTitle(for: asset,
                                                                      balanceData: balanceData,
                                                                      locale: locale)

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

        view?.set(assetViewModel: assetSelectionViewModel)
        view?.set(amountViewModel: amountInputViewModel)
        view?.set(feeViewModels: [feeViewModel])
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
        var initialIndex = 0

        if let assetId = assetSelectionViewModel.assetId {
            initialIndex = assets.firstIndex(where: { $0.identifier == assetId }) ?? 0
        }

        let titles: [String] = assets.map { (asset) in
            let balanceData = balances?.first { $0.identifier == asset.identifier }

            let locale = localizationManager?.selectedLocale ?? Locale.current
            return assetTitleFactory.createTitle(for: asset, balanceData: balanceData, locale: locale)
        }

        coordinator.presentPicker(for: titles, initialIndex: initialIndex, delegate: self)

        assetSelectionViewModel.isSelecting = true
    }

    func presentFeeEditing(at index: Int) {}
}

extension WithdrawPresenter: ModalPickerViewDelegate {
    func modalPickerViewDidCancel(_ view: ModalPickerView) {
        assetSelectionViewModel.isSelecting = false
    }

    func modalPickerView(_ view: ModalPickerView, didSelectRowAt index: Int, in context: AnyObject?) {
        do {
            let newAsset = assets[index]

            if newAsset.identifier != selectedAsset.identifier {
                self.metadata = nil

                try updateMetadataProvider(for: newAsset)

                self.selectedAsset = newAsset

                updateSelectedAssetViewModel(for: newAsset)
                updateFeeViewModel(for: newAsset)
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
        updateFeeViewModel(for: selectedAsset)
        updateAccessoryViewModel(for: selectedAsset)
    }
}

extension WithdrawPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            updateAmountInputViewModel()
            updateFeeViewModel(for: selectedAsset)
            updateAccessoryViewModel(for: selectedAsset)
            updateDescriptionViewModel()
            updateSelectedAssetViewModel(for: selectedAsset)
        }
    }
}
