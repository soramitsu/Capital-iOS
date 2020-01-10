/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class MoneyPresentableLocalizationTests: XCTestCase {

    func testAmountSetValid() {
        performAmountSetValidTest(for: Decimal(string: "1234.56")!,
                                  inputLocale: Locale.us,
                                  outputLocale: Locale.russia)
        performAmountSetValidTest(for: Decimal(string: "0.56")!,
                                  inputLocale: Locale.us,
                                  outputLocale: Locale.russia)
        performAmountSetValidTest(for: Decimal(string: "123456")!,
                                  inputLocale: Locale.us,
                                  outputLocale: Locale.russia)
        performAmountSetValidTest(for: Decimal(string: "0")!,
                                  inputLocale: Locale.us,
                                  outputLocale: Locale.russia)
    }

    func testAmountSetInvalid() {
        let inputLocale = Locale.us
        let outputLocale = Locale.russia
        let formatter = NumberFormatter.money.localizableResource()

        performPresentableTest(
            bySetting: "1234\(inputLocale.decimalSeparator!)56",
            byAdding: [],
            formatter: formatter.value(for: outputLocale),
            inputLocale: outputLocale,
            expected: ""
        )

        performPresentableTest(
            bySetting: "1\(inputLocale.groupingSeparator!)234",
            byAdding: [],
            formatter: formatter.value(for: outputLocale),
            inputLocale: outputLocale,
            expected: ""
        )
    }

    func testAmountSetAndAddValid() {
        let inputLocale = Locale.us
        let outputLocale = Locale.russia
        let formatter = NumberFormatter.money.localizableResource()

        performPresentableTest(
            bySetting: "1234\(inputLocale.decimalSeparator!)",
            byAdding: ["5", "6"],
            formatter: formatter.value(for: outputLocale),
            inputLocale: inputLocale,
            expected: "1\(outputLocale.groupingSeparator!)234\(outputLocale.decimalSeparator!)56"
        )

        performPresentableTest(
            bySetting: "0",
            byAdding: [inputLocale.decimalSeparator!, "5", "6"],
            formatter: formatter.value(for: outputLocale),
            inputLocale: inputLocale,
            expected: "0\(outputLocale.decimalSeparator!)56"
        )

        performPresentableTest(
            bySetting: "12",
            byAdding: ["3", "4", "5", "67"],
            formatter: formatter.value(for: outputLocale),
            inputLocale: inputLocale,
            expected: "1\(outputLocale.groupingSeparator!)234\(outputLocale.groupingSeparator!)567"
        )

        performPresentableTest(
            bySetting: "",
            byAdding: [inputLocale.decimalSeparator!, "2", "3", "4"],
            formatter: formatter.value(for: outputLocale),
            inputLocale: inputLocale,
            expected: "0\(outputLocale.decimalSeparator!)23"
        )
    }

    // MARK: Private

    private func performAmountSetValidTest(for value: Decimal, inputLocale: Locale, outputLocale: Locale) {
        let formatter = NumberFormatter.money.localizableResource()
        let settingValue = formatter.value(for: inputLocale).string(from: value as NSNumber)!
        let expectedValue = formatter.value(for: outputLocale).string(from: value as NSNumber)!

        performPresentableTest(bySetting: settingValue,
                               byAdding: [],
                               formatter: formatter.value(for: outputLocale),
                               inputLocale: inputLocale,
                               expected: expectedValue)
    }

    private func performPresentableTest(bySetting settingValue: String?,
                                        byAdding addingValues: [String],
                                        formatter: NumberFormatter,
                                        inputLocale: Locale,
                                        expected formattedResult: String) {
        let presenter = MoneyPresenter(formatter: formatter)

        if let settingValue = settingValue {
            let transformedValue = presenter.transform(input: settingValue, from: inputLocale)
            presenter.amount = presenter.set(transformedValue)
        }

        addingValues.forEach {
            let transformedValue = presenter.transform(input: $0, from: inputLocale)
            presenter.amount = presenter.add(transformedValue)
        }

        XCTAssertEqual(formattedResult, presenter.formattedAmount)
    }
}
