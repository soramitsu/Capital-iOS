/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

final class TransferModuleBuilder {
    private var receiverPosition: TransferReceiverPosition = .accessoryBar

    func build() -> TransferConfigurationProtocol {
        TransferConfiguration(receiverPosition: receiverPosition)
    }
}

extension TransferModuleBuilder: TransferModulerBuilderProtocol {
    func with(receiverPosition: TransferReceiverPosition) -> Self {
        self.receiverPosition = receiverPosition
        return self
    }
}
