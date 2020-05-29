/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

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
        do {
            let initialIndex = assets.firstIndex(where: { $0.identifier == selectedAsset.identifier }) ?? 0

            let titles: [String] = try assets.map { (asset) in
                let locale = localizationManager?.selectedLocale ?? Locale.current
                return try viewModelFactory.createAssetSelectionTitle(inputState,
                                                                      asset: asset,
                                                                      payload: payload,
                                                                      locale: locale)
            }

            coordinator.presentPicker(for: titles, initialIndex: initialIndex, delegate: self)

            setupSelectedAssetViewModel(isSelecting: true)
        } catch {
            if !attempHandleError(error) {
                logger?.error("Unexpected error when asset selection presentation \(error)")
            }
        }
    }

    func presentFeeEditing(at index: Int) {
        guard let metadata = metadata else {
            return
        }

        feeEditing?.delegate = self
        feeEditing?.startEditing(feeDescription: metadata.feeDescriptions[index])
    }
}

extension TransferPresenter: ModalPickerViewDelegate {
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

                handleChangeForEvent(.asset)
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
        handleChangeForEvent(.amount)
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

extension TransferPresenter: FeeEditingDelegate {
    func feeEditing(_ feeEditing: FeeEditing, didEdit feeDescription: FeeDescription) {
        guard
            let metadata = metadata,
            let index = metadata.feeDescriptions
                .firstIndex(where: { $0.identifier == feeDescription.identifier }) else {
            return
        }

        self.metadata?.feeDescriptions[index] = feeDescription

        handleChangeForEvent(.metadata)
    }
}
