/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol WalletQREncoderProtocol {
    func encode(receiverInfo: ReceiveInfo) throws -> Data
}

public protocol WalletQRDecoderProtocol {
    func decode(data: Data) throws -> ReceiveInfo
}

public protocol WalletQRCoderFactoryProtocol {
    func createEncoder() -> WalletQREncoderProtocol
    func createDecoder() -> WalletQRDecoderProtocol
}

struct WalletQREncoder: WalletQREncoderProtocol {
    let underlyingEncoder = JSONEncoder()

    func encode(receiverInfo: ReceiveInfo) throws -> Data {
        return try underlyingEncoder.encode(receiverInfo)
    }
}

struct WalletQRDecoder: WalletQRDecoderProtocol {
    let underlyingDecoder = JSONDecoder()

    func decode(data: Data) throws -> ReceiveInfo {
        return try underlyingDecoder.decode(ReceiveInfo.self, from: data)
    }
}

struct WalletQRCoderFactory: WalletQRCoderFactoryProtocol {
    func createEncoder() -> WalletQREncoderProtocol {
        return WalletQREncoder()
    }

    func createDecoder() -> WalletQRDecoderProtocol {
        return WalletQRDecoder()
    }
}
