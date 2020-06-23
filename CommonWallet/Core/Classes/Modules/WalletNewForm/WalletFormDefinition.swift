/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol WalletFormDefining {
    var binder: WalletFormViewModelBinderProtocol { get }
    var itemViewFactory: WalletFormItemViewFactoryProtocol { get }

    func defineViewForDetailsModel(_ model: WalletNewFormDetailsViewModel) -> WalletFormItemView?

    func defineViewForMultilineTitleIconModel(_ model: MultilineTitleIconViewModel) -> WalletFormItemView?

    func defineViewForSingleHeaderModel(_ model: WalletFormSingleHeaderModel) -> WalletFormItemView?

    func defineViewForDetailsHeaderModel(_ model: WalletFormDetailsHeaderModel) -> WalletFormItemView?

    func defineViewForSpentAmountModel(_ model: WalletFormSpentAmountModel) -> WalletFormItemView?

    func defineViewForTokenViewModel(_ model: WalletFormTokenViewModel) -> WalletFormItemView?

    func defineViewForSeparatedViewModel<T>(_ model: WalletFormSeparatedViewModel<T>)
        -> WalletFormItemView? where T: WalletFormViewBindingProtocol
}

public extension WalletFormDefining {

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

    func defineViewForTokenViewModel(_ model: WalletFormTokenViewModel) -> WalletFormItemView? {
        let view = itemViewFactory.createTokenView()
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

final class WalletFormDefinition: WalletFormDefining {
    let binder: WalletFormViewModelBinderProtocol
    let itemViewFactory: WalletFormItemViewFactoryProtocol

    init(binder: WalletFormViewModelBinderProtocol, itemViewFactory: WalletFormItemViewFactoryProtocol) {
        self.binder = binder
        self.itemViewFactory = itemViewFactory
    }
}
