/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

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
    func createTransferFeeStrategy(for feeTypeString: String,
                                   assetId: IRAssetId,
                                   precision: Int16,
                                   parameters: [Decimal]) throws -> FeeCalculationStrategyProtocol

    func createWithdrawFeeStrategy(for feeTypeString: String,
                                   assetId: IRAssetId,
                                   optionId: String,
                                   precision: Int16,
                                   parameters: [Decimal]) throws -> FeeCalculationStrategyProtocol
}

public extension FeeCalculationFactoryProtocol {
    func createTransferFeeStrategy(for feeTypeString: String,
                                   assetId: IRAssetId,
                                   precision: Int16,
                                   parameters: [Decimal]) throws -> FeeCalculationStrategyProtocol {
        return try createFeeStrategy(for: feeTypeString, precision: precision, parameters: parameters)
    }

    func createWithdrawFeeStrategy(for feeTypeString: String,
                                   assetId: IRAssetId,
                                   optionId: String,
                                   precision: Int16,
                                   parameters: [Decimal]) throws -> FeeCalculationStrategyProtocol {
        return try createFeeStrategy(for: feeTypeString, precision: precision, parameters: parameters)
    }

    private func createFeeStrategy(for feeTypeString: String,
                                   precision: Int16,
                                   parameters: [Decimal]) throws -> FeeCalculationStrategyProtocol {
        guard let feeType = FeeType(rawValue: feeTypeString) else {
            throw FeeCalculationFactoryError.unknownFeeType
        }

        switch feeType {
        case .fixed:
            return try createFixedFeeStrategy(for: parameters, precision: precision)
        case .factor:
            return try createFactorFeeStrategy(for: parameters, precision: precision)
        case .tax:
            return try createTaxStrategy(for: parameters, precision: precision)
        }
    }

    private func createFixedFeeStrategy(for parameters: [Decimal], precision: Int16)
        throws -> FeeCalculationStrategyProtocol {
        guard let value = parameters.first else {
            throw FeeCalculationFactoryError.invalidParameters
        }

        return FixedFeeStrategy(value: value, precision: precision)
    }

    private func createFactorFeeStrategy(for parameters: [Decimal], precision: Int16)
        throws -> FeeCalculationStrategyProtocol {
        guard let rate = parameters.first else {
            throw FeeCalculationFactoryError.invalidParameters
        }

        return FactorFeeStrategy(rate: rate, precision: precision)
    }

    private func createTaxStrategy(for parameters: [Decimal],
                                   precision: Int16) throws -> FeeCalculationStrategyProtocol {
        guard let rate = parameters.first else {
            throw FeeCalculationFactoryError.invalidParameters
        }

        return TaxStrategy(rate: rate, precision: precision)
    }
}

struct FeeCalculationFactory: FeeCalculationFactoryProtocol {}
