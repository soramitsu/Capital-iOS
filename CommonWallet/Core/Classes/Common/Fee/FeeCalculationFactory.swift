/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

enum FeeType: String, Codable, Equatable {
    case factor = "FACTOR"
    case fixed = "FIXED"
    case tax = "TAX"
}

public enum FeeCalculationFactoryError: Error {
    case unknownFeeType
    case invalidParameters
}

public protocol FeeCalculationFactoryProtocol {
    func createTransferFeeStrategyForDescription(_ feeDescription: FeeDescription,
                                                 assetId: String,
                                                 precision: Int16) throws -> FeeCalculationStrategyProtocol

    func createWithdrawFeeStrategyForDescription(_ feeDescription: FeeDescription,
                                                 assetId: String,
                                                 optionId: String,
                                                 precision: Int16) throws -> FeeCalculationStrategyProtocol
}

public extension FeeCalculationFactoryProtocol {
    func createTransferFeeStrategyForDescription(_ feeDescription: FeeDescription,
                                                 assetId: String,
                                                 precision: Int16) throws -> FeeCalculationStrategyProtocol {
        return try createFeeStrategyForDescription(feeDescription, precision: precision)
    }

    func createWithdrawFeeStrategyForDescription(_ feeDescription: FeeDescription,
                                                 assetId: String,
                                                 optionId: String,
                                                 precision: Int16) throws -> FeeCalculationStrategyProtocol {
        return try createFeeStrategyForDescription(feeDescription, precision: precision)
    }

    private func createFeeStrategyForDescription(_ feeDescription: FeeDescription,
                                                 precision: Int16) throws -> FeeCalculationStrategyProtocol {
        guard let feeType = FeeType(rawValue: feeDescription.type) else {
            throw FeeCalculationFactoryError.unknownFeeType
        }

        switch feeType {
        case .fixed:
            return try createFixedFeeStrategyForParameters(feeDescription.parameters, precision: precision)
        case .factor:
            return try createFactorFeeStrategyForParameters(feeDescription.parameters, precision: precision)
        case .tax:
            return try createTaxStrategyForParameters(feeDescription.parameters, precision: precision)
        }
    }

    private func createFixedFeeStrategyForParameters(_ parameters: [AmountDecimal], precision: Int16) throws
        -> FeeCalculationStrategyProtocol {
        guard let parameter = parameters.first else {
            throw FeeCalculationFactoryError.invalidParameters
        }

        return FixedFeeStrategy(value: parameter.decimalValue, precision: precision)
    }

    private func createFactorFeeStrategyForParameters(_ parameters: [AmountDecimal], precision: Int16) throws
        -> FeeCalculationStrategyProtocol {
        guard let rate = parameters.first else {
            throw FeeCalculationFactoryError.invalidParameters
        }

        return FactorFeeStrategy(rate: rate.decimalValue, precision: precision)
    }

    private func createTaxStrategyForParameters(_ parameters: [AmountDecimal],
                                                precision: Int16) throws -> FeeCalculationStrategyProtocol {
        guard let rate = parameters.first else {
            throw FeeCalculationFactoryError.invalidParameters
        }

        return TaxStrategy(rate: rate.decimalValue, precision: precision)
    }
}

struct FeeCalculationFactory: FeeCalculationFactoryProtocol {}
