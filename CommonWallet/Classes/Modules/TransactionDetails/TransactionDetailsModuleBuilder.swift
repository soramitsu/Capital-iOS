/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class TransactionDetailsModuleBuilder {
    private var sendBackTransactionTypes: [String] = []

    func build() -> TransactionDetailsConfigurationProtocol {
        return TransactionDetailsConfiguration(sendBackTransactionTypes: sendBackTransactionTypes)
    }
}

extension TransactionDetailsModuleBuilder: TransactionDetailsModuleBuilderProtocol {
    func with(sendBackTransactionTypes: [String]) -> Self {
        self.sendBackTransactionTypes = sendBackTransactionTypes
        return self
    }
}
