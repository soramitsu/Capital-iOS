/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class ContactsServiceTests: NetworkBaseTests {

    func testSuccess() {
        do {
            // given

            let networkResolver = MockWalletNetworkResolverProtocol()

            let urlTemplateGetExpectation = XCTestExpectation()
            let adapterExpectation = XCTestExpectation()

            stub(networkResolver) { stub in
                when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                    urlTemplateGetExpectation.fulfill()

                    return Constants.contactsUrlTemplate
                }

                when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                    adapterExpectation.fulfill()

                    return nil
                }
            }

            try ContactsMock.register(mock: .success,
                                      networkResolver: networkResolver,
                                      requestType: .contacts,
                                      httpMethod: .get)

            let assetsCount = 4
            let accountSettings = try createRandomAccountSettings(for: assetsCount)
            let operationFactory = WalletNetworkOperationFactory(accountSettings: accountSettings)
            let walletService = WalletService(networkResolver: networkResolver,
                                              operationFactory: operationFactory)

            let contactsExpectation = XCTestExpectation()

            // when

            _ = walletService.fetchContacts(runCompletionIn: .main) { optionalResult in
                defer {
                    contactsExpectation.fulfill()
                }

                guard let result = optionalResult else {
                    XCTFail("Unexpected nil result")
                    return
                }

                if case .error(let error) = result {
                    XCTFail("Unexpected error \(error)")
                }
            }

            // then

            wait(for: [urlTemplateGetExpectation, adapterExpectation, contactsExpectation],
                 timeout: Constants.networkTimeout)

        } catch {
            XCTFail("\(error)")
        }
    }

}
