/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

protocol AmountConfigurationProtocol {
    var receiverPosition: TransferReceiverPosition { get }
}

struct AmountConfiguration {
    let receiverPosition: TransferReceiverPosition
}
