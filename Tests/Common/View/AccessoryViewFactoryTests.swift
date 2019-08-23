/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class AccessoryViewFactoryTests: XCTestCase {

    func testCreation() {
        XCTAssertNoThrow(AccessoryViewFactory.createAccessoryView(from: WalletStyle().accessoryStyle,
                                                                  target: nil,
                                                                  completionSelector: nil)) 
    }
}
