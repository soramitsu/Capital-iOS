/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

final class AccountDetailsModuleBuilder {
    private var containingViewFactory: AccountDetailsContainingViewFactoryProtocol?
    private var listViewModelFactory: AccountListViewModelFactoryProtocol?

    func build() throws -> AccountDetailsConfigurationProtocol {
        AccountDetailsConfiguration(containingViewFactory: containingViewFactory,
                                    listViewModelFactory: listViewModelFactory)
    }
}

extension AccountDetailsModuleBuilder: AccountDetailsModuleBuilderProtocol {
    func with(containingViewFactory: AccountDetailsContainingViewFactoryProtocol) -> Self {
        self.containingViewFactory = containingViewFactory
        return self
    }

    func with(listViewModelFactory: AccountListViewModelFactoryProtocol) -> Self {
        self.listViewModelFactory = listViewModelFactory
        return self
    }
}
