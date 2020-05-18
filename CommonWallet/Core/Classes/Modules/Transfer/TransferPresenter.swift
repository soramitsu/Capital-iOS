/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import SoraFoundation

enum TransferPresenterInitError: Error {
    case missingSelectedAsset
}

struct TransferCheckingState: OptionSet {
    typealias RawValue = UInt8

    static let waiting: TransferCheckingState = []
    static let requestedAmount = TransferCheckingState(rawValue: 1)
    static let requestedFee = TransferCheckingState(rawValue: 2)
    static let completed = TransferCheckingState.requestedAmount.union(.requestedFee)

    var rawValue: TransferCheckingState.RawValue

    init(rawValue: TransferCheckingState.RawValue) {
        self.rawValue = rawValue
    }
}

final class TransferPresenter {

    weak var view: TransferViewProtocol?
    var coordinator: TransferCoordinatorProtocol
    var logger: WalletLoggerProtocol?
    
    private var amountInputViewModel: AmountInputViewModel
    private var descriptionInputViewModel: DescriptionInputViewModel

    private var feeCalculationFactory: FeeCalculationFactoryProtocol
    private var transferViewModelFactory: TransferViewModelFactoryProtocol
    private var assetSelectionFactory: AssetSelectionFactoryProtocol
    private var accessoryFactory: ContactAccessoryViewModelFactoryProtocol
    private var headerFactory: OperationDefinitionHeaderModelFactoryProtocol
    private var resultValidator: TransferValidating
    private var errorHandler: OperationDefinitionErrorHandling?

    private let dataProviderFactory: DataProviderFactoryProtocol
    private let balanceDataProvider: SingleValueProvider<[BalanceData]>
    private var metadataProvider: SingleValueProvider<TransferMetaData>

    private var balances: [BalanceData]?
    private var metadata: TransferMetaData?
    private var selectedAsset: WalletAsset
    private let account: WalletAccountSettingsProtocol
    private var payload: AmountPayload
    private let receiverPosition: TransferReceiverPosition

    private(set) var confirmationState: TransferCheckingState?

    init(view: TransferViewProtocol,
         coordinator: TransferCoordinatorProtocol,
         payload: AmountPayload,
         dataProviderFactory: DataProviderFactoryProtocol,
         feeCalculationFactory: FeeCalculationFactoryProtocol,
         account: WalletAccountSettingsProtocol,
         resultValidator: TransferValidating,
         transferViewModelFactory: TransferViewModelFactoryProtocol,
         assetSelectionFactory: AssetSelectionFactoryProtocol,
         accessoryFactory: ContactAccessoryViewModelFactoryProtocol,
         headerFactory: OperationDefinitionHeaderModelFactoryProtocol,
         receiverPosition: TransferReceiverPosition,
         localizationManager: LocalizationManagerProtocol?,
         errorHandler: OperationDefinitionErrorHandling?) throws {

        if let assetId = payload.receiveInfo.assetId, let asset = account.asset(for: assetId) {
            selectedAsset = asset
        } else if let asset = account.assets.first {
            selectedAsset = asset
        } else {
            throw TransferPresenterInitError.missingSelectedAsset
        }

        self.view = view
        self.coordinator = coordinator
        self.account = account
        self.payload = payload
        self.receiverPosition = receiverPosition

        self.dataProviderFactory = dataProviderFactory
        self.balanceDataProvider = try dataProviderFactory.createBalanceDataProvider()
        self.metadataProvider = try dataProviderFactory
            .createTransferMetadataProvider(for: selectedAsset.identifier,
                                            receiver: payload.receiveInfo.accountId)

        self.resultValidator = resultValidator
        self.feeCalculationFactory = feeCalculationFactory
        self.transferViewModelFactory = transferViewModelFactory
        self.assetSelectionFactory = assetSelectionFactory
        self.accessoryFactory = accessoryFactory
        self.headerFactory = headerFactory
        self.errorHandler = errorHandler

        let locale = localizationManager?.selectedLocale ?? Locale.current

        descriptionInputViewModel = try transferViewModelFactory
            .createDescriptionViewModel(for: payload.receiveInfo.details)

        let decimalAmount = payload.receiveInfo.amount?.decimalValue

        amountInputViewModel = transferViewModelFactory.createAmountViewModel(for: selectedAsset,
                                                                              sender: account.accountId,
                                                                              receiver: payload.receiveInfo.accountId,
                                                                              amount: decimalAmount,
                                                                              locale: locale)

        self.localizationManager = localizationManager
    }

    private func attempHandleError(_ error: Error) -> Bool {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        if let errorMapping = errorHandler?.mapError(error, locale: locale) {
            switch errorMapping.type {
            case .asset:
                view?.presentAssetError(errorMapping.message)
            case .amount:
                view?.presentAmountError(errorMapping.message)
            case .receiver:
                view?.presentReceiverError(errorMapping.message)
            case .fee:
                view?.presentFeeError(errorMapping.message, at: 0)
            case .description:
                view?.presentDescriptionError(errorMapping.message)
            }

            return true
        }

        guard let view = view else {
            return false
        }

        return view.attemptShowError(error, locale: locale)
    }

