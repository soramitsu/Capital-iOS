/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol WalletFormDefiningProtocol {
    func defineViewForDetailsModel(_ model: WalletNewFormDetailsViewModel) -> WalletFormItemView?

    func defineViewForMultilineTitleIconModel(_ model: MultilineTitleIconViewModel) -> WalletFormItemView?

    func defineViewForSingleHeaderModel(_ model: WalletFormSingleHeaderModel) -> WalletFormItemView?

    func defineViewForDetailsHeaderModel(_ model: WalletFormDetailsHeaderModel) -> WalletFormItemView?

    func defineViewForSpentAmountModel(_ model: WalletFormSpentAmountModel) -> WalletFormItemView?

    func defineViewForSeparatedViewModel<T>(_ model: WalletFormSeparatedViewModel<T>)
        -> WalletFormItemView? where T: WalletFormViewBindingProtocol
}

class WalletFormDefinition: WalletFormDefiningProtocol {

    let binder: WalletFormViewModelBinderProtocol
    let itemViewFactory: WalletFormItemViewFactoryProtocol

    init(binder: WalletFormViewModelBinderProtocol, itemViewFactory: WalletFormItemViewFactoryProtocol) {
        self.binder = binder
        self.itemViewFactory = itemViewFactory
    }

    func defineViewForDetailsModel(_ model: WalletNewFormDetailsViewModel) -> WalletFormItemView? {
        let view = itemViewFactory.createDetailsFormView()
        binder.bind(viewModel: model, to: view)
        view.borderType = []
        return view
    }

    func defineViewForMultilineTitleIconModel(_ model: MultilineTitleIconViewModel) -> WalletFormItemView? {
        let view = itemViewFactory.createFormTitleIconView()
        binder.bind(viewModel: model, to: view)
        view.borderType = []
        return view
    }

    func defineViewForSingleHeaderModel(_ model: WalletFormSingleHeaderModel) -> WalletFormItemView? {
        let view = itemViewFactory.createFormTitleIconView()
        binder.bind(viewModel: model, to: view)
        view.borderType = []
        return view
    }

    func defineViewForDetailsHeaderModel(_ model: WalletFormDetailsHeaderModel) -> WalletFormItemView? {
        let view = itemViewFactory.createFormTitleIconView()
        binder.bind(viewModel: model, to: view)
        view.borderType = []
        return view
    }

    func defineViewForSpentAmountModel(_ model: WalletFormSpentAmountModel) -> WalletFormItemView? {
        let view = itemViewFactory.createDetailsFormView()
        binder.bind(viewModel: model, to: view)
        view.borderType = []
        return view
    }

    func defineViewForSeparatedViewModel<T>(_ model: WalletFormSeparatedViewModel<T>)
        -> WalletFormItemView? where T: WalletFormViewBindingProtocol {
        let view = model.content.accept(definition: self)
        view?.borderType = model.borderType
        return view
    }
}
