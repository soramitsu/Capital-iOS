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

    private func createDefaultBuilder(with assetCount: Int) throws -> CommonWalletBuilderProtocol {
        let networkResolver = MockWalletNetworkResolverProtocol()

        stub(networkResolver) { stub in
            when(stub).urlTemplate(for: any(WalletRequestType.self)).then { _ in
                return Constants.balanceUrlTemplate
            }

            when(stub).adapter(for: any(WalletRequestType.self)).then { _ in
                return nil
            }
        }

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
}
