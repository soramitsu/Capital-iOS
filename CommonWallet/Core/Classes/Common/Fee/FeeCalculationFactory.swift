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

public protocol FeeCalculationFactoryProtocol {
    func createTransferFeeStrategyForDescriptions(_ feeDescriptions: [FeeDescription],
                                                  assetId: String,
                                                  precision: Int16) throws
        -> FeeCalculationStrategyProtocol

    func createWithdrawFeeStrategyForDescriptions(_ feeDescriptions: [FeeDescription],
                                                  assetId: String,
                                                  optionId: String,
                                                  precision: Int16) throws -> FeeCalculationStrategyProtocol
}

public extension FeeCalculationFactoryProtocol {
    func createTransferFeeStrategyForDescriptions(_ feeDescriptions: [FeeDescription],
                                                  assetId: String,
                                                  precision: Int16) throws
        -> FeeCalculationStrategyProtocol {
        FeeCalculationStrategy(feeDescriptions: feeDescriptions,
                               assetId: assetId,
                               precision: precision)
    }

    func createWithdrawFeeStrategyForDescriptions(_ feeDescriptions: [FeeDescription],
                                                  assetId: String,
                                                  optionId: String,
                                                  precision: Int16) throws -> FeeCalculationStrategyProtocol {
        FeeCalculationStrategy(feeDescriptions: feeDescriptions,
                               assetId: assetId,
                               precision: precision)
    }
}

struct FeeCalculationFactory: FeeCalculationFactoryProtocol {}
