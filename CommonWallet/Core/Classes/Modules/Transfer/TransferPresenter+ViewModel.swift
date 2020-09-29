/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

extension TransferPresenter {
    func setupAmountInputViewModel() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        amountInputViewModel.observable.add(observer: self)

        view?.set(amountViewModel: amountInputViewModel)

        let amountTitle = headerFactory.createAmountTitle(assetId: selectedAsset.identifier,
                                                          receiverId: payload.receiveInfo.accountId,
                                                          locale: locale)

        view?.setAmountHeader(amountTitle)
    }

    func updateAmountInputViewModel() {
        do {
            let locale = localizationManager?.selectedLocale ?? Locale.current

            amountInputViewModel.observable.remove(observer: self)

            amountInputViewModel = try viewModelFactory.createAmountViewModel(inputState,
                                                                              payload: payload,
                                                                              locale: locale)

            amountInputViewModel.observable.add(observer: self)

            view?.set(amountViewModel: amountInputViewModel)

            let amountTitle = headerFactory.createAmountTitle(assetId: selectedAsset.identifier,
                                                              receiverId: payload.receiveInfo.accountId,
                                                              locale: locale)

            view?.setAmountHeader(amountTitle)
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle amount view model error \(error)")
            }
        }
    }

    func setupFeeViewModel(for asset: WalletAsset) {
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

            let viewModels: [FeeViewModelProtocol] = try feeResult.fees.map { fee in
                try viewModelFactory.createFeeViewModel(inputState,
                                                        fee: fee,
                                                        payload: payload,
                                                        locale: locale)
            }

            view?.set(feeViewModels: viewModels)

            for (index, feeDescription) in feeResult.fees.enumerated() {
                let titleViewModel = headerFactory
                    .createFeeTitleForDescription(assetId: selectedAsset.identifier,
                                                  receiverId: payload.receiveInfo.accountId,
                                                  feeDescription: feeDescription,
                                                  locale: locale)
                view?.setFeeHeader(titleViewModel, at: index)
            }
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle fee view model error \(error)")
            }
        }
    }

    func setupSelectedAssetViewModel(isSelecting: Bool) {
        do {
            let locale = localizationManager?.selectedLocale ?? Locale.current

            let assetState = SelectedAssetState(isSelecting: isSelecting, canSelect: assets.count > 1)

            let viewModel = try viewModelFactory.createSelectedAssetViewModel(inputState,
                                                                              selectedAssetState: assetState,
                                                                              payload: payload,
                                                                              locale: locale)

            view?.set(assetViewModel: viewModel)

            let assetTitle = headerFactory.createAssetTitle(assetId: selectedAsset.identifier,
                                                            receiverId: payload.receiveInfo.accountId,
                                                            locale: locale)

            view?.setAssetHeader(assetTitle)
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle selected asset view model error \(error)")
            }
        }
    }

    func setupDescriptionViewModel() {
        guard let descriptionViewModel = descriptionInputViewModel else {
            return
        }

        let locale = localizationManager?.selectedLocale ?? Locale.current

        view?.set(descriptionViewModel: descriptionViewModel)

        let descriptionTitle = headerFactory
            .createDescriptionTitle(assetId: selectedAsset.identifier,
                                    receiverId: payload.receiveInfo.accountId,
                                    locale: locale)

        view?.setDescriptionHeader(descriptionTitle)
    }

    func updateDescriptionViewModel() {
        do {
            let locale = localizationManager?.selectedLocale ?? Locale.current

            let text = descriptionInputViewModel?.text
            descriptionInputViewModel = try viewModelFactory
                .createDescriptionViewModel(inputState,
                                            details: text,
                                            payload: payload,
                                            locale: locale)

            if let descriptionViewModel = descriptionInputViewModel {
                view?.set(descriptionViewModel: descriptionViewModel)

                let descriptionTitle = headerFactory
                    .createDescriptionTitle(assetId: selectedAsset.identifier,
                                            receiverId: payload.receiveInfo.accountId,
                                            locale: locale)

                view?.setDescriptionHeader(descriptionTitle)
            }
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle description update view model error \(error)")
            }
        }
    }

    func setupReceiverViewModel() {
        do {
            let locale = localizationManager?.selectedLocale ?? Locale.current

            let viewModel = try viewModelFactory.createReceiverViewModel(inputState,
                                                                         payload: payload,
                                                                         locale: locale)

            view?.set(receiverViewModel: viewModel)

            let title = headerFactory.createReceiverTitle(assetId: selectedAsset.identifier,
                                                          receiverId: payload.receiveInfo.accountId,
                                                          locale: locale)

            view?.setReceiverHeader(title)
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle receiver update view model error \(error)")
            }
        }
    }

    func setupAccessoryViewModel() {
        do {
            let locale = localizationManager?.selectedLocale ?? Locale.current

            let accessoryViewModel: AccessoryViewModelProtocol

            switch receiverPosition {
            case .accessoryBar:
                accessoryViewModel = try viewModelFactory.createAccessoryViewModel(inputState,
                                                                                   payload: payload,
                                                                                   locale: locale)
            default:
                accessoryViewModel = try viewModelFactory.createAccessoryViewModel(inputState,
                                                                                   payload: nil,
                                                                                   locale: locale)
            }

            view?.set(accessoryViewModel: accessoryViewModel)
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle accessory view model error \(error)")
            }
        }
    }
}
