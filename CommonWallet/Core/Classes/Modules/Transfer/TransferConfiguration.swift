/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol TransferConfigurationProtocol {
    var receiverPosition: TransferReceiverPosition { get }
    var titleFactory: OperationDefinitionTitleModelFactoryProtocol { get }
    var separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol { get }
    var style: OperationDefinitionViewStyle { get }
    var accessoryViewType: WalletAccessoryViewType { get }
}

struct TransferConfiguration: TransferConfigurationProtocol {
    let receiverPosition: TransferReceiverPosition
    let titleFactory: OperationDefinitionTitleModelFactoryProtocol
    let separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol
    let style: OperationDefinitionViewStyle
    let accessoryViewType: WalletAccessoryViewType
}
