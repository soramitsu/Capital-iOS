/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

extension TransferPresenter {
    func attempHandleError(_ error: Error) -> Bool {
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

    func handleChangeForEvent(_ event: OperationDefinitionChangeEvent) {
        let projectedChangeTypes = changeHandler.updateContentForChange(event: event)
        handleProjectedChangesIn(types: projectedChangeTypes)

        let clearErrorTypes = changeHandler.clearErrorForChange(event: event)
        clearErrorsForTypes(clearErrorTypes)

        if changeHandler.shouldUpdateAccessoryForChange(event: event) {
            setupAccessoryViewModel()
        }
    }

    func handleProjectedChangesIn(types: [OperationDefinitionType]) {
        for type in types {
            switch type {
            case .asset:
                setupSelectedAssetViewModel(isSelecting: false)
            case .amount:
                updateAmountInputViewModel()
            case .receiver:
                setupReceiverViewModel()
            case .fee:
                setupFeeViewModel(for: selectedAsset)
            case .description:
                updateDescriptionViewModel()
            }
        }
    }

    func clearErrorsForTypes(_ types: [OperationDefinitionType]) {
        for type in types {
            switch type {
            case .asset:
                view?.presentAssetError(nil)
            case .amount:
                view?.presentAmountError(nil)
            case .receiver:
                view?.presentReceiverError(nil)
            case .fee:
                if let metadata = metadata {
                    (0..<metadata.feeDescriptions.count).forEach { index in
                        view?.presentFeeError(nil, at: index)
                    }
                }
            case .description:
                view?.presentDescriptionError(nil)
            }
        }
    }
}
