/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import XCTest
import CommonWallet
import RobinHood

class WalletCodableContextTests: XCTestCase {

    func testBalanceContext() {
        // given

        let repository: CoreDataRepository<SingleValueProviderObject, CDCWSingleValue> =
            CoreDataTestCacheFacade().createCoreDataCache(filter: nil)

        let context: [String: String] = ["xor": "20", "eth": "30"]

        let expectedBalance = BalanceData(identifier: UUID().uuidString,
                                          balance: AmountDecimal(value: 10),
                                          context: context)

        let source: AnySingleValueProviderSource<[BalanceData]> = AnySingleValueProviderSource {
            let operation: BaseOperation<[BalanceData]?> = ClosureOperation {
                return [expectedBalance]
            }

            return CompoundOperationWrapper(targetOperation: operation)
        }

        let targetIdentitifier = UUID().uuidString

        let singleValueProvider = SingleValueProvider(targetIdentifier: targetIdentitifier,
                                                      source: source,
                                                      repository: AnyDataProviderRepository(repository))

        // when

        let expectation = XCTestExpectation()

        var receivedValue: [BalanceData]?

        let changeClosure: ([DataProviderChange<[BalanceData]>]) -> Void = { changes in
            guard changes.count > 0 else {
                return
            }

            if case .insert(let newItem) = changes.first {
                receivedValue = newItem
            }

            expectation.fulfill()
        }

        let errorClosure: (Error) -> Void = { error in
            XCTFail("Unexpected error \(error)")
            expectation.fulfill()
        }

        singleValueProvider.addObserver(self,
                                        deliverOn: .main,
                                        executing: changeClosure,
                                        failing: errorClosure)

        // then

        wait(for: [expectation], timeout: Constants.networkTimeout)

        XCTAssertEqual(receivedValue?.count, 1)
        XCTAssertEqual(receivedValue?.first, expectedBalance)
    }
}
