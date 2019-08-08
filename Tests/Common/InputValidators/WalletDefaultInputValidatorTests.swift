/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class WalletDefaultInputValidatorTests: XCTestCase {
    func testInputDeleteInput() {
        let validatorInput = WalletDefaultInputValidator(hint: "Some testing",
                                                         maxLength: 100)

        let firstInput = "Hello world"
        let firstRange = NSRange(location: 0, length: 0)
        XCTAssertTrue(validatorInput.didReceiveReplacement(firstInput, for: firstRange))

        let secondInput = "world"
        let removeRange = NSRange(location: firstInput.count - secondInput.count,
                                  length: secondInput.count)
        XCTAssertTrue(validatorInput.didReceiveReplacement("", for: removeRange))

        let secondRange = NSRange(location: firstInput.count - secondInput.count, length: 0)
        XCTAssertTrue(validatorInput.didReceiveReplacement(secondInput, for: secondRange))

        XCTAssertEqual(validatorInput.input, firstInput)
        XCTAssertTrue(validatorInput.isValid)
    }

    func testNotAsciiSymbolInput() {
        let validatorInput = WalletDefaultInputValidator(hint: "Some testing",
                                                         maxLength: 100)

        let input = "Привет こんにちは 😀"
        XCTAssertTrue(validatorInput.didReceiveReplacement(input, for: NSRange(location: 0, length: 0)))

        XCTAssertEqual(input, validatorInput.input)
        XCTAssertTrue(validatorInput.isValid)
    }
}
