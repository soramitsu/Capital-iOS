/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class StyleBuilderTests: XCTestCase {

    func testNavigationBarStyleChanges() {
        var defaultStyleBuilder = WalletStyleBuilder()

        let navigationBarStyle = WalletNavigationBarStyle(barColor: .white,
                                                          shadowColor: .black,
                                                          itemTintColor: .red,
                                                          titleColor: .black,
                                                          titleFont: .walletHeader4)

        defaultStyleBuilder = defaultStyleBuilder.with(navigationBarStyle: navigationBarStyle)
        let style = defaultStyleBuilder.build()

        guard let expectedBarStyle = style.navigationBarStyle as? WalletNavigationBarStyle else {
            XCTFail()
            return
        }

        XCTAssertTrue(navigationBarStyle == expectedBarStyle)
    }
}
