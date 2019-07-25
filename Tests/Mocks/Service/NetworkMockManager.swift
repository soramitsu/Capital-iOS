/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import OHHTTPStubs


protocol NetworkMockManagerProtocol {
    var isEnabled: Bool { get }

    func enable()
    func disable()
}


class NetworkMockManager {
    static let shared = NetworkMockManager()
}


extension NetworkMockManager: NetworkMockManagerProtocol {
    
    var isEnabled: Bool {
        return OHHTTPStubs.isEnabled()
    }

    public func enable() {
        OHHTTPStubs.removeAllStubs()
        OHHTTPStubs.setEnabled(true)
    }

    public func disable() {
        OHHTTPStubs.removeAllStubs()
        OHHTTPStubs.setEnabled(false)
    }
    
}
