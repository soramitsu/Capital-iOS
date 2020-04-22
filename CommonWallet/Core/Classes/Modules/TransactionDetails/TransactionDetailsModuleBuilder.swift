/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class TransactionDetailsModuleBuilder {
    private var sendBackTransactionTypes: [String] = []
    private var sendAgainTransactionTypes: [String] = []
    private lazy var fieldActionFactory: WalletFieldActionFactoryProtocol = WalletFieldActionFactory()

    func build() -> TransactionDetailsConfigurationProtocol {
        return TransactionDetailsConfiguration(sendBackTransactionTypes: sendBackTransactionTypes,
                                               sendAgainTransactionTypes: sendAgainTransactionTypes,
                                               fieldActionFactory: fieldActionFactory)
    }
}

extension TransactionDetailsModuleBuilder: TransactionDetailsModuleBuilderProtocol {
    func with(sendBackTransactionTypes: [String]) -> Self {
        self.sendBackTransactionTypes = sendBackTransactionTypes
        return self
    }

    func with(sendAgainTransactionTypes: [String]) -> Self {
        self.sendAgainTransactionTypes = sendAgainTransactionTypes
        return self
    }

    func with(fieldActionFactory: WalletFieldActionFactoryProtocol) -> Self {
        self.fieldActionFactory = fieldActionFactory
        return self
    }
}
