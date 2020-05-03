/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol TransferConfigurationProtocol {
    var receiverPosition: TransferReceiverPosition { get }
}

struct TransferConfiguration: TransferConfigurationProtocol {
    let receiverPosition: TransferReceiverPosition
}