    private func setupAmountInputViewModel() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        amountInputViewModel.observable.add(observer: self)

        view?.set(amountViewModel: amountInputViewModel)

        if let amountTitle = headerFactory.createAmountTitle(assetId: selectedAsset.identifier,
                                                             receiverId: payload.receiveInfo.accountId,
                                                             locale: locale) {
            view?.setAmountHeader(amountTitle)
        }
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

        if let amountTitle = headerFactory.createAmountTitle(assetId: selectedAsset.identifier,
                                                             receiverId: payload.receiveInfo.accountId,
                                                             locale: locale) {
            view?.setAmountHeader(amountTitle)
        }
    }

    private func setupFeeViewModel(for asset: WalletAsset) {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let amount = amountInputViewModel.decimalAmount ?? 0

        guard let metadata = metadata else {
            return
        }

        do {
            let calculator = try feeCalculationFactory
                .createTransferFeeStrategyForDescriptions(metadata.feeDescriptions,
                                                          assetId: selectedAsset.identifier,
                                                          precision: selectedAsset.precision)

            let feeResult = try calculator.calculate(for: amount)

            let viewModels: [FeeViewModel] = try feeResult.fees.map { fee in
                guard let asset = account.assets
                    .first(where: { $0.identifier == fee.feeDescription.assetId }) else {
                    throw TransferPresenterError.missingAsset
                }

                return transferViewModelFactory.createFeeViewModel(fee, feeAsset: asset, locale: locale)
            }

            view?.set(feeViewModels: viewModels)
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle fee view model error \(error)")
            }
        }
    }

    private func setupSelectedAssetViewModel(isSelecting: Bool) {
        let locale = localizationManager?.selectedLocale ?? Locale.current
        let balanceData = balances?.first { $0.identifier == selectedAsset.identifier }

        let viewModel = assetSelectionFactory.createViewModel(for: selectedAsset,
                                                              balanceData: balanceData,
                                                              locale: locale,
                                                              isSelecting: isSelecting,
                                                              canSelect: account.assets.count > 1)

        view?.set(assetViewModel: viewModel)

        if let assetTitle = headerFactory.createAssetTitle(assetId: selectedAsset.identifier,
                                                           receiverId: payload.receiveInfo.accountId,
                                                           locale: locale) {
            view?.setAssetHeader(assetTitle)
        }
    }

    private func setupDescriptionViewModel() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        view?.set(descriptionViewModel: descriptionInputViewModel)

        if let descriptionTitle = headerFactory
            .createDescriptionTitle(assetId: selectedAsset.identifier,
                                    receiverId: payload.receiveInfo.accountId,
                                    locale: locale) {
            view?.setDescriptionHeader(descriptionTitle)
        }
    }

    private func updateDescriptionViewModel() {
        do {
            let locale = localizationManager?.selectedLocale ?? Locale.current

            let text = descriptionInputViewModel.text
            descriptionInputViewModel = try transferViewModelFactory.createDescriptionViewModel(for: text)

            view?.set(descriptionViewModel: descriptionInputViewModel)

            if let descriptionTitle = headerFactory
                .createDescriptionTitle(assetId: selectedAsset.identifier,
                                        receiverId: payload.receiveInfo.accountId,
                                        locale: locale) {
                view?.setDescriptionHeader(descriptionTitle)
            }
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle description updaet view model error \(error)")
            }
        }
    }

    private func setupReceiverViewModel() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let accessoryViewModel = accessoryFactory.createViewModel(from: payload.receiverName,
                                                                  fullName: payload.receiverName,
                                                                  action: "")

        let viewModel = MultilineTitleIconViewModel(text: accessoryViewModel.title,
                                                    icon: accessoryViewModel.icon)

        view?.set(receiverViewModel: viewModel)

        if let title = headerFactory.createReceiverTitle(assetId: selectedAsset.identifier,
                                                         receiverId: payload.receiveInfo.accountId,
                                                         locale: locale) {
            view?.setReceiverHeader(title)
        }

    }

    private func setupAccessoryViewModel() {
        let accessoryViewModel: AccessoryViewModelProtocol

        switch receiverPosition {
        case .accessoryBar:
            accessoryViewModel = accessoryFactory.createViewModel(from: payload.receiverName,
                                                                  fullName: payload.receiverName,
                                                                  action: L10n.Common.next)
        default:
            accessoryViewModel = accessoryFactory.createViewModel(from: "",
                                                                  action: L10n.Common.next,
                                                                  icon: nil)
        }

        view?.set(accessoryViewModel: accessoryViewModel)
    }
    
    private func handleResponse(with optionalBalances: [BalanceData]?) {
        if let balances = optionalBalances {
            self.balances = balances
        }

        guard let balances = self.balances else {
            return
        }
        
        guard balances.first(where: { $0.identifier == selectedAsset.identifier}) != nil else {

                if confirmationState != nil {
                    confirmationState = nil

                    if !attempHandleError(TransferPresenterError.missingAsset) {
                        logger?.error("Can't handle asset missing error")
                    }
                }

            return
        }

        setupSelectedAssetViewModel(isSelecting: false)

        if let currentState = confirmationState {
            confirmationState = currentState.union(.requestedAmount)
            completeConfirmation()
        }
    }

    private func handleResponse(with error: Error) {
        if confirmationState != nil {
            confirmationState = nil

            view?.didStopLoading()

            if attempHandleError(error) {
                return
            }

            if attempHandleError(TransferPresenterError.missingBalances) {
                return
            }

            logger?.error("Can't handle asset missing error")
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

        setupFeeViewModel(for: selectedAsset)

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

        if attempHandleError(error) {
            return
        }

        if attempHandleError(TransferPresenterError.missingMetadata) {
            return
        }

        logger?.error("Can't handle transfer metadata error \(error)")
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

    private func prepareTransferInfo() throws -> TransferInfo {
        let inputAmount = amountInputViewModel.decimalAmount ?? 0

        guard let metadata = metadata else {
            throw TransferPresenterError.missingMetadata
        }

        guard let balances = balances else {
            throw TransferPresenterError.missingBalances
        }

        let calculator = try feeCalculationFactory
            .createTransferFeeStrategyForDescriptions(metadata.feeDescriptions,
                                                      assetId: selectedAsset.identifier,
                                                      precision: selectedAsset.precision)

        let result = try calculator.calculate(for: inputAmount)

        let info = TransferInfo(source: account.accountId,
                                destination: payload.receiveInfo.accountId,
                                amount: AmountDecimal(value: result.sending),
                                asset: selectedAsset.identifier,
                                details: descriptionInputViewModel.text,
                                fees: result.fees)

        try resultValidator.validate(info: info, balances: balances)

        return info
    }

    private func completeConfirmation() {
        guard confirmationState == .completed else {
            return
        }

        confirmationState = nil

        view?.didStopLoading()

        do {
            let transferInfo = try prepareTransferInfo()

            let composedPayload = TransferPayload(transferInfo: transferInfo,
                                                  receiverName: payload.receiverName,
                                                  assetSymbol: selectedAsset.symbol)

            coordinator.confirm(with: composedPayload)
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle confirmation error \(error)")
            }
        }
    }
}


