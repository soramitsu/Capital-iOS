/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol WalletFormDefinitionOverriding: WalletFormDefiningProtocol {}

extension WalletFormDefinitionOverriding {
    func defineViewForDetailsModel(_ model: WalletNewFormDetailsViewModel) -> WalletFormItemView? {
        nil
    }

    func defineViewForMultilineTitleIconModel(_ model: MultilineTitleIconViewModel)
        -> WalletFormItemView? {
        nil
    }

    func defineViewForSingleHeaderModel(_ model: WalletFormSingleHeaderModel) -> WalletFormItemView? {
        nil
    }

    func defineViewForDetailsHeaderModel(_ model: WalletFormDetailsHeaderModel) -> WalletFormItemView? {
        nil
    }

    func defineViewForSpentAmountModel(_ model: WalletFormSpentAmountModel) -> WalletFormItemView? {
        nil
    }

    func defineViewForTokenViewModel(_ model: WalletFormTokenViewModel) -> WalletFormItemView? {
        nil
    }

    func defineViewForSeparatedViewModel<T>(_ model: WalletFormSeparatedViewModel<T>)
        -> WalletFormItemView? where T: WalletFormViewBindingProtocol {
        nil
    }
}

struct WalletFormDefinitionWrapper: WalletFormDefiningProtocol {
    let overriding: WalletFormDefinitionOverriding
    let defaultDefinition: WalletFormDefiningProtocol

    func defineViewForDetailsModel(_ model: WalletNewFormDetailsViewModel) -> WalletFormItemView? {
        overriding.defineViewForDetailsModel(model) ??
        defaultDefinition.defineViewForDetailsModel(model)
    }

    func defineViewForMultilineTitleIconModel(_ model: MultilineTitleIconViewModel)
        -> WalletFormItemView? {
        overriding.defineViewForMultilineTitleIconModel(model) ??
        defaultDefinition.defineViewForMultilineTitleIconModel(model)
    }

    func defineViewForSingleHeaderModel(_ model: WalletFormSingleHeaderModel) -> WalletFormItemView? {
        overriding.defineViewForSingleHeaderModel(model) ??
        defaultDefinition.defineViewForSingleHeaderModel(model)
    }

    func defineViewForDetailsHeaderModel(_ model: WalletFormDetailsHeaderModel) -> WalletFormItemView? {
        overriding.defineViewForDetailsHeaderModel(model) ??
        defaultDefinition.defineViewForDetailsHeaderModel(model)
    }

    func defineViewForSpentAmountModel(_ model: WalletFormSpentAmountModel) -> WalletFormItemView? {
        overriding.defineViewForSpentAmountModel(model) ??
        defaultDefinition.defineViewForSpentAmountModel(model)
    }

    func defineViewForTokenViewModel(_ model: WalletFormTokenViewModel) -> WalletFormItemView? {
        overriding.defineViewForTokenViewModel(model) ??
        defaultDefinition.defineViewForTokenViewModel(model)
    }

    func defineViewForSeparatedViewModel<T>(_ model: WalletFormSeparatedViewModel<T>)
        -> WalletFormItemView? where T : WalletFormViewBindingProtocol {
        overriding.defineViewForSeparatedViewModel(model) ??
        defaultDefinition.defineViewForSeparatedViewModel(model)
    }
}
