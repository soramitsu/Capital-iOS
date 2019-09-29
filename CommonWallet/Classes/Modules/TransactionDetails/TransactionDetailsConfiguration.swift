/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol TransactionDetailsConfigurationProtocol {
    var sendBackTransactionTypes: [String] { get }
}


struct TransactionDetailsConfiguration: TransactionDetailsConfigurationProtocol {
    var sendBackTransactionTypes: [String]
}
