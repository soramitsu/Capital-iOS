/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import SoraFoundation

class AmountInputViewModelTests: XCTestCase {

    func testAmountInputViewModelCreation() {
        let limit = Decimal(1e6)
        performAmountInitializationTest(inputAmount: 12345, expectedAmount: 12345, limit: limit)
        performAmountInitializationTest(inputAmount: 12345.25, expectedAmount: 12345.25, limit: limit)
        performAmountInitializationTest(inputAmount: 1e6+0.1, expectedAmount: 0.0, limit: limit)
    }

    func testAmountInput() {
        performAmountInput(for: Locale.us, outputLocale: Locale.russia)
        performAmountInput(for: Locale.russia, outputLocale: Locale.us)
        performAmountInput(for: Locale.russia, outputLocale: Locale.spain)
    }

    func testAmountRemove() {
        performAmountRemove(for: Locale.us, outputLocale: Locale.russia)
        performAmountRemove(for: Locale.russia, outputLocale: Locale.us)
        performAmountRemove(for: Locale.russia, outputLocale: Locale.spain)
    }

    // MARK: Private

    func performAmountInput(for inputLocale: Locale, outputLocale: Locale) {
        let formatter = NumberFormatter.money.localizableResource()

        let limit: Decimal = 1e+6
        let initialAmount: Decimal = 12
        let expectedAmount: Decimal = 12.25

        let amountViewModel = AmountInputViewModel(amount: initialAmount,
                                                   limit: limit,
                                                   formatter: formatter.value(for: outputLocale),
                                                   inputLocale: inputLocale)

        _ = amountViewModel.didReceiveReplacement(inputLocale.decimalSeparator!,
                                                  for: NSRange(location: amountViewModel.amount.count, length: 0))

        _ = amountViewModel.didReceiveReplacement("2",
                                                  for: NSRange(location: amountViewModel.amount.count, length: 0))

        _ = amountViewModel.didReceiveReplacement("5",
                                                  for: NSRange(location: amountViewModel.amount.count, length: 0))

        XCTAssertEqual(amountViewModel.decimalAmount, expectedAmount)
    }

    func performAmountRemove(for inputLocale: Locale, outputLocale: Locale) {
        let formatter = NumberFormatter.money.localizableResource()

        let limit: Decimal = 1e+6
        let initialAmount: Decimal = 12.25
        let expectedAmount: Decimal = 12

        let amountViewModel = AmountInputViewModel(amount: initialAmount,
                                                   limit: limit,
                                                   formatter: formatter.value(for: outputLocale),
                                                   inputLocale: inputLocale)

        _ = amountViewModel.didReceiveReplacement("",
                                                  for: NSRange(location: amountViewModel.amount.count - 1, length: 1))

        _ = amountViewModel.didReceiveReplacement("",
                                                  for: NSRange(location: amountViewModel.amount.count - 2, length: 2))

        XCTAssertEqual(amountViewModel.decimalAmount, expectedAmount)
    }

    private func performAmountInitializationTest(inputAmount: Decimal,
                                         expectedAmount: Decimal,
                                         limit: Decimal) {
        let amountInputViewModel = AmountInputViewModel(amount: inputAmount,
                                                        limit: limit,
                                                        formatter: NumberFormatter.money)
        XCTAssertEqual(expectedAmount, amountInputViewModel.decimalAmount)
    }
}
