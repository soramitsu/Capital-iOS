/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

protocol TransferConfirmationConfigurationProtocol {
    var customViewBinder: WalletFormViewModelBinderOverriding? { get }
    var customItemViewFactory: WalletFormItemViewFactoryOverriding? { get }
    var definitionFactory: WalletFormDefinitionFactoryProtocol? { get }
    var viewModelFactoryOverriding: TransferConfirmationViewModelFactoryOverriding? { get }
    var completion: TransferCompletion { get }
    var accessoryViewType: WalletAccessoryViewType { get }
    var localizableTitle: LocalizableResource<String>? { get }
    var accessoryViewFactory: AccessoryViewFactoryProtocol.Type? { get }
}

struct TransferConfirmationConfiguration: TransferConfirmationConfigurationProtocol {
    let customViewBinder: WalletFormViewModelBinderOverriding?
    let customItemViewFactory: WalletFormItemViewFactoryOverriding?
    let definitionFactory: WalletFormDefinitionFactoryProtocol?
    let viewModelFactoryOverriding: TransferConfirmationViewModelFactoryOverriding?
    let completion: TransferCompletion
    let accessoryViewType: WalletAccessoryViewType
    let localizableTitle: LocalizableResource<String>?
    let accessoryViewFactory: AccessoryViewFactoryProtocol.Type?
}
