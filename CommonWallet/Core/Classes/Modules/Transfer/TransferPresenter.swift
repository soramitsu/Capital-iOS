/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood
import SoraFoundation

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
    
    var amountInputViewModel: AmountInputViewModelProtocol
    var descriptionInputViewModel: DescriptionInputViewModelProtocol?
    var metadataProvider: SingleValueProvider<TransferMetaData>
    var balances: [BalanceData]?
    var metadata: TransferMetaData?
    var selectedAsset: WalletAsset
    var confirmationState: TransferCheckingState?

    let feeCalculationFactory: FeeCalculationFactoryProtocol
    let viewModelFactory: TransferViewModelFactoryProtocol
    let headerFactory: OperationDefinitionHeaderModelFactoryProtocol
    let resultValidator: TransferValidating
    let changeHandler: OperationDefinitionChangeHandling
    let errorHandler: OperationDefinitionErrorHandling?
    let feeEditing: FeeEditing?

    let dataProviderFactory: DataProviderFactoryProtocol
    let balanceDataProvider: SingleValueProvider<[BalanceData]>

    let assets: [WalletAsset]
    let accountId: String
    let payload: TransferPayload
    let receiverPosition: TransferReceiverPosition

    var selectedBalance: BalanceData? {
        balances?.first { $0.identifier == selectedAsset.identifier }
    }

    var inputState: TransferInputState {
        TransferInputState(selectedAsset: selectedAsset,
                           balance: selectedBalance,
                           amount: amountInputViewModel.decimalAmount,
                           metadata: metadata)
    }

    init(view: TransferViewProtocol,
         coordinator: TransferCoordinatorProtocol,
         assets: [WalletAsset],
         accountId: String,
         payload: TransferPayload,
         dataProviderFactory: DataProviderFactoryProtocol,
         feeCalculationFactory: FeeCalculationFactoryProtocol,
         resultValidator: TransferValidating,
         changeHandler: OperationDefinitionChangeHandling,
         viewModelFactory: TransferViewModelFactoryProtocol,
         headerFactory: OperationDefinitionHeaderModelFactoryProtocol,
         receiverPosition: TransferReceiverPosition,
         localizationManager: LocalizationManagerProtocol?,
         errorHandler: OperationDefinitionErrorHandling?,
         feeEditing: FeeEditing?) throws {

        if let assetId = payload.receiveInfo.assetId,
            let asset = assets.first(where: { $0.identifier == assetId }) {
            selectedAsset = asset
        } else {
            selectedAsset = assets[0]
        }

        self.view = view
        self.coordinator = coordinator
        self.assets = assets
        self.accountId = accountId
        self.payload = payload
        self.receiverPosition = receiverPosition

        self.dataProviderFactory = dataProviderFactory
        self.balanceDataProvider = try dataProviderFactory.createBalanceDataProvider()
        self.metadataProvider = try dataProviderFactory
            .createTransferMetadataProvider(for: selectedAsset.identifier,
                                            receiver: payload.receiveInfo.accountId)

        self.resultValidator = resultValidator
        self.feeCalculationFactory = feeCalculationFactory
        self.viewModelFactory = viewModelFactory
        self.headerFactory = headerFactory
        self.errorHandler = errorHandler
        self.changeHandler = changeHandler
        self.feeEditing = feeEditing

        let locale = localizationManager?.selectedLocale ?? Locale.current

        let state = TransferInputState(selectedAsset: selectedAsset,
                                       balance: nil,
                                       amount: payload.receiveInfo.amount?.decimalValue,
                                       metadata: nil)

        descriptionInputViewModel = try viewModelFactory
            .createDescriptionViewModel(state,
                                        details: payload.receiveInfo.details,
                                        payload: payload,
                                        locale: locale)

        amountInputViewModel = try viewModelFactory.createAmountViewModel(state,
                                                                          payload: payload,
                                                                          locale: locale)

        self.localizationManager = localizationManager
    }
}
