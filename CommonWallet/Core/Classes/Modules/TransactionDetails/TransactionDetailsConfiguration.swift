/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol TransactionDetailsConfigurationProtocol {
    var sendBackTransactionTypes: [String] { get }
    var sendAgainTransactionTypes: [String] { get }
    var fieldActionFactory: WalletFieldActionFactoryProtocol { get }
    var customViewBinder: WalletFormViewModelBinderProtocol? { get }
    var customItemViewFactory: WalletFormItemViewFactoryProtocol? { get }
    var definitionFactory: WalletFormDefinitionFactoryProtocol? { get }
    var viewModelFactory: WalletTransactionDetailsFactoryOverriding? { get }
}


struct TransactionDetailsConfiguration: TransactionDetailsConfigurationProtocol {
    let sendBackTransactionTypes: [String]
    let sendAgainTransactionTypes: [String]
    let fieldActionFactory: WalletFieldActionFactoryProtocol
    let customViewBinder: WalletFormViewModelBinderProtocol?
    let customItemViewFactory: WalletFormItemViewFactoryProtocol?
    let definitionFactory: WalletFormDefinitionFactoryProtocol?
    let viewModelFactory: WalletTransactionDetailsFactoryOverriding?
}
