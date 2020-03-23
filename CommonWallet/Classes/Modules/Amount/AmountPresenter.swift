/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication
import SoraFoundation

enum AmountPresenterError: Error {
    case missingSelectedAsset
}

struct TransferCheckingState: OptionSet {
    typealias RawValue = UInt8

    static let waiting = TransferCheckingState(rawValue: 0)
    static let requestedAmount = TransferCheckingState(rawValue: 1)
    static let requestedFee = TransferCheckingState(rawValue: 2)
    static let completed = TransferCheckingState.requestedAmount.union(.requestedFee)

    var rawValue: TransferCheckingState.RawValue

    init(rawValue: TransferCheckingState.RawValue) {
        self.rawValue = rawValue
    }
}

final class AmountPresenter {

    weak var view: AmountViewProtocol?
    var coordinator: AmountCoordinatorProtocol
    var logger: WalletLoggerProtocol?
    
    private var assetSelectionViewModel: AssetSelectionViewModel
    private var amountInputViewModel: AmountInputViewModel
    private var descriptionInputViewModel: DescriptionInputViewModel
    private var accessoryViewModel: AccessoryViewModelProtocol
    private var feeViewModel: FeeViewModel

    private var feeCalculationFactory: FeeCalculationFactoryProtocol
    private var transferViewModelFactory: AmountViewModelFactoryProtocol
    private var assetSelectionFactory: AssetSelectionFactoryProtocol
    private var accessoryFactory: ContactAccessoryViewModelFactoryProtocol

    private let dataProviderFactory: DataProviderFactoryProtocol
    private let balanceDataProvider: SingleValueProvider<[BalanceData]>
    private var metadataProvider: SingleValueProvider<TransferMetaData>

    private var balances: [BalanceData]?
    private var metadata: TransferMetaData?
    private var selectedAsset: WalletAsset
    private let account: WalletAccountSettingsProtocol
    private var payload: AmountPayload

    private(set) var confirmationState: TransferCheckingState?

    init(view: AmountViewProtocol,
         coordinator: AmountCoordinatorProtocol,
         payload: AmountPayload,
         dataProviderFactory: DataProviderFactoryProtocol,
         feeCalculationFactory: FeeCalculationFactoryProtocol,
         account: WalletAccountSettingsProtocol,
         transferViewModelFactory: AmountViewModelFactoryProtocol,
         assetSelectionFactory: AssetSelectionFactoryProtocol,
         accessoryFactory: ContactAccessoryViewModelFactoryProtocol,
         localizationManager: LocalizationManagerProtocol?) throws {

        if let assetId = payload.receiveInfo.assetId, let asset = account.asset(for: assetId.identifier()) {
            selectedAsset = asset
        } else if let asset = account.assets.first {
            selectedAsset = asset
        } else {
            throw AmountPresenterError.missingSelectedAsset
        }

        self.view = view
        self.coordinator = coordinator
        self.account = account
        self.payload = payload

        self.dataProviderFactory = dataProviderFactory
        self.balanceDataProvider = try dataProviderFactory.createBalanceDataProvider()
        self.metadataProvider = try dataProviderFactory
            .createTransferMetadataProvider(for: selectedAsset.identifier,
                                            receiver: payload.receiveInfo.accountId)

        self.feeCalculationFactory = feeCalculationFactory
        self.transferViewModelFactory = transferViewModelFactory
        self.assetSelectionFactory = assetSelectionFactory
        self.accessoryFactory = accessoryFactory

        let locale = localizationManager?.selectedLocale ?? Locale.current

        descriptionInputViewModel = try transferViewModelFactory
            .createDescriptionViewModel(for: payload.receiveInfo.details)

        let assetTitle = assetSelectionFactory.createTitle(for: selectedAsset, balanceData: nil, locale: locale)
        assetSelectionViewModel = AssetSelectionViewModel(assetId: selectedAsset.identifier,
                                                          title: assetTitle,
                                                          symbol: selectedAsset.symbol)
        assetSelectionViewModel.canSelect = account.assets.count > 1

        let decimalAmount = payload.receiveInfo.amount?.decimalValue

        amountInputViewModel = transferViewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                              sender: account.accountId,
                                                                              receiver: payload.receiveInfo.accountId,
                                                                              amount: decimalAmount,
                                                                              locale: locale)

