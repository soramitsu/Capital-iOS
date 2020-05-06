/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol TransferConfigurationProtocol {
    var receiverPosition: TransferReceiverPosition { get }
    var titleFactory: OperationDefinitionTitleModelFactoryProtocol { get }
}

struct TransferConfiguration: TransferConfigurationProtocol {
    let receiverPosition: TransferReceiverPosition
    let titleFactory: OperationDefinitionTitleModelFactoryProtocol
}
