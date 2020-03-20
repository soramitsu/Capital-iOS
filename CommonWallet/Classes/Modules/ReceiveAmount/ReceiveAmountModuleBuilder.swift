/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import SoraFoundation

enum ReceiveAmountModuleBuilderError: Error {}


final class ReceiveAmountModuleBuilder {
    fileprivate lazy var accountShareFactory: AccountShareFactoryProtocol = AccountShareFactory()
    fileprivate var title: LocalizableResource<String> = LocalizableResource { _ in L10n.Receive.title }
    fileprivate var shouldIncludeDescription: Bool = false

    func build() -> ReceiveAmountConfigurationProtocol {
        return ReceiveAmountConfiguration(accountShareFactory: accountShareFactory,
                                          title: title,
                                          shouldIncludeDescription: shouldIncludeDescription)
    }
}


extension ReceiveAmountModuleBuilder: ReceiveAmountModuleBuilderProtocol {
    @discardableResult
    func with(accountShareFactory: AccountShareFactoryProtocol) -> Self {
        self.accountShareFactory = accountShareFactory
        return self
    }

    @discardableResult
    func with(title: LocalizableResource<String>) -> Self {
        self.title = title
        return self
    }

    @discardableResult
    func with(shouldIncludeDescription: Bool) -> Self {
        self.shouldIncludeDescription = shouldIncludeDescription
        return self
    }
}
