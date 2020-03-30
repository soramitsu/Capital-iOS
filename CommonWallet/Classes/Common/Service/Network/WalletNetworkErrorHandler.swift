/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol WalletNetworkErrorFactoryProtocol {
    func createErrorFromStatus(_ status: String) -> Error
}
