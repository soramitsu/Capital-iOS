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
    
    var amountInputViewModel: AmountInputViewModel
    var descriptionInputViewModel: DescriptionInputViewModel
    var metadataProvider: SingleValueProvider<TransferMetaData>
    var balances: [BalanceData]?
    var metadata: TransferMetaData?
    var selectedAsset: WalletAsset
    var confirmationState: TransferCheckingState?

    let feeCalculationFactory: FeeCalculationFactoryProtocol
    let transferViewModelFactory: TransferViewModelFactoryProtocol
    let assetSelectionFactory: AssetSelectionFactoryProtocol
    let accessoryFactory: ContactAccessoryViewModelFactoryProtocol
    let headerFactory: OperationDefinitionHeaderModelFactoryProtocol
    let resultValidator: TransferValidating
    let changeHandler: OperationDefinitionChangeHandling
    let errorHandler: OperationDefinitionErrorHandling?
    let feeEditing: FeeEditing?

    let dataProviderFactory: DataProviderFactoryProtocol
    let balanceDataProvider: SingleValueProvider<[BalanceData]>

    let account: WalletAccountSettingsProtocol
    let payload: AmountPayload
    let receiverPosition: TransferReceiverPosition

    init(view: TransferViewProtocol,
         coordinator: TransferCoordinatorProtocol,
         payload: AmountPayload,
         dataProviderFactory: DataProviderFactoryProtocol,
         feeCalculationFactory: FeeCalculationFactoryProtocol,
         account: WalletAccountSettingsProtocol,
         resultValidator: TransferValidating,
         changeHandler: OperationDefinitionChangeHandling,
         transferViewModelFactory: TransferViewModelFactoryProtocol,
         assetSelectionFactory: AssetSelectionFactoryProtocol,
         accessoryFactory: ContactAccessoryViewModelFactoryProtocol,
         headerFactory: OperationDefinitionHeaderModelFactoryProtocol,
         receiverPosition: TransferReceiverPosition,
         localizationManager: LocalizationManagerProtocol?,
         errorHandler: OperationDefinitionErrorHandling?,
         feeEditing: FeeEditing?) throws {

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
        self.changeHandler = changeHandler
        self.feeEditing = feeEditing

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
}
