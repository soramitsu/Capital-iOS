/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol FeeCalculationStrategyProtocol {
    func calculate(for amount: Decimal) throws -> FeeCalculationResult
}

public struct FixedFeeStrategy: FeeCalculationStrategyProtocol {
    private let value: NSDecimalNumber
    private let behaviors: NSDecimalNumberBehaviors

    public func calculate(for amount: Decimal) throws -> FeeCalculationResult {
        let feeNumber = value.rounding(accordingToBehavior: behaviors)
        let amountNumber = NSDecimalNumber(decimal: amount).rounding(accordingToBehavior: behaviors)
        let totalNumber = amountNumber.adding(feeNumber)

        return FeeCalculationResult(sending: amountNumber.decimalValue,
                                    fee: feeNumber.decimalValue,
                                    total: totalNumber.decimalValue)
    }

    public init(value: Decimal, precision: Int16) {
        self.value = NSDecimalNumber(decimal: value)
        self.behaviors = NSDecimalNumberHandler.defaultHandler(precision: Int16(precision))
    }
}

public struct FactorFeeStrategy: FeeCalculationStrategyProtocol {
    private let rate: NSDecimalNumber
    private let behaviors: NSDecimalNumberBehaviors

    public func calculate(for amount: Decimal) throws -> FeeCalculationResult {
        let amountNumber = NSDecimalNumber(decimal: amount).rounding(accordingToBehavior: behaviors)
        let feeNumber = rate.multiplying(by: amountNumber, withBehavior: behaviors)
        let totalNumber = amountNumber.adding(feeNumber)

        return FeeCalculationResult(sending: amountNumber.decimalValue,
                                    fee: feeNumber.decimalValue,
                                    total: totalNumber.decimalValue)
    }

    public init(rate: Decimal, precision: Int16) {
        self.rate = NSDecimalNumber(decimal: rate)
        self.behaviors = NSDecimalNumberHandler.defaultHandler(precision: precision)
    }
}

public struct TaxStrategy: FeeCalculationStrategyProtocol {
    private let rate: NSDecimalNumber
    private let behaviors: NSDecimalNumberBehaviors

    public func calculate(for amount: Decimal) throws -> FeeCalculationResult {
        let totalNumber = NSDecimalNumber(decimal: amount).rounding(accordingToBehavior: behaviors)
        let feeNumber = rate.multiplying(by: totalNumber, withBehavior: behaviors)
        let sendingNumber = totalNumber.subtracting(feeNumber, withBehavior: behaviors)

        return FeeCalculationResult(sending: sendingNumber.decimalValue,
                                    fee: feeNumber.decimalValue,
                                    total: totalNumber.decimalValue)
    }

    public init(rate: Decimal, precision: Int16) {
        self.rate = NSDecimalNumber(decimal: rate)
        self.behaviors = NSDecimalNumberHandler.defaultHandler(precision: precision)
    }
}
