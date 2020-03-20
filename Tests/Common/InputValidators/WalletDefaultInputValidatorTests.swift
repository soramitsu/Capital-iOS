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

    func testLengthValidation() {
        let input = "Привет"
        let invalidInput = "Приветこ"

        let byteValidator = WalletDefaultInputValidator(hint: "Some testing",
                                                        maxLength: UInt8(input.lengthOfBytes(using: .utf8)),
                                                        lengthMetric: .utf8byte)

        let characterValidator = WalletDefaultInputValidator(hint: "Some testing",
                                                             maxLength: UInt8(input.count),
                                                             lengthMetric: .character)

        let range = NSRange(location: 0, length: 0)
        XCTAssertFalse(byteValidator.didReceiveReplacement(invalidInput, for: range))
        XCTAssertFalse(characterValidator.didReceiveReplacement(invalidInput, for: range))
        XCTAssertTrue(byteValidator.didReceiveReplacement(input, for: range))
        XCTAssertTrue(characterValidator.didReceiveReplacement(input, for: range))

        XCTAssertEqual(byteValidator.input, input)
        XCTAssertEqual(characterValidator.input, input)
    }
}
