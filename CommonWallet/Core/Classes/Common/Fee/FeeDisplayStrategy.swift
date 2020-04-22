/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol FeeDisplayStrategyProtocol {
    func decimalValue(from fee: Decimal?) -> Decimal?
}

public struct FeedDisplayStrategyIfNonzero: FeeDisplayStrategyProtocol {

    public init() {}

    public func decimalValue(from fee: Decimal?) -> Decimal? {
        if let fee = fee, fee > 0.0 {
            return fee
        } else {
            return nil
        }
    }
}

public struct FeeDisplayStrategyAlways: FeeDisplayStrategyProtocol {

    public init() {}

    public func decimalValue(from fee: Decimal?) -> Decimal? {
        if let fee = fee {
            return fee
        } else {
            return 0.0
        }
    }
}
