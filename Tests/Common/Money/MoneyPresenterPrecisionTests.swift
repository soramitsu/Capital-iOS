/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class MoneyPresenterPrecisionTests: XCTestCase {

    func testTrallingZeros() {
        let formatter = NumberFormatter.money(with: 3)
        formatter.locale = Locale.us

        let decimalSeparator: String = formatter.decimalSeparator

        performTest(for: "12",
                    addAmounts: [decimalSeparator, "0", "0", "0"],
                    formatter: formatter,
                    expectedResult: "12\(decimalSeparator)000")

        performTest(for: nil,
                    addAmounts: ["1","2",decimalSeparator,"2","0","0"],
                    formatter: formatter,
                    expectedResult: "12\(decimalSeparator)200")
    }

    func testZeroPrecision() {
        let formatter = NumberFormatter.money(with: 0)
        formatter.locale = Locale.us

        let decimalSeparator: String = formatter.decimalSeparator

        performTest(for: "1",
                    addAmounts: ["2","3"],
                    formatter: formatter,
                    expectedResult: "123")

        performTest(for: "12",
                    addAmounts: ["\(decimalSeparator)34"],
                    formatter: formatter,
                    expectedResult: "12")

        performTest(for: "12\(decimalSeparator)34",
            addAmounts: [],
            formatter: formatter,
            expectedResult: "")
    }

    // MARK: Private

    func performTest(for setAmount: String?, addAmounts: [String], formatter: NumberFormatter, expectedResult: String) {
        let presenter = MoneyPresenter(formatter: formatter,
                                       precision: Int16(formatter.maximumFractionDigits))

        var result: String = ""

        if let amount = setAmount {
            result = presenter.set(amount)
            presenter.amount = result
        }

        for amount in addAmounts {
            result = presenter.add(amount)
            presenter.amount = result
        }

        XCTAssertEqual(result, expectedResult)
    }
}