extension TransferPresenter: OperationDefinitionPresenterProtocol {

    func setup() {
        setupSelectedAssetViewModel(isSelecting: false)
        setupAmountInputViewModel()
        setupFeeViewModel(for: selectedAsset)
        setupDescriptionViewModel()

        if receiverPosition == .form {
            setupReceiverViewModel()
        }

        setupAccessoryViewModel()

        setupBalanceDataProvider()
        setupMetadata(provider: metadataProvider)
    }
    
    func proceed() {
        guard confirmationState == nil else {
            return
        }

        view?.didStartLoading()

        confirmationState = .waiting

        balanceDataProvider.refresh()
        metadataProvider.refresh()
    }
    
    func presentAssetSelection() {
        let initialIndex = account.assets.firstIndex(where: { $0.identifier == selectedAsset.identifier }) ?? 0

        let titles: [String] = account.assets.map { (asset) in
            let balanceData = balances?.first { $0.identifier == asset.identifier }

            let locale = localizationManager?.selectedLocale ?? Locale.current
            return assetSelectionFactory.createTitle(for: asset, balanceData: balanceData, locale: locale)
        }

        coordinator.presentPicker(for: titles, initialIndex: initialIndex, delegate: self)

        setupSelectedAssetViewModel(isSelecting: true)
    }

    func presentFeeEditing(at index: Int) {
        
    }
}

extension TransferPresenter: ModalPickerViewDelegate {
    func modalPickerViewDidCancel(_ view: ModalPickerView) {
        setupSelectedAssetViewModel(isSelecting: false)
    }

    func modalPickerView(_ view: ModalPickerView, didSelectRowAt index: Int, in context: AnyObject?) {
        do {
            let newAsset = account.assets[index]

            if newAsset.identifier != selectedAsset.identifier {
                self.metadata = nil

                try updateMetadataProvider(for: newAsset)

                self.selectedAsset = newAsset

                setupSelectedAssetViewModel(isSelecting: false)

                setupFeeViewModel(for: newAsset)
                updateAmountInputViewModel()
            }
        } catch {
            if !attempHandleError(error) {
                logger?.error("Unexpected error when new asset selected \(error)")
            }
        }
    }
}

extension TransferPresenter: AmountInputViewModelObserver {
    func amountInputDidChange() {
        setupFeeViewModel(for: selectedAsset)
    }
}

extension TransferPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            updateAmountInputViewModel()
            setupSelectedAssetViewModel(isSelecting: false)
            setupFeeViewModel(for: selectedAsset)
            updateDescriptionViewModel()
            setupAccessoryViewModel()

            if receiverPosition == .form {
                setupReceiverViewModel()
            }
        }
    }
}
