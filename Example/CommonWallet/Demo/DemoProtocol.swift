/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import CommonWallet

enum DemoFactoryError: Error {
    case keypairGenerationFailed
    case signerCreationFailed
}

typealias DemoCompletionBlock = () -> Void

protocol DemoFactoryProtocol: class {
    var title: String { get }
    func setupDemo(with completionBlock: @escaping DemoCompletionBlock) throws -> UIViewController
}

extension DemoFactoryProtocol {
    func mock(networkResolver: WalletNetworkResolverProtocol) throws {
        NetworkMockManager.shared.enable()

        try FetchBalanceMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .balance,
                                      mockMethod: .post)

        try FetchHistoryMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .history,
                                      mockMethod: .get,
                                      urlMockType: .regex)

        try TransferMock.register(mock: .success,
                                  networkResolver: networkResolver,
                                  requestType: .transfer,
                                  mockMethod: .post)

        try SearchMock.register(mock: .success,
                                networkResolver: networkResolver,
                                requestType: .search,
                                mockMethod: .get,
                                urlMockType: .regex)
        
        try ContactsMock.register(mock: .empty,
                                  networkResolver: networkResolver,
                                  requestType: .contacts,
                                  mockMethod: .get)
    }
}
