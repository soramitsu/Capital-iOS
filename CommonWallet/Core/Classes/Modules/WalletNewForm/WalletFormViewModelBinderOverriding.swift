/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol WalletFormViewModelBinderOverriding {
    func bind(viewModel: WalletNewFormDetailsViewModel,
              to view: WalletFormDetailsViewProtocol) -> Bool

    func bind(viewModel: MultilineTitleIconViewModel,
              to view: WalletFormTitleIconViewProtocol) -> Bool

    func bind(viewModel: WalletFormSingleHeaderModel,
              to view: WalletFormTitleIconViewProtocol) -> Bool

    func bind(viewModel: WalletFormDetailsHeaderModel,
              to view: WalletFormTitleIconViewProtocol) -> Bool

    func bind(viewModel: WalletFormSpentAmountModel,
              to view: WalletFormDetailsViewProtocol) -> Bool

    func bind(viewModel: WalletFormTokenViewModel,
              to view: WalletFormTokenViewProtocol) -> Bool
}

public extension WalletFormViewModelBinderOverriding {
    func bind(viewModel: WalletNewFormDetailsViewModel,
              to view: WalletFormDetailsViewProtocol) -> Bool {
        false
    }

    func bind(viewModel: MultilineTitleIconViewModel,
              to view: WalletFormTitleIconViewProtocol) -> Bool {
        false
    }

    func bind(viewModel: WalletFormSingleHeaderModel,
              to view: WalletFormTitleIconViewProtocol) -> Bool {
        false
    }

    func bind(viewModel: WalletFormDetailsHeaderModel,
              to view: WalletFormTitleIconViewProtocol) -> Bool {
        false
    }

    func bind(viewModel: WalletFormSpentAmountModel,
              to view: WalletFormDetailsViewProtocol) -> Bool {
        false
    }

    func bind(viewModel: WalletFormTokenViewModel,
              to view: WalletFormTokenViewProtocol) -> Bool {
        false
    }
}

struct WalletFormViewModelBinderWrapper: WalletFormViewModelBinderProtocol {
    let overriding: WalletFormViewModelBinderOverriding
    let defaultBinder: WalletFormViewModelBinderProtocol

    func bind(viewModel: WalletNewFormDetailsViewModel, to view: WalletFormDetailsViewProtocol) {
        if !overriding.bind(viewModel: viewModel, to: view) {
            defaultBinder.bind(viewModel: viewModel, to: view)
        }
    }

    func bind(viewModel: MultilineTitleIconViewModel, to view: WalletFormTitleIconViewProtocol) {
        if !overriding.bind(viewModel: viewModel, to: view) {
            defaultBinder.bind(viewModel: viewModel, to: view)
        }
    }

    func bind(viewModel: WalletFormSingleHeaderModel, to view: WalletFormTitleIconViewProtocol) {
        if !overriding.bind(viewModel: viewModel, to: view) {
            defaultBinder.bind(viewModel: viewModel, to: view)
        }
    }

    func bind(viewModel: WalletFormDetailsHeaderModel, to view: WalletFormTitleIconViewProtocol) {
        if !overriding.bind(viewModel: viewModel, to: view) {
            defaultBinder.bind(viewModel: viewModel, to: view)
        }
    }

    func bind(viewModel: WalletFormSpentAmountModel, to view: WalletFormDetailsViewProtocol) {
        if !overriding.bind(viewModel: viewModel, to: view) {
            defaultBinder.bind(viewModel: viewModel, to: view)
        }
    }

    func bind(viewModel: WalletFormTokenViewModel, to view: WalletFormTokenViewProtocol) {
        if !overriding.bind(viewModel: viewModel, to: view) {
            defaultBinder.bind(viewModel: viewModel, to: view)
        }
    }
}
