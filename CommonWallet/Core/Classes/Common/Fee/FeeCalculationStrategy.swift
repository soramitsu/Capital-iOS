/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol FeeCalculationStrategyProtocol {
    func calculate(for amount: Decimal) throws -> FeeCalculationResult
}

public enum FeeCalculationError: Error {
    case unknownFeeType
    case invalidParameters
}

typealias FeeIntermediateResult = (amount: Decimal, fee: Decimal)

struct FeeCalculationStrategy: FeeCalculationStrategyProtocol {
    let feeDescriptions: [FeeDescription]
    let assetId: String
    let behaviors: NSDecimalNumberBehaviors

    init(feeDescriptions: [FeeDescription], assetId: String, precision: Int16) {
        self.feeDescriptions = feeDescriptions
        self.assetId = assetId
        self.behaviors = NSDecimalNumberHandler.defaultHandler(precision: Int16(precision))
    }

    func calculate(for amount: Decimal) throws -> FeeCalculationResult {
        var sending = amount
        var fees: [Fee] = []

        for feeDescription in feeDescriptions {
            let result =  try calculateForAmount(amount, feeDescription: feeDescription)

            if feeDescription.assetId == assetId {
                sending += result.amount - amount
            }

            let fee = Fee(value: AmountDecimal(value: result.fee), feeDescription: feeDescription)
            fees.append(fee)
        }

        let totalAmount = sending + fees.filter({ $0.feeDescription.assetId == assetId })
            .reduce(Decimal(0)) { $0 + $1.value.decimalValue }

        return FeeCalculationResult(sending: sending,
                                    fees: fees,
                                    total: totalAmount)
    }

    private func calculateForAmount(_ amount: Decimal, feeDescription: FeeDescription) throws
        -> FeeIntermediateResult {
        guard let feeType = FeeType(rawValue: feeDescription.type) else {
            throw FeeCalculationError.unknownFeeType
        }

        switch feeType {
        case .fixed:
            return try calculateFixedFeeForAmount(amount, feeDescription: feeDescription)
        case .factor:
            return try calculateFactorFeeForAmount(amount, feeDescription: feeDescription)
        case .tax:
            return try calculateTaxStrategyFeeForAmount(amount, feeDescription: feeDescription)
        }
    }

    private func calculateFixedFeeForAmount(_ amount: Decimal, feeDescription: FeeDescription) throws
        -> FeeIntermediateResult {

        guard let value = feeDescription.parameters.first?.decimalValue else {
            throw FeeCalculationError.invalidParameters
        }

        let feeNumber = NSDecimalNumber(decimal: value).rounding(accordingToBehavior: behaviors)
        let amountNumber = NSDecimalNumber(decimal: amount).rounding(accordingToBehavior: behaviors)

        return FeeIntermediateResult(amount: amountNumber.decimalValue, fee: feeNumber.decimalValue)
    }

    private func calculateFactorFeeForAmount(_ amount: Decimal, feeDescription: FeeDescription) throws
        -> FeeIntermediateResult {

        guard let rate = feeDescription.parameters.first?.decimalValue else {
            throw FeeCalculationError.invalidParameters
        }

        let amountNumber = NSDecimalNumber(decimal: amount).rounding(accordingToBehavior: behaviors)
        let feeNumber = NSDecimalNumber(decimal: rate).multiplying(by: amountNumber, withBehavior: behaviors)

        return FeeIntermediateResult(amount: amountNumber.decimalValue, fee: feeNumber.decimalValue)
    }

    private func calculateTaxStrategyFeeForAmount(_ amount: Decimal, feeDescription: FeeDescription) throws
        -> FeeIntermediateResult {

        guard let rate = feeDescription.parameters.first?.decimalValue else {
            throw FeeCalculationError.invalidParameters
        }

        let totalNumber = NSDecimalNumber(decimal: amount).rounding(accordingToBehavior: behaviors)
        let feeNumber = NSDecimalNumber(decimal: rate).multiplying(by: totalNumber, withBehavior: behaviors)
        let sendingNumber = totalNumber.subtracting(feeNumber, withBehavior: behaviors)

        return FeeIntermediateResult(amount: sendingNumber.decimalValue, fee: feeNumber.decimalValue)
    }
}
