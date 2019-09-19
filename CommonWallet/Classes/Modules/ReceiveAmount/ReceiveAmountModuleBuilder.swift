/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

enum ReceiveAmountModuleBuilderError: Error {}


final class ReceiveAmountModuleBuilder {
    private lazy var accountShareFactory: AccountShareFactoryProtocol = AccountShareFactory()

    func build() -> ReceiveAmountConfigurationProtocol {
        return ReceiveAmountConfiguration(accountShareFactory: accountShareFactory)
    }
}


extension ReceiveAmountModuleBuilder: ReceiveAmountModuleBuilderProtocol {
    @discardableResult
    func with(accountShareFactory: AccountShareFactoryProtocol) -> Self {
        self.accountShareFactory = accountShareFactory

        return self
    }
}
