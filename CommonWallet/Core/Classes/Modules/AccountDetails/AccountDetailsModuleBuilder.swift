/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

final class AccountDetailsModuleBuilder {
    private var containingViewFactory: AccountDetailsContainingViewFactoryProtocol?
    private var listViewModelFactory: AccountListViewModelFactoryProtocol?
    private var localizableTitle: LocalizableResource<String>?
    private var additionalInsets: UIEdgeInsets = UIEdgeInsets(top: 10.0,
                                                              left: 0.0,
                                                              bottom: 0.0,
                                                              right: 0.0)

    func build() throws -> AccountDetailsConfigurationProtocol {
        AccountDetailsConfiguration(containingViewFactory: containingViewFactory,
                                    listViewModelFactory: listViewModelFactory,
                                    localizableTitle: localizableTitle,
                                    additionalInsets: additionalInsets)
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

    func with(localizableTitle: LocalizableResource<String>) -> Self {
        self.localizableTitle = localizableTitle

        return self
    }

    func with(additionalInsets: UIEdgeInsets) -> Self {
        self.additionalInsets = additionalInsets

        return self
    }
}
