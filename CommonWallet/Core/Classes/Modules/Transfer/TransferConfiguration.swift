/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

protocol TransferConfigurationProtocol {
    var resultValidator: TransferValidating { get }
    var receiverPosition: TransferReceiverPosition { get }
    var headerFactory: OperationDefinitionHeaderModelFactoryProtocol { get }
    var separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol { get }
    var settings: WalletTransactionSettingsProtocol { get }
    var changeHandler: OperationDefinitionChangeHandling { get }
    var style: OperationDefinitionViewStyle { get }
    var generatingIconStyle: WalletNameIconStyleProtocol { get }
    var accessoryViewType: WalletAccessoryViewType { get }
    var localizableTitle: LocalizableResource<String>? { get }
    var transferViewModelFactory: TransferViewModelFactoryOverriding? { get }
    var errorHandler: OperationDefinitionErrorHandling? { get }
    var feeEditing: FeeEditing? { get }
    var accessoryViewFactory: AccessoryViewFactoryProtocol.Type? { get }
    var operationDefinitionFactory: OperationDefinitionViewFactoryOverriding? { get }
}

struct TransferConfiguration: TransferConfigurationProtocol {
    let resultValidator: TransferValidating
    let receiverPosition: TransferReceiverPosition
    let headerFactory: OperationDefinitionHeaderModelFactoryProtocol
    let separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol
    let settings: WalletTransactionSettingsProtocol
    let changeHandler: OperationDefinitionChangeHandling
    let style: OperationDefinitionViewStyle
    let generatingIconStyle: WalletNameIconStyleProtocol
    let accessoryViewType: WalletAccessoryViewType
    let localizableTitle: LocalizableResource<String>?
    let transferViewModelFactory: TransferViewModelFactoryOverriding?
    let errorHandler: OperationDefinitionErrorHandling?
    let feeEditing: FeeEditing?
    let accessoryViewFactory: AccessoryViewFactoryProtocol.Type?
    let operationDefinitionFactory: OperationDefinitionViewFactoryOverriding?
}