        accessoryViewModel = accessoryFactory.createViewModel(from: payload.receiverName,
                                                              fullName: payload.receiverName,
                                                              action: L10n.Common.next)

        let feeTitle = transferViewModelFactory.createFeeTitle(for: selectedAsset,
                                                               sender: account.accountId,
                                                               receiver: payload.receiveInfo.accountId,
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

        amountInputViewModel = transferViewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                              sender: account.accountId,
                                                                              receiver: payload.receiveInfo.accountId,
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
                feeViewModel.title = transferViewModelFactory.createFeeTitle(for: asset,
                                                                             sender: account.accountId,
                                                                             receiver: payload.receiveInfo.accountId,
                                                                             amount: nil,
                                                                             locale: locale)
                feeViewModel.isLoading = true
                return
        }

        let feeRate = metadata.feeRate.decimalValue

        do {
            let feeCalculator = try feeCalculationFactory
                .createTransferFeeStrategy(for: metadata.feeType,
                                           assetId: selectedAsset.identifier,
                                           precision: selectedAsset.precision,
                                           parameters: [feeRate])

            let result = try feeCalculator.calculate(for: amount)

            feeViewModel.title = transferViewModelFactory.createFeeTitle(for: asset,
                                                                         sender: account.accountId,
                                                                         receiver: payload.receiveInfo.accountId,
                                                                         amount: result.fee,
                                                                         locale: locale)
            feeViewModel.isLoading = false
        } catch {
            feeViewModel.title = transferViewModelFactory.createFeeTitle(for: asset,
                                                                         sender: account.accountId,
                                                                         receiver: payload.receiveInfo.accountId,
                                                                         amount: nil,
                                                                         locale: locale)
            feeViewModel.isLoading = true
        }
    }

    private func updateSelectedAssetViewModel(for newAsset: WalletAsset) {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        assetSelectionViewModel.isSelecting = false

        assetSelectionViewModel.assetId = newAsset.identifier

        let balanceData = balances?.first { $0.identifier == newAsset.identifier.identifier() }
        let title = assetSelectionFactory.createTitle(for: newAsset,
                                                      balanceData: balanceData,
                                                      locale: locale)

        assetSelectionViewModel.title = title

        assetSelectionViewModel.symbol = newAsset.symbol
    }

    private func updateDescriptionViewModel() {
        do {
            let text = descriptionInputViewModel.text
            descriptionInputViewModel = try transferViewModelFactory.createDescriptionViewModel(for: text)

            view?.set(descriptionViewModel: descriptionInputViewModel)
        } catch {
            logger?.error("Can't update description view model")
        }
    }

    private func updateAccessoryViewModel() {
        accessoryViewModel = accessoryFactory.createViewModel(from: payload.receiverName,
                                                              fullName: payload.receiverName,
                                                              action: L10n.Common.next)
        view?.set(accessoryViewModel: accessoryViewModel)
    }
    
    private func handleResponse(with optionalBalances: [BalanceData]?) {
        if let balances = optionalBalances {
            self.balances = balances
        }

        guard let balances = self.balances else {
            return
        }
        
        guard
            let assetId = assetSelectionViewModel.assetId,
            let asset = account.asset(for: assetId.identifier()),
            let balanceData = balances.first(where: { $0.identifier == assetId.identifier()}) else {

                if confirmationState != nil {
                    confirmationState = nil

                    let message = L10n.Amount.Error.asset
                    view?.showError(message: message)
                }

            return
        }

        let locale = localizationManager?.selectedLocale ?? Locale.current

        assetSelectionViewModel.title = assetSelectionFactory.createTitle(for: asset,
                                                                          balanceData: balanceData,
                                                                          locale: locale)

        if let currentState = confirmationState {
            confirmationState = currentState.union(.requestedAmount)
            completeConfirmation()
        }
    }

    private func handleResponse(with error: Error) {
        if confirmationState != nil {
            confirmationState = nil

            view?.didStopLoading()

            let message = L10n.Amount.Error.balance
            view?.showError(message: message)
        }
    }
    
    private func setupBalanceDataProvider() {
        let changesBlock = { [weak self] (changes: [DataProviderChange<[BalanceData]>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let items), .update(let items):
                    self?.handleResponse(with: items)
                default:
                    break
                }
            } else {
                self?.handleResponse(with: nil)
            }
        }
        
        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.handleResponse(with: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        balanceDataProvider.addObserver(self,
                                        deliverOn: .main,
                                        executing: changesBlock,
                                        failing: failBlock,
                                        options: options)
    }

    private func handleTransfer(metadata: TransferMetaData?) {
        if metadata != nil {
            self.metadata = metadata
        }

        updateFeeViewModel(for: selectedAsset)

        if let currentState = confirmationState {
            confirmationState = currentState.union(.requestedFee)
            completeConfirmation()
        }
    }

    private func handleTransferMetadata(error: Error) {
        if confirmationState != nil {
            view?.didStopLoading()

            confirmationState = nil
        }

        let message = L10n.Amount.Error.transfer
        view?.showError(message: message)
    }

    private func updateMetadataProvider(for asset: WalletAsset) throws {
        let metaDataProvider = try dataProviderFactory
            .createTransferMetadataProvider(for: asset.identifier,
                                            receiver: payload.receiveInfo.accountId)
        self.metadataProvider = metaDataProvider

        setupMetadata(provider: metaDataProvider)
    }

    private func setupMetadata(provider: SingleValueProvider<TransferMetaData>) {
        let changesBlock = { [weak self] (changes: [DataProviderChange<TransferMetaData>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let item), .update(let item):
                    self?.handleTransfer(metadata: item)
                default:
                    break
                }
            } else {
                self?.handleTransfer(metadata: nil)
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.handleTransferMetadata(error: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        provider.addObserver(self,
                             deliverOn: .main,
                             executing: changesBlock,
                             failing: failBlock,
                             options: options)
    }

    private func prepareTransferInfo() -> TransferInfo? {
        do {
            guard
                let sendingAmount = amountInputViewModel.decimalAmount,
                let metadata = metadata else {
                    logger?.error("Either amount or metadata missing to complete transfer")
                    return nil
            }

            guard validateAndReportLimitConstraints(for: sendingAmount) else {
                return nil
            }

            let feeRate = metadata.feeRate.decimalValue

            let feeCalculator = try feeCalculationFactory
                .createTransferFeeStrategy(for: metadata.feeType,
                                           assetId: selectedAsset.identifier,
                                           precision: selectedAsset.precision,
                                           parameters: [feeRate])

            let result = try feeCalculator.calculate(for: sendingAmount)

            guard validateAndReportBalanceConstraints(for: result.total) else {
                return nil
            }

            var feeAccountId: IRAccountId?
            var feeAmount: AmountDecimal?

            if result.fee > 0.0 {
                if let accountIdString = metadata.feeAccountId {
                    feeAccountId = try IRAccountIdFactory.account(withIdentifier: accountIdString)
                }

                feeAmount = AmountDecimal(value: result.fee)
            }

            let amount = AmountDecimal(value: result.sending)

            return TransferInfo(source: account.accountId,
                                destination: payload.receiveInfo.accountId,
                                amount: amount,
                                asset: selectedAsset.identifier,
                                details: descriptionInputViewModel.text,
                                feeAccountId: feeAccountId,
                                fee: feeAmount)
        } catch {
            logger?.error("Did recieve unexpected error \(error) while preparing transfer")
            return nil
        }
    }

    private func validateAndReportLimitConstraints(for amount: Decimal) -> Bool {
        guard amount >= transferViewModelFactory.minimumLimit(for: selectedAsset,
                                                              sender: account.accountId,
                                                              receiver: payload.receiveInfo.accountId) else {
            let locale = localizationManager?.selectedLocale ?? Locale.current
            let receiverId = payload.receiveInfo.accountId
            let message = transferViewModelFactory.createMinimumLimitErrorDetails(for: selectedAsset,
                                                                                  sender: account.accountId,
                                                                                  receiver: receiverId,
                                                                                  locale: locale)
            view?.showError(message: message)
            return false
        }

        return true
    }

    private func validateAndReportBalanceConstraints(for amount: Decimal) -> Bool {
        guard
            let balanceData = balances?
                .first(where: { $0.identifier == selectedAsset.identifier.identifier()}),
            amount <= balanceData.balance.decimalValue else {
                let message = L10n.Amount.Error.noFunds
                view?.showError(message: message)
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

        if let transferInfo = prepareTransferInfo() {
            let composedPayload = TransferPayload(transferInfo: transferInfo,
                                                  receiverName: payload.receiverName,
                                                  assetSymbol: selectedAsset.symbol)

            coordinator.confirm(with: composedPayload)
        }
    }
}


extension AmountPresenter: AmountPresenterProtocol {

    func setup() {
        amountInputViewModel.observable.add(observer: self)

        view?.set(title: L10n.Amount.moduleTitle)
        view?.set(assetViewModel: assetSelectionViewModel)
        view?.set(amountViewModel: amountInputViewModel)
        view?.set(descriptionViewModel: descriptionInputViewModel)
        view?.set(accessoryViewModel: accessoryViewModel)
        view?.set(feeViewModel: feeViewModel)

        setupBalanceDataProvider()
        setupMetadata(provider: metadataProvider)
    }
    
    func confirm() {
        guard confirmationState == nil else {
            return
        }

        view?.didStartLoading()

        confirmationState = .waiting

        balanceDataProvider.refresh()
        metadataProvider.refresh()
    }
    
    func presentAssetSelection() {
        var initialIndex = 0

        if let assetId = assetSelectionViewModel.assetId {
            initialIndex = account.assets.firstIndex(where: { $0.identifier.identifier() == assetId.identifier() }) ?? 0
        }

        let titles: [String] = account.assets.map { (asset) in
            let balanceData = balances?.first { $0.identifier == asset.identifier.identifier() }

            let locale = localizationManager?.selectedLocale ?? Locale.current
            return assetSelectionFactory.createTitle(for: asset, balanceData: balanceData, locale: locale)
        }

        coordinator.presentPicker(for: titles, initialIndex: initialIndex, delegate: self)

        assetSelectionViewModel.isSelecting = true
    }
}

extension AmountPresenter: ModalPickerViewDelegate {
    func modalPickerViewDidCancel(_ view: ModalPickerView) {
        assetSelectionViewModel.isSelecting = false
    }

    func modalPickerView(_ view: ModalPickerView, didSelectRowAt index: Int, in context: AnyObject?) {
        do {
            let newAsset = account.assets[index]

            if newAsset.identifier.identifier() != selectedAsset.identifier.identifier() {
                self.metadata = nil

                try updateMetadataProvider(for: newAsset)

                self.selectedAsset = newAsset

                updateSelectedAssetViewModel(for: newAsset)
                updateFeeViewModel(for: newAsset)
                updateAmountInputViewModel()
            }
        } catch {
            logger?.error("Unexpected error when new asset selected \(error)")
        }
    }
}

extension AmountPresenter: AmountInputViewModelObserver {
    func amountInputDidChange() {
        updateFeeViewModel(for: selectedAsset)
    }
}

extension AmountPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            view?.set(title: L10n.Amount.moduleTitle)
            updateAmountInputViewModel()
            updateSelectedAssetViewModel(for: selectedAsset)
            updateFeeViewModel(for: selectedAsset)
            updateDescriptionViewModel()
            updateAccessoryViewModel()
        }
    }
}
