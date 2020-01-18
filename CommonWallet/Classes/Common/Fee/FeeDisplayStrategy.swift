/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol FeeDisplayStrategyProtocol {
    func decimalValue(from feeString: String?) -> Decimal?
}

public struct FeedDisplayStrategyIfNonzero: FeeDisplayStrategyProtocol {

    public init() {}

    public func decimalValue(from feeString: String?) -> Decimal? {
        if let feeString = feeString,
            let fee = Decimal(string: feeString),
            fee > 0.0 {
            return fee
        } else {
            return nil
        }
    }
}

public struct FeeDisplayStrategyAlways: FeeDisplayStrategyProtocol {

    public init() {}

    public func decimalValue(from feeString: String?) -> Decimal? {
        if let feeString = feeString, let fee = Decimal(string: feeString) {
            return fee
        } else {
            return 0.0
        }
    }
}
