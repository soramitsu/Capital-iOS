/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol TransferConfirmationViewModelFactoryProtocol {
    func createViewModelsFromPayload(_ payload: ConfirmationPayload,
                                     locale: Locale) -> [WalletFormViewBindingProtocol]

    func createAccessoryViewModelFromPayload(_ payload: ConfirmationPayload,
                                             locale: Locale) -> AccessoryViewModelProtocol
}

struct TransferConfirmationViewModelFactory {
    let assets: [WalletAsset]
    let feeDisplayFactory: FeeDisplaySettingsFactoryProtocol
    let generatingIconStyle: WalletNameIconStyleProtocol
    let amountFormatterFactory: NumberFormatterFactoryProtocol

    func populateHint(into viewModelList: inout [WalletFormViewBindingProtocol],
                      payload: ConfirmationPayload) {
        let viewModel = WalletFormSingleHeaderModel(title: L10n.Confirmation.hint)
        viewModelList.append(viewModel)
    }

    func populateSendingAmount(in viewModelList: inout [WalletFormViewBindingProtocol],
                               payload: ConfirmationPayload,
                               locale: Locale) {
        let asset = assets.first(where: { $0.identifier == payload.transferInfo.asset })

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset)

        let decimalAmount = payload.transferInfo.amount.decimalValue

        guard let amount = formatter.value(for: locale).string(from: decimalAmount) else {
            return
        }

        let viewModel = WalletNewFormDetailsViewModel(title: L10n.Amount.send,
                                                      titleIcon: nil,
                                                      details: amount,
                                                      detailsIcon: nil)
        viewModelList.append(WalletFormSeparatedViewModel(content: viewModel, borderType: [.top]))
    }

    func populateMainFeeAmount(in viewModelList: inout [WalletFormViewBindingProtocol],
                               payload: ConfirmationPayload,
                               locale: Locale) {
        let asset = assets.first(where: { $0.identifier == payload.transferInfo.asset })

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset).value(for: locale)

        for fee in payload.transferInfo.fees
            where fee.feeDescription.assetId == payload.transferInfo.asset {

            let feeDisplaySettings = feeDisplayFactory
                .createFeeSettingsForId(fee.feeDescription.identifier)

            guard let decimalAmount = feeDisplaySettings
                .displayStrategy.decimalValue(from: fee.value.decimalValue) else {
                continue
            }

            guard let amount = formatter.string(from: decimalAmount) else {
                continue
            }

            let title = feeDisplaySettings.displayName.value(for: locale)

            let viewModel = WalletNewFormDetailsViewModel(title: title,
                                                          titleIcon: nil,
                                                          details: amount,
                                                          detailsIcon: nil)

            viewModelList.append(WalletFormSeparatedViewModel(content: viewModel, borderType: [.top]))
        }
    }

    func populateSecondaryFees(in viewModelList: inout [WalletFormViewBindingProtocol],
                               payload: ConfirmationPayload,
                               locale: Locale) {
        for fee in payload.transferInfo.fees
            where fee.feeDescription.assetId != payload.transferInfo.asset {

            let asset = assets.first(where: { $0.identifier == fee.feeDescription.assetId })

            let formatter = amountFormatterFactory.createTokenFormatter(for: asset).value(for: locale)

            let feeDisplaySettings = feeDisplayFactory
                .createFeeSettingsForId(fee.feeDescription.identifier)

            guard let decimalAmount = feeDisplaySettings
                .displayStrategy.decimalValue(from: fee.value.decimalValue) else {
                continue
            }

            guard let amount = formatter.string(from: decimalAmount) else {
                continue
            }

            let title = feeDisplaySettings.displayName.value(for: locale)

            let viewModel = WalletNewFormDetailsViewModel(title: title,
                                                          titleIcon: nil,
                                                          details: amount,
                                                          detailsIcon: nil)

            viewModelList.append(WalletFormSeparatedViewModel(content: viewModel, borderType: [.top]))
        }
    }

    func populateTotalAmount(in viewModelList: inout [WalletFormViewBindingProtocol],
                             payload: ConfirmationPayload,
                             locale: Locale) {
        let asset = assets.first(where: { $0.identifier == payload.transferInfo.asset })

        let formatter = amountFormatterFactory.createTokenFormatter(for: asset).value(for: locale)

        let totalAmountDecimal: Decimal = payload.transferInfo.fees
            .reduce(payload.transferInfo.amount.decimalValue) { (result, fee) in
            if fee.feeDescription.assetId == payload.transferInfo.asset {
                return result + fee.value.decimalValue
            } else {
                return result
            }
        }

        guard let totalAmount = formatter.string(from: totalAmountDecimal) else {
            return
        }

        let viewModel = WalletFormSpentAmountModel(title: L10n.Amount.total,
                                                   amount: totalAmount)

        viewModelList.append(WalletFormSeparatedViewModel(content: viewModel, borderType: [.top]))
    }

    func populateNote(in viewModelList: inout [WalletFormViewBindingProtocol],
                      payload: ConfirmationPayload,
                      locale: Locale) {
        let note = payload.transferInfo.details

        guard !note.isEmpty else {
            return
        }

        let headerViewModel = WalletFormDetailsHeaderModel(title: L10n.Common.description)
        viewModelList.append(WalletFormSeparatedViewModel(content: headerViewModel, borderType: [.top]))

        let viewModel = MultilineTitleIconViewModel(text: note)
        viewModelList.append(viewModel)
    }    
}

extension TransferConfirmationViewModelFactory: TransferConfirmationViewModelFactoryProtocol {
    func createViewModelsFromPayload(_ payload: ConfirmationPayload,
                                     locale: Locale) -> [WalletFormViewBindingProtocol] {
        var viewModelList: [WalletFormViewBindingProtocol] = []

        populateHint(into: &viewModelList, payload: payload)
        populateSendingAmount(in: &viewModelList, payload: payload, locale: locale)
        populateMainFeeAmount(in: &viewModelList, payload: payload, locale: locale)
        populateTotalAmount(in: &viewModelList, payload: payload, locale: locale)
        populateNote(in: &viewModelList, payload: payload, locale: locale)
        populateSecondaryFees(in: &viewModelList, payload: payload, locale: locale)

        return viewModelList
    }

    func createAccessoryViewModelFromPayload(_ payload: ConfirmationPayload,
                                             locale: Locale) -> AccessoryViewModelProtocol {
        let icon = UIImage.createAvatar(fullName: payload.receiverName,
                                        style: generatingIconStyle)

        return AccessoryViewModel(title: payload.receiverName,
                                  action: L10n.Common.next,
                                  icon: icon)
    }
}
