/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

protocol WalletQROperationFactoryProtocol: class {
    func createCreationOperation(for payload: Data, qrSize: CGSize) -> WalletQRCreationOperation
}

final class WalletQROperationFactory: WalletQROperationFactoryProtocol {
    func createCreationOperation(for payload: Data, qrSize: CGSize) -> WalletQRCreationOperation {
        return WalletQRCreationOperation(payload: payload, qrSize: qrSize)
    }
}
