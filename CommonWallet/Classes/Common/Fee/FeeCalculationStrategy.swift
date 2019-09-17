/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol FeeCalculationStrategyProtocol {
    func calculate(for amount: Decimal) throws -> Decimal
}

public struct FixedFeeStrategy: FeeCalculationStrategyProtocol {
    let value: Decimal

    public func calculate(for amount: Decimal) throws -> Decimal {
        return value
    }
}

public struct FactorFeeStrategy: FeeCalculationStrategyProtocol {
    let rate: Decimal

    public func calculate(for amount: Decimal) throws -> Decimal {
        return amount * rate
    }
}
