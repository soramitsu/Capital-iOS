/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class AmountInputViewModelTests: XCTestCase {

    func testAmountInputViewModelCreation() {
        let limit = Decimal(1e6)
        performAmountInitializationTest(inputAmount: 12345, expectedAmount: 12345, limit: limit)
        performAmountInitializationTest(inputAmount: 12345.25, expectedAmount: 12345.25, limit: limit)
        performAmountInitializationTest(inputAmount: 1e6+0.1, expectedAmount: 0.0, limit: limit)
    }

    func performAmountInitializationTest(inputAmount: Decimal, expectedAmount: Decimal, limit: Decimal) {
        let amountInputViewModel = AmountInputViewModel(amount: inputAmount, limit: limit)
        XCTAssertEqual(expectedAmount, amountInputViewModel.decimalAmount)
    }
}
