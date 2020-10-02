/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol TransactionDetailsConfigurationProtocol {
    var sendBackTransactionTypes: [String] { get }
    var sendAgainTransactionTypes: [String] { get }
    var customViewBinder: WalletFormViewModelBinderOverriding? { get }
    var customItemViewFactory: WalletFormItemViewFactoryOverriding? { get }
    var definitionFactory: WalletFormDefinitionFactoryProtocol? { get }
    var viewModelFactory: WalletTransactionDetailsFactoryOverriding? { get }
    var accessoryViewFactory: AccessoryViewFactoryProtocol.Type? { get }
}


struct TransactionDetailsConfiguration: TransactionDetailsConfigurationProtocol {
    let sendBackTransactionTypes: [String]
    let sendAgainTransactionTypes: [String]
    let customViewBinder: WalletFormViewModelBinderOverriding?
    let customItemViewFactory: WalletFormItemViewFactoryOverriding?
    let definitionFactory: WalletFormDefinitionFactoryProtocol?
    let viewModelFactory: WalletTransactionDetailsFactoryOverriding?
    let accessoryViewFactory: AccessoryViewFactoryProtocol.Type?
}
