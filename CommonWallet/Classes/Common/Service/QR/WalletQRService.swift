/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import RobinHood

protocol WalletQRServiceProtocol: class {
    @discardableResult
    func generate(from info: ReceiveInfo,
                  qrSize: CGSize,
                  runIn queue: DispatchQueue,
                  completionBlock: @escaping (Result<UIImage, Error>?) -> Void) throws -> Operation
}

final class WalletQRService {
    let operationFactory: WalletQROperationFactoryProtocol
    let operationQueue: OperationQueue

    private lazy var encoder = JSONEncoder()

    init(operationFactory: WalletQROperationFactoryProtocol,
         operationQueue: OperationQueue = OperationQueue()) {
        self.operationFactory = operationFactory
        self.operationQueue = operationQueue
    }
}

extension WalletQRService: WalletQRServiceProtocol {
    @discardableResult
    func generate(from info: ReceiveInfo,
                  qrSize: CGSize,
                  runIn queue: DispatchQueue,
                  completionBlock: @escaping (Result<UIImage, Error>?) -> Void) throws -> Operation {
        let payload = try encoder.encode(info)
        let operation = operationFactory.createCreationOperation(for: payload, qrSize: qrSize)

        operation.completionBlock = {
            queue.async {
                completionBlock(operation.result)
            }
        }

        operationQueue.addOperation(operation)
        return operation
    }
}
