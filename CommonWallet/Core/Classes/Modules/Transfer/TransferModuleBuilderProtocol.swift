/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol TransferModuleBuilderProtocol {
    func with(receiverPosition: TransferReceiverPosition) -> Self
    func with(titleFactory: OperationDefinitionTitleModelFactoryProtocol) -> Self
}
