/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

enum ReceiveAmountModuleBuilderError: Error {}


final class ReceiveAmountModuleBuilder {
    fileprivate lazy var accountShareFactory: AccountShareFactoryProtocol = AccountShareFactory()
    fileprivate var title: String = L10n.Receive.title

    func build() -> ReceiveAmountConfigurationProtocol {
        return ReceiveAmountConfiguration(accountShareFactory: accountShareFactory, title: title)
    }
}


extension ReceiveAmountModuleBuilder: ReceiveAmountModuleBuilderProtocol {
    @discardableResult
    func with(accountShareFactory: AccountShareFactoryProtocol) -> Self {
        self.accountShareFactory = accountShareFactory
        return self
    }

    @discardableResult
    func with(title: String) -> Self {
        self.title = title
        return self
    }
}
