/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol TransactionDetailsModuleBuilderProtocol: class {
    @discardableResult
    func with(sendBackTransactionTypes: [String]) -> Self

    @discardableResult
    func with(sendAgainTransactionTypes: [String]) -> Self

    @discardableResult
    func with(fieldActionFactory: WalletFieldActionFactoryProtocol) -> Self
}
