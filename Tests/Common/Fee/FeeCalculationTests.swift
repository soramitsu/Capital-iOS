/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import IrohaCommunication

class FeeCalculationTests: XCTestCase {

    func testFixedFeeCalculationSuccess() {
        do {
            let feeFactory = FeeCalculationFactory()

            let assetId = try IRAssetIdFactory.asset(withIdentifier: createRandomAssetId())

            let validValues: [Decimal] = [0, 10, 1e+6]

            for value in validValues {
                let transferCalculator = try feeFactory.createTransferFeeStrategy(for: FeeType.fixed.rawValue,
                                                                                  assetId: assetId,
                                                                                  parameters: [value])

                let transferFee = try transferCalculator.calculate(for: 1.2)
                XCTAssertEqual(transferFee, value)

                let option = createRandomWithdrawOption()
                let withdrawCalculator = try feeFactory.createWithdrawFeeStrategy(for: FeeType.fixed.rawValue,
                                                                                  assetId: assetId,
                                                                                  optionId: option.identifier,
                                                                                  parameters: [value])

                let withdrawFee = try withdrawCalculator.calculate(for: 1.2)
                XCTAssertEqual(withdrawFee, value)
            }

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testFactorFeeCalculationSuccess() {
        do {
            let feeFactory = FeeCalculationFactory()

            let assetId = try IRAssetIdFactory.asset(withIdentifier: createRandomAssetId())

            let validValues: [Decimal] = [0, 10, 1e+6]
            let amount: Decimal = 1.2

            for value in validValues {
                let transferCalculator = try feeFactory.createTransferFeeStrategy(for: FeeType.factor.rawValue,
                                                                                  assetId: assetId,
                                                                                  parameters: [value])

                let transferFee = try transferCalculator.calculate(for: 1.2)
                XCTAssertEqual(transferFee, amount * value)

                let option = createRandomWithdrawOption()
                let withdrawCalculator = try feeFactory.createWithdrawFeeStrategy(for: FeeType.factor.rawValue,
                                                                                  assetId: assetId,
                                                                                  optionId: option.identifier,
                                                                                  parameters: [value])

                let withdrawFee = try withdrawCalculator.calculate(for: 1.2)
                XCTAssertEqual(withdrawFee, amount * value)
            }

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testTransferFeeInvalidParametersError() {
        do {
            let feeFactory = FeeCalculationFactory()

            let assetId = try IRAssetIdFactory.asset(withIdentifier: createRandomAssetId())

            _ = try feeFactory.createTransferFeeStrategy(for: FeeType.fixed.rawValue,
                                                         assetId: assetId,
                                                         parameters: [])
                .calculate(for: 1.2)
        } catch FeeCalculationFactoryError.invalidParameters {
            // expect this error
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testWithdrawFeeInvalidParametersError() {
        do {
            let feeFactory = FeeCalculationFactory()

            let assetId = try IRAssetIdFactory.asset(withIdentifier: createRandomAssetId())
            let option = createRandomWithdrawOption()

            _ = try feeFactory.createWithdrawFeeStrategy(for: FeeType.fixed.rawValue,
                                                         assetId: assetId,
                                                         optionId: option.identifier,
                                                         parameters: [])
                .calculate(for: 1.2)
        } catch FeeCalculationFactoryError.invalidParameters {
            // expect this error
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }
}
