/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol WithdrawConfigurationProtocol {
    var headerFactory: OperationDefinitionHeaderModelFactoryProtocol { get }
    var separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol { get }
    var style: OperationDefinitionViewStyle { get }
}

struct WithdrawConfiguration: WithdrawConfigurationProtocol {
    let headerFactory: OperationDefinitionHeaderModelFactoryProtocol
    let separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol
    let style: OperationDefinitionViewStyle
}
