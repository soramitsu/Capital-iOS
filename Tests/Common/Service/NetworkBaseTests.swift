/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest

class NetworkBaseTests: XCTestCase {

    override func setUp() {
        NetworkMockManager.shared.enable()
    }

    override func tearDown() {
        NetworkMockManager.shared.disable()
    }
}
