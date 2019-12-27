/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class CommonWalletBuilderTests: XCTestCase {
    func testDefaultCommonWalletBuilder() {
        do {
            let commonWalletBuilder = try createDefaultBuilder(with: 4)
            _ = try commonWalletBuilder.build()
        } catch {
            XCTFail("\(error)")
        }
    }

    func testNumberFormatterSetup() {
        do {
            let numberFormatter = NumberFormatter()
            let context = try createDefaultBuilder(with: 4)
                .with(amountFormatter: numberFormatter)
                .build()

            guard let resolver = resolver(from: context) else {
                XCTFail()
                return
            }

            XCTAssertTrue(resolver.amountFormatter === numberFormatter)

        } catch {
            XCTFail("\(error)")
        }
    }

    func testRequiredTransactionTypesWhenNotProvided() {
        do {
            let context = try createDefaultBuilder(with: 4).build()
            checkTransactionTypeConsistency(for: context,
                                            expectedCount: WalletTransactionType.required.count)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testRequiredTransactionTypesWhenProvided() {
        do {
            let context = try createDefaultBuilder(with: 4)
                .with(transactionTypeList: WalletTransactionType.required)
                .build()
            checkTransactionTypeConsistency(for: context,
                                            expectedCount: WalletTransactionType.required.count)
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testLanguageProperInitialized() {
        do {
            let context = try createDefaultBuilder(with: 4).with(language: WalletLanguage.khmer).build()

            XCTAssertEqual(L10n.sharedLanguage, WalletLanguage.khmer)

            guard let resolver = resolver(from: context) else {
                XCTFail()
                return
            }

            XCTAssertEqual(resolver.localizationManager?.selectedLocalization, WalletLanguage.khmer.rawValue)

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    // MARK: Private

    private func checkTransactionTypeConsistency(for context: CommonWalletContextProtocol, expectedCount: Int) {
        guard let resolver = resolver(from: context) else {
            XCTFail()
            return
        }

        WalletTransactionType.required.forEach { type in
            if !resolver.transactionTypeList.contains(where: { $0.backendName == type.backendName }) {
                XCTFail()
            }
        }

        XCTAssertEqual(resolver.transactionTypeList.count, expectedCount)
    }
}
