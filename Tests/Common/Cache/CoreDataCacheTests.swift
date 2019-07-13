/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class CoreDataCacheTests: XCTestCase {

    func testCacheFacadeInitialization() {
        XCTAssertNoThrow(CoreDataCacheFacade.shared.databaseService)
    }

    func testDataProviderFactory() {
        do {
            let networkResolver = MockWalletNetworkResolverProtocol()

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                    return Constants.balanceUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                    return nil
                }
            }

            let assetsCount = 4
            let accountSettings = try createRandomAccountSettings(for: assetsCount)
            let operationFactory = WalletServiceOperationFactory(accountSettings: accountSettings)
            let dataProviderFactory = DataProviderFactory(networkResolver: networkResolver,
                                                          accountSettings: accountSettings,
                                                          cacheFacade: CoreDataCacheFacade.shared,
                                                          networkOperationFactory: operationFactory)

            XCTAssertNoThrow(try dataProviderFactory.createBalanceDataProvider())
            XCTAssertNoThrow(try dataProviderFactory.createAccountHistoryDataProvider())
            XCTAssertNoThrow(try dataProviderFactory.createHistoryDataProvider(for: accountSettings.assets[0].identifier))
        } catch {
            XCTFail("\(error)")
        }
    }
}
