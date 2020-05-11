/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class AccessoryViewFactoryTests: XCTestCase {

    func testCreation() {
        for viewType in WalletAccessoryViewType.allCases {
            XCTAssertNoThrow(AccessoryViewFactory.createAccessoryView(from: viewType,
                                                                      style: WalletStyle().accessoryStyle,
                                                                      target: nil,
                                                                      completionSelector: nil))
        }
    }
}
