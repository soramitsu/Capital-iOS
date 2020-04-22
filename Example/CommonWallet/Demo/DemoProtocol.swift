/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import CommonWallet

typealias DemoCompletionBlock = (UIViewController?) -> Void

protocol DemoFactoryProtocol: class {
    var title: String { get }
    func setupDemo(with completionBlock: @escaping DemoCompletionBlock) throws -> UIViewController
}

extension DemoFactoryProtocol {
    
    private func defaultFilter(for assets: [WalletAsset]) throws -> Data {
        let filter = WalletHistoryRequest(assets: assets.map { $0.identifier })
        let encoder = JSONEncoder()
        
        return try encoder.encode(filter)
    }
    
    func mock(networkResolver: MiddlewareNetworkResolverProtocol, with assets: [WalletAsset]) throws {
        NetworkMockManager.shared.enable()

        try FetchBalanceMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .balance,
                                      httpMethod: .post)

        try FetchHistoryMock.register(mock: .filter,
                                      networkResolver: networkResolver,
                                      requestType: .history,
                                      httpMethod: .post,
                                      urlMockType: .regex)
        
        try FetchHistoryMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .history,
                                      httpMethod: .post,
                                      urlMockType: .regex,
                                      body: defaultFilter(for: assets))

        try TransferMetadataMock.register(mock: .success,
                                          networkResolver: networkResolver,
                                          requestType: .transferMetadata,
                                          httpMethod: .get,
                                          urlMockType: .regex)

        try TransferMock.register(mock: .success,
                                  networkResolver: networkResolver,
                                  requestType: .transfer,
                                  httpMethod: .post)

        try SearchMock.register(mock: .success,
                                networkResolver: networkResolver,
                                requestType: .search,
                                httpMethod: .get,
                                urlMockType: .regex)

        try ContactsMock.register(mock: .success,
                                  networkResolver: networkResolver,
                                  requestType: .contacts,
                                  httpMethod: .get)

        try WithdrawalMetadataMock.register(mock: .success,
                                            networkResolver: networkResolver,
                                            requestType: .withdrawalMetadata,
                                            httpMethod: .get,
                                            urlMockType: .regex)

        try WithdrawMock.register(mock: .success,
                                  networkResolver: networkResolver,
                                  requestType: .withdraw,
                                  httpMethod: .post)
    }
}
