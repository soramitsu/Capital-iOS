import Foundation
import IrohaCommunication

enum FeeType: String, Codable, Equatable {
    case factor = "FACTOR"
    case fixed = "FIXED"
}

public enum FeeCalculationFactoryError: Error {
    case unknownFeeType
    case invalidParameters
}

public protocol FeeCalculationFactoryProtocol {
    func createStrategy(for feeTypeString: String,
                        assetId: IRAssetId,
                        parameters: [Decimal]) throws -> FeeCalculationStrategyProtocol
}

struct FeeCalculationFactory {
    private func createFixedFeeStrategy(for assetId: IRAssetId,
                                        parameters: [Decimal]) throws -> FeeCalculationStrategyProtocol {
        guard let value = parameters.first else {
            throw FeeCalculationFactoryError.invalidParameters
        }

        return FixedFeeStrategy(value: value)
    }

    private func createFactorFeeStrategy(for assetId: IRAssetId,
                                         parameters: [Decimal]) throws -> FeeCalculationStrategyProtocol {
        guard let rate = parameters.first else {
            throw FeeCalculationFactoryError.invalidParameters
        }

        return FactorFeeStrategy(rate: rate)
    }
}

extension FeeCalculationFactory: FeeCalculationFactoryProtocol {
    public func createStrategy(for feeTypeString: String,
                               assetId: IRAssetId,
                               parameters: [Decimal]) throws -> FeeCalculationStrategyProtocol {
        guard let feeType = FeeType(rawValue: feeTypeString) else {
            throw FeeCalculationFactoryError.unknownFeeType
        }

        switch feeType {
        case .fixed:
            return try createFixedFeeStrategy(for: assetId, parameters: parameters)
        case .factor:
            return try createFactorFeeStrategy(for: assetId, parameters: parameters)
        }
    }
}
