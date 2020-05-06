/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

final class TransferModuleBuilder {
    private var receiverPosition: TransferReceiverPosition = .accessoryBar
    private lazy var titleFactory: OperationDefinitionTitleModelFactoryProtocol
        = TransferDefinitionTitleModelFactory()

    func build() -> TransferConfigurationProtocol {
        TransferConfiguration(receiverPosition: receiverPosition,
                              titleFactory: titleFactory)
    }
}

extension TransferModuleBuilder: TransferModuleBuilderProtocol {
    func with(receiverPosition: TransferReceiverPosition) -> Self {
        self.receiverPosition = receiverPosition
        return self
    }

    func with(titleFactory: OperationDefinitionTitleModelFactoryProtocol) -> Self {
        self.titleFactory = titleFactory
        return self
    }
}
