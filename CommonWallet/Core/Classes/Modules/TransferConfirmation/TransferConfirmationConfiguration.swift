/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

protocol TransferConfirmationConfigurationProtocol {
    var customViewBinder: WalletFormViewModelBinderProtocol? { get }
    var customItemViewFactory: WalletFormItemViewFactoryProtocol? { get }
    var definitionFactory: WalletFormDefinitionFactoryProtocol? { get }
    var viewModelFactoryOverriding: TransferConfirmationViewModelFactoryOverriding? { get }
    var completion: TransferCompletion { get }
    var accessoryViewType: WalletAccessoryViewType { get }
    var localizableTitle: LocalizableResource<String>? { get }
}

struct TransferConfirmationConfiguration: TransferConfirmationConfigurationProtocol {
    let customViewBinder: WalletFormViewModelBinderProtocol?
    let customItemViewFactory: WalletFormItemViewFactoryProtocol?
    let definitionFactory: WalletFormDefinitionFactoryProtocol?
    let viewModelFactoryOverriding: TransferConfirmationViewModelFactoryOverriding?
    let completion: TransferCompletion
    let accessoryViewType: WalletAccessoryViewType
    let localizableTitle: LocalizableResource<String>?
}