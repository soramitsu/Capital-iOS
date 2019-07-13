/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class DescriptionInputViewModelTests: XCTestCase {

    func testInputEmoji() {
        performTestInput(initialText: "Nice day for emoji",
                         appendingText: "🔥",
                         expectedResult: "Nice day for emoji🔥")
    }

    func testRemoveEmoji() {
        performTestReplace(initialText: "Nice🔥", in: NSRange(location: 4, length: 2), with: "", expectedResult: "Nice")
    }

    // MARK: Private

    private func performTestInput(initialText: String, appendingText: String, expectedResult: String) {
        let descriptionInput = DescriptionInputViewModel(text: initialText,
                                                         placeholder: "",
                                                         maxLength: UInt8(initialText.count + appendingText.count))
        let replacingRange = NSRange(location: initialText.count, length: 0)
        _ = descriptionInput.didReceiveReplacement(appendingText, for: replacingRange)

        XCTAssertEqual(descriptionInput.text, expectedResult)
    }

    private func performTestReplace(initialText: String, in range: NSRange, with replacement: String, expectedResult: String) {
        let descriptionInput = DescriptionInputViewModel(text: initialText,
                                                         placeholder: "",
                                                         maxLength: UInt8(initialText.count))
        _ = descriptionInput.didReceiveReplacement(replacement, for: range)
        XCTAssertEqual(descriptionInput.text, expectedResult)
    }
}
