/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class EthereumInputValidatorTests: XCTestCase {
    func testValidAddressInput() {
        let validAddresses = ["0xea674fdde714fd979de3edf0f56aa9716b898ec8",
                              "0xea674Fdde714fd979de3edf0f56aa9716b898ec8",
                              "0xEA674FDDE714Fd979DE3EDF0F56AA9716B898EC8"]

        validAddresses.forEach {
            performInputTest(for: $0, expectedInput: $0, expectedValid: true)
        }
    }

    func testInvalidAddressInput() {
        let invalidAddresses = ["",
                                "ea674Fdde714fd979de3edf0f56aa9716b898ec8",
                                "0xEA674FDDE714Fd979DE3EDF0F56AA9716B898E8"]

        invalidAddresses.forEach {
            performInputTest(for: $0, expectedInput: $0, expectedValid: false)
        }
    }

    func testInvalidInput() {
        let invalidAddresses = ["hello world",
                                "0xea674Fdde714fd979de3edf0f56aa9716b898hc823",
                                "0xEA674FDDE714Fd979DE3EDF0F56AA👿716B898E"]

        invalidAddresses.forEach {
            performInputTest(for: $0, expectedInput: "", expectedValid: false)
        }
    }

    // MARK: Private

    func performInputTest(for address: String, expectedInput: String, expectedValid: Bool) {
        let validator = WalletDefaultInputValidator.ethereumAddress
        _ = validator.didReceiveReplacement(address, for: NSRange(location: 0, length: 0))
        XCTAssertEqual(validator.input, expectedInput)
        XCTAssertEqual(validator.isValid, expectedValid)
    }
}
