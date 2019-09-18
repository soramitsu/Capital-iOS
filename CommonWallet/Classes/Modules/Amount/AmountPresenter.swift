/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import IrohaCommunication

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

    private let dataProviderFactory: DataProviderFactoryProtocol
    private let balanceDataProvider: SingleValueProvider<[BalanceData], CDCWSingleValue>
    private var metadataProvider: SingleValueProvider<TransferMetaData, CDCWSingleValue>

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
         accessoryFactory: ContactAccessoryViewModelFactoryProtocol) throws {

        guard
            let selectedAsset = account.asset(for: payload.receiveInfo.assetId.identifier()) ??
            account.assets.first else {
            throw AmountPresenterError.missingSelectedAsset
        }

        self.view = view
        self.coordinator = coordinator
        self.account = account
        self.payload = payload

        self.selectedAsset = selectedAsset

        self.dataProviderFactory = dataProviderFactory
        self.balanceDataProvider = try dataProviderFactory.createBalanceDataProvider()
        self.metadataProvider = try dataProviderFactory.createTransferMetadataProvider(for: selectedAsset.identifier)

        self.feeCalculationFactory = feeCalculationFactory
        self.transferViewModelFactory = transferViewModelFactory
        self.assetSelectionFactory = assetSelectionFactory
        
        descriptionInputViewModel = try transferViewModelFactory.createDescriptionViewModel()

        let assetTitle = assetSelectionFactory.createTitle(for: selectedAsset, balanceData: nil)
        assetSelectionViewModel = AssetSelectionViewModel(assetId: selectedAsset.identifier,
                                                          title: assetTitle,
                                                          symbol: selectedAsset.symbol)
        assetSelectionViewModel.canSelect = account.assets.count > 1

        amountInputViewModel = transferViewModelFactory.createAmountViewModel()

        accessoryViewModel = accessoryFactory.createViewModel(from: payload.receiverName,
                                                              fullName: payload.receiverName,
                                                              action: "Next")

        let feeTitle = transferViewModelFactory.createFeeTitle(for: selectedAsset, amount: nil)
        feeViewModel = FeeViewModel(title: feeTitle)
        feeViewModel.isLoading = true
    }

    private func updateFeeViewModel(for asset: WalletAsset) {
        guard
            let amount = amountInputViewModel.decimalAmount,
            let feeRateString = metadata?.feeRate,
            let feeRate = Decimal(string: feeRateString) else {
                feeViewModel.title = transferViewModelFactory.createFeeTitle(for: asset, amount: nil)
                feeViewModel.isLoading = true
                return
        }

        let fee = amount * feeRate
        feeViewModel.title = transferViewModelFactory.createFeeTitle(for: asset, amount: fee)
        feeViewModel.isLoading = false
    }

    private func updateSelectedAssetViewModel(for newAsset: WalletAsset) {
        assetSelectionViewModel.isSelecting = false

        assetSelectionViewModel.assetId = newAsset.identifier

        let balanceData = balances?.first { $0.identifier == newAsset.identifier.identifier() }
        let title = assetSelectionFactory.createTitle(for: newAsset, balanceData: balanceData)

        assetSelectionViewModel.title = title

        assetSelectionViewModel.symbol = newAsset.symbol
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

                    let message = "Sorry, we couldn't find asset information you want to send. Please, try again later."
                    view?.showError(message: message)
                }

            return
        }

        assetSelectionViewModel.title = assetSelectionFactory.createTitle(for: asset, balanceData: balanceData)

        if let currentState = confirmationState {
            confirmationState = currentState.union(.requestedAmount)
            completeConfirmation()
        }
    }

    private func handleResponse(with error: Error) {
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
        balanceDataProvider.addCacheObserver(self,
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

        let message = "Sorry, we coudn't contact trasfer provider. Please, try again later."
        view?.showError(message: message)
    }

    private func updateMetadataProvider(for asset: WalletAsset) throws {
        let metaDataProvider = try dataProviderFactory.createTransferMetadataProvider(for: asset.identifier)
        self.metadataProvider = metaDataProvider

        setupMetadata(provider: metaDataProvider)
    }

    private func setupMetadata(provider: SingleValueProvider<TransferMetaData, CDCWSingleValue>) {
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
        provider.addCacheObserver(self,
                                  deliverOn: .main,
                                  executing: changesBlock,
                                  failing: failBlock,
                                  options: options)
    }

    private func prepareTransferInfo() -> TransferInfo? {
        do {
            guard
                let sendingAmount = amountInputViewModel.decimalAmount,
                let metadata = metadata,
                let feeRate = metadata.feeRateDecimal else {
                    logger?.error("Either amount or metadata missing to complete transfer")
                    return nil
            }

            let feeCalculator = try feeCalculationFactory.createTransferFeeStrategy(for: metadata.feeType,
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

            var feeAccountId: IRAccountId?
            var feeAmount: IRAmount?

            if fee > 0.0 {
                if let accountIdString = metadata.feeAccountId {
                    feeAccountId = try IRAccountIdFactory.account(withIdentifier: accountIdString)
                }

                feeAmount = try IRAmountFactory.amount(from: (fee as NSNumber).stringValue)
            }

            let amount = try IRAmountFactory.amount(from: (sendingAmount as NSNumber).stringValue)

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

        balanceDataProvider.refreshCache()
        metadataProvider.refreshCache()
    }
    
    func presentAssetSelection() {
        var initialIndex = 0

        if let assetId = assetSelectionViewModel.assetId {
            initialIndex = account.assets.firstIndex(where: { $0.identifier.identifier() == assetId.identifier() }) ?? 0
        }

        let titles: [String] = account.assets.map { (asset) in
            let balanceData = balances?.first { $0.identifier == asset.identifier.identifier() }
            return assetSelectionFactory.createTitle(for: asset, balanceData: balanceData)
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
