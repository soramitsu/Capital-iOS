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
        let initialTextLength = initialText.lengthOfBytes(using: .utf8)
        let appendingTextLength = appendingText.lengthOfBytes(using: .utf8)
        let inputValidatator = LimitDescriptionValidator(maxLength: UInt8(initialTextLength + appendingTextLength),
                                                         hint: "Just type something")
        let descriptionInput = DescriptionInputViewModel(title: "Description",
                                                         validator: inputValidatator)

        let initialRange = NSRange(location: 0, length: 0)
        _ = descriptionInput.didReceiveReplacement(initialText, for: initialRange)

        let replacingRange = NSRange(location: initialText.count, length: 0)
        _ = descriptionInput.didReceiveReplacement(appendingText, for: replacingRange)

        XCTAssertEqual(descriptionInput.text, expectedResult)
    }

    private func performTestReplace(initialText: String, in range: NSRange, with replacement: String, expectedResult: String) {
        let initialTextLength = initialText.lengthOfBytes(using: .utf8)
        let inputValidatator = LimitDescriptionValidator(maxLength: UInt8(initialTextLength),
                                                         hint: "Just type something")
        let descriptionInput = DescriptionInputViewModel(title: "Description",
                                                         validator: inputValidatator)

        let initialRange = NSRange(location: 0, length: 0)
        _ = descriptionInput.didReceiveReplacement(initialText, for: initialRange)

        _ = descriptionInput.didReceiveReplacement(replacement, for: range)
        XCTAssertEqual(descriptionInput.text, expectedResult)
    }
}
