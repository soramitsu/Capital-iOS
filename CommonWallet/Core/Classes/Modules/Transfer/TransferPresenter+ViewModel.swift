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

        let amountTitle = headerFactory.createAmountTitle(assetId: selectedAsset.identifier,
                                                          receiverId: payload.receiveInfo.accountId,
                                                          locale: locale)

        view?.setAmountHeader(amountTitle)
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

            let viewModels: [FeeViewModel] = try feeResult.fees.map { fee in
                guard let asset = account.assets
                    .first(where: { $0.identifier == fee.feeDescription.assetId }) else {
                    throw TransferPresenterError.missingAsset
                }

                return transferViewModelFactory.createFeeViewModel(fee, feeAsset: asset, locale: locale)
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
        let locale = localizationManager?.selectedLocale ?? Locale.current
        let balanceData = balances?.first { $0.identifier == selectedAsset.identifier }

        let viewModel = assetSelectionFactory.createViewModel(for: selectedAsset,
                                                              balanceData: balanceData,
                                                              locale: locale,
                                                              isSelecting: isSelecting,
                                                              canSelect: account.assets.count > 1)

        view?.set(assetViewModel: viewModel)

        let assetTitle = headerFactory.createAssetTitle(assetId: selectedAsset.identifier,
                                                        receiverId: payload.receiveInfo.accountId,
                                                        locale: locale)

        view?.setAssetHeader(assetTitle)
    }

    func setupDescriptionViewModel() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        view?.set(descriptionViewModel: descriptionInputViewModel)

        let descriptionTitle = headerFactory
            .createDescriptionTitle(assetId: selectedAsset.identifier,
                                    receiverId: payload.receiveInfo.accountId,
                                    locale: locale)

        view?.setDescriptionHeader(descriptionTitle)
    }

    func updateDescriptionViewModel() {
        do {
            let locale = localizationManager?.selectedLocale ?? Locale.current

            let text = descriptionInputViewModel.text
            descriptionInputViewModel = try transferViewModelFactory.createDescriptionViewModel(for: text)

            view?.set(descriptionViewModel: descriptionInputViewModel)

            let descriptionTitle = headerFactory
                .createDescriptionTitle(assetId: selectedAsset.identifier,
                                        receiverId: payload.receiveInfo.accountId,
                                        locale: locale)

            view?.setDescriptionHeader(descriptionTitle)
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle description updaet view model error \(error)")
            }
        }
    }

    func setupReceiverViewModel() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        let accessoryViewModel = accessoryFactory.createViewModel(from: payload.receiverName,
                                                                  fullName: payload.receiverName,
                                                                  action: "")

        let viewModel = MultilineTitleIconViewModel(text: accessoryViewModel.title,
                                                    icon: accessoryViewModel.icon)

        view?.set(receiverViewModel: viewModel)

        let title = headerFactory.createReceiverTitle(assetId: selectedAsset.identifier,
                                                      receiverId: payload.receiveInfo.accountId,
                                                      locale: locale)

        view?.setReceiverHeader(title)
    }

    func setupAccessoryViewModel() {
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
}
