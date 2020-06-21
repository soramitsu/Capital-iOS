/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol TransactionDetailsModuleBuilderProtocol: class {
    @discardableResult
    func with(viewBinder: WalletFormViewModelBinderProtocol) -> Self

    @discardableResult
    func with(itemViewFactory: WalletFormItemViewFactoryProtocol) -> Self

    @discardableResult
    func with(definitionFactory: WalletFormDefinitionFactoryProtocol) -> Self

    @discardableResult
    func with(viewModelFactory: WalletTransactionDetailsFactoryOverriding) -> Self

    @discardableResult
    func with(sendBackTransactionTypes: [String]) -> Self

    @discardableResult
    func with(sendAgainTransactionTypes: [String]) -> Self

    @discardableResult
    func with(fieldActionFactory: WalletFieldActionFactoryProtocol) -> Self
}
