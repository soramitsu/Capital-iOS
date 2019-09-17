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
                let calculator = try feeFactory.createStrategy(for: FeeType.fixed.rawValue,
                                                               assetId: assetId,
                                                               parameters: [value])

                let fee = try calculator.calculate(for: 1.2)
                XCTAssertEqual(fee, value)
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
                let calculator = try feeFactory.createStrategy(for: FeeType.factor.rawValue,
                                                               assetId: assetId,
                                                               parameters: [value])

                let fee = try calculator.calculate(for: 1.2)
                XCTAssertEqual(fee, amount * value)
            }

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testInvalidParametersError() {
        do {
            let feeFactory = FeeCalculationFactory()

            let assetId = try IRAssetIdFactory.asset(withIdentifier: createRandomAssetId())

            _ = try feeFactory.createStrategy(for: FeeType.fixed.rawValue,
                                          assetId: assetId,
                                          parameters: [])
                .calculate(for: 1.2)
        } catch FeeCalculationFactoryError.invalidParameters {
            // expect this error
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }
}
