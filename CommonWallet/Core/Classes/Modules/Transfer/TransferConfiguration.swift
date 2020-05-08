/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

protocol TransferConfigurationProtocol {
    var receiverPosition: TransferReceiverPosition { get }
    var headerFactory: OperationDefinitionTitleModelFactoryProtocol { get }
    var separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol { get }
    var style: OperationDefinitionViewStyle { get }
    var accessoryViewType: WalletAccessoryViewType { get }
    var localizableTitle: LocalizableResource<String>? { get }
}

struct TransferConfiguration: TransferConfigurationProtocol {
    let receiverPosition: TransferReceiverPosition
    let headerFactory: OperationDefinitionTitleModelFactoryProtocol
    let separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol
    let style: OperationDefinitionViewStyle
    let accessoryViewType: WalletAccessoryViewType
    let localizableTitle: LocalizableResource<String>?
}
