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

    private func createDefaultBuilder(with assetCount: Int) throws -> CommonWalletBuilderProtocol {
        let networkResolver = MockNetworkResolver()
        let account = try createRandomAccountSettings(for: 4)

        return CommonWalletBuilder.builder(with: account,
                                           networkResolver: networkResolver)
    }

    private func resolver(from context: CommonWalletContextProtocol) -> ResolverProtocol? {
        guard let resolver = context as? Resolver else {
            return nil
        }

        return resolver
    }

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
