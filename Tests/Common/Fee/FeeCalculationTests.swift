/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class FeeCalculationTests: XCTestCase {

    func testFixedFeeCalculationSuccess() {
        let precision: Int16 = 2
        let parameters: [Decimal] = [
            Decimal(string: "0")!,
            Decimal(string: "2")!,
            Decimal(string: "0.3")!,
            Decimal(string: "0.9")!,
            Decimal(string: "1.36")!,
            Decimal(string: "1.32")!,
            Decimal(string: "2.99")!,
            Decimal(string: "3.666")!,
            Decimal(string: "4.893")!
        ]

        let amounts: [Decimal] = [
            Decimal(string: "1")!,
            Decimal(string: "2")!,
            Decimal(string: "0.3")!,
            Decimal(string: "0.9")!,
            Decimal(string: "1.36")!,
            Decimal(string: "1.32")!,
            Decimal(string: "2.99")!,
            Decimal(string: "3.666")!,
            Decimal(string: "4.9")!
        ]

        let expected: [FeeCalculationResult] = [
            FeeCalculationResult(sending: Decimal(string: "1")!,
                                 fee: Decimal(string: "0")!,
                                 total: Decimal(string: "1")!),

            FeeCalculationResult(sending: Decimal(string: "2")!,
                                 fee: Decimal(string: "2")!,
                                 total: Decimal(string: "4")!),

            FeeCalculationResult(sending: Decimal(string: "0.3")!,
                                 fee: Decimal(string: "0.3")!,
                                 total: Decimal(string: "0.6")!),

            FeeCalculationResult(sending: Decimal(string: "0.9")!,
                                 fee: Decimal(string: "0.9")!,
                                 total: Decimal(string: "1.8")!),

            FeeCalculationResult(sending: Decimal(string: "1.36")!,
                                 fee: Decimal(string: "1.36")!,
                                 total: Decimal(string: "2.72")!),

            FeeCalculationResult(sending: Decimal(string: "1.32")!,
                                 fee: Decimal(string: "1.32")!,
                                 total: Decimal(string: "2.64")!),

            FeeCalculationResult(sending: Decimal(string: "2.99")!,
                                 fee: Decimal(string: "2.99")!,
                                 total: Decimal(string: "5.98")!),

            FeeCalculationResult(sending: Decimal(string: "3.67")!,
                                 fee: Decimal(string: "3.67")!,
                                 total: Decimal(string: "7.34")!),

            FeeCalculationResult(sending: Decimal(string: "4.9")!,
                                 fee: Decimal(string: "4.9")!,
                                 total: Decimal(string: "9.8")!)
        ]

        performTransferFeeTests(type: FeeType.fixed.rawValue,
                                parameters: parameters,
                                amounts: amounts,
                                precision: precision,
                                expected: expected)

        performWithdrawFeeTests(type: FeeType.fixed.rawValue,
                                parameters: parameters,
                                amounts: amounts,
                                precision: precision,
                                expected: expected)
    }

    func testFactorFeeCalculationSuccess() {
        let precision: Int16 = 2
        let parameters: [Decimal] = [
            Decimal(string: "0.1")!,
            Decimal(string: "2")!,
            Decimal(string: "0.3")!,
            Decimal(string: "0.9")!,
            Decimal(string: "1.36")!,
            Decimal(string: "1.32")!,
            Decimal(string: "2.99")!,
            Decimal(string: "3.666")!,
            Decimal(string: "4.893")!
        ]

        let amounts: [Decimal] = [
            Decimal(string: "10.16")!,
            Decimal(string: "2")!,
            Decimal(string: "0.3")!,
            Decimal(string: "0.9")!,
            Decimal(string: "1.36")!,
            Decimal(string: "1.32")!,
            Decimal(string: "2.99")!,
            Decimal(string: "3.666")!,
            Decimal(string: "4.9")!
        ]

        let expected: [FeeCalculationResult] = [
            FeeCalculationResult(sending: Decimal(string: "10.16")!,
                                 fee: Decimal(string: "1.02")!,
                                 total: Decimal(string: "11.18")!),

            FeeCalculationResult(sending: Decimal(string: "2")!,
                                 fee: Decimal(string: "4")!,
                                 total: Decimal(string: "6")!),

            FeeCalculationResult(sending: Decimal(string: "0.3")!,
                                 fee: Decimal(string: "0.09")!,
                                 total: Decimal(string: "0.39")!),

            FeeCalculationResult(sending: Decimal(string: "0.9")!,
                                 fee: Decimal(string: "0.81")!,
                                 total: Decimal(string: "1.71")!),

            FeeCalculationResult(sending: Decimal(string: "1.36")!,
                                 fee: Decimal(string: "1.85")!,
                                 total: Decimal(string: "3.21")!),

            FeeCalculationResult(sending: Decimal(string: "1.32")!,
                                 fee: Decimal(string: "1.75")!,
                                 total: Decimal(string: "3.07")!),

            FeeCalculationResult(sending: Decimal(string: "2.99")!,
                                 fee: Decimal(string: "8.95")!,
                                 total: Decimal(string: "11.94")!),

            FeeCalculationResult(sending: Decimal(string: "3.67")!,
                                 fee: Decimal(string: "13.46")!,
                                 total: Decimal(string: "17.13")!),

            FeeCalculationResult(sending: Decimal(string: "4.9")!,
                                 fee: Decimal(string: "23.98")!,
                                 total: Decimal(string: "28.88")!)
        ]

        performTransferFeeTests(type: FeeType.factor.rawValue,
                                parameters: parameters,
                                amounts: amounts,
                                precision: precision,
                                expected: expected)

        performWithdrawFeeTests(type: FeeType.factor.rawValue,
                                parameters: parameters,
                                amounts: amounts,
                                precision: precision,
                                expected: expected)
    }

    func testTaxFeeCalculationSuccess() {
        let precision: Int16 = 2
        let parameters: [Decimal] = [
            Decimal(string: "0.1")!,
            Decimal(string: "0")!,
            Decimal(string: "0.3")!,
            Decimal(string: "0.9")!,
            Decimal(string: "0.36")!,
            Decimal(string: "0.32")!,
            Decimal(string: "0.99")!,
            Decimal(string: "0.666")!,
            Decimal(string: "0.893")!
        ]

        let amounts: [Decimal] = [
            Decimal(string: "10.16")!,
            Decimal(string: "2")!,
            Decimal(string: "0.3")!,
            Decimal(string: "0.9")!,
            Decimal(string: "1.36")!,
            Decimal(string: "1.32")!,
            Decimal(string: "2.99")!,
            Decimal(string: "3.666")!,
            Decimal(string: "4.9")!
        ]

        let expected: [FeeCalculationResult] = [
            FeeCalculationResult(sending: Decimal(string: "9.14")!,
                                 fee: Decimal(string: "1.02")!,
                                 total: Decimal(string: "10.16")!),

            FeeCalculationResult(sending: Decimal(string: "2")!,
                                 fee: Decimal(string: "0")!,
                                 total: Decimal(string: "2")!),

            FeeCalculationResult(sending: Decimal(string: "0.21")!,
                                 fee: Decimal(string: "0.09")!,
                                 total: Decimal(string: "0.3")!),

            FeeCalculationResult(sending: Decimal(string: "0.09")!,
                                 fee: Decimal(string: "0.81")!,
                                 total: Decimal(string: "0.9")!),

            FeeCalculationResult(sending: Decimal(string: "0.87")!,
                                 fee: Decimal(string: "0.49")!,
                                 total: Decimal(string: "1.36")!),

            FeeCalculationResult(sending: Decimal(string: "0.89")!,
                                 fee: Decimal(string: "0.43")!,
                                 total: Decimal(string: "1.32")!),

            FeeCalculationResult(sending: Decimal(string: "0.02")!,
                                 fee: Decimal(string: "2.97")!,
                                 total: Decimal(string: "2.99")!),

            FeeCalculationResult(sending: Decimal(string: "1.22")!,
                                 fee: Decimal(string: "2.45")!,
                                 total: Decimal(string: "3.67")!),

            FeeCalculationResult(sending: Decimal(string: "0.52")!,
                                 fee: Decimal(string: "4.38")!,
                                 total: Decimal(string: "4.9")!)
        ]

        performTransferFeeTests(type: FeeType.tax.rawValue,
                                parameters: parameters,
                                amounts: amounts,
                                precision: precision,
                                expected: expected)

        performWithdrawFeeTests(type: FeeType.tax.rawValue,
                                parameters: parameters,
                                amounts: amounts,
                                precision: precision,
                                expected: expected)
    }

    func testTransferFeeInvalidParametersError() {
        do {
            let feeFactory = FeeCalculationFactory()

            let assetId = try createRandomAssetId()

            let feeDescription = FeeDescription(identifier: UUID().uuidString,
                                                assetId: assetId,
                                                type: FeeType.fixed.rawValue,
                                                parameters: [])

            _ = try feeFactory.createTransferFeeStrategyForDescription(feeDescription,
                                                         assetId: assetId,
                                                         precision: 2)
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

            let assetId = try createRandomAssetId()
            let option = createRandomWithdrawOption()

            let feeDescription = FeeDescription(identifier: UUID().uuidString,
                                                assetId: assetId,
                                                type: FeeType.fixed.rawValue,
                                                parameters: [])

            _ = try feeFactory.createWithdrawFeeStrategyForDescription(feeDescription,
                                                         assetId: assetId,
                                                         optionId: option.identifier,
                                                         precision: 2)
                .calculate(for: 1.2)
        } catch FeeCalculationFactoryError.invalidParameters {
            // expect this error
        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    // Private

    private func performTransferFeeTests(type: String,
                                         parameters: [Decimal],
                                         amounts: [Decimal],
                                         precision: Int16,
                                         expected: [FeeCalculationResult]) {
        do {
            let feeFactory = FeeCalculationFactory()

            let assetId = try createRandomAssetId()

            for (index, parameter) in parameters.enumerated() {
                let feeDescription = FeeDescription(identifier: UUID().uuidString,
                                                    assetId: assetId,
                                                    type: type,
                                                    parameters: [AmountDecimal(value: parameter)])

                let strategy = try feeFactory.createTransferFeeStrategyForDescription(feeDescription,
                                                                                      assetId: assetId,
                                                                                      precision: precision)
                let result = try strategy.calculate(for: amounts[index])

                XCTAssertEqual(result.sending, expected[index].sending)
                XCTAssertEqual(result.fee, expected[index].fee)
                XCTAssertEqual(result.total, expected[index].total)
            }

        } catch {
            XCTFail("Unexpected error")
        }
    }

    private func performWithdrawFeeTests(type: String,
                                         parameters: [Decimal],
                                         amounts: [Decimal],
                                         precision: Int16,
                                         expected: [FeeCalculationResult]) {
        do {
            let feeFactory = FeeCalculationFactory()

            let assetId = try createRandomAssetId()
            let option = createRandomWithdrawOption()

            for (index, parameter) in parameters.enumerated() {
                let feeDescription = FeeDescription(identifier: UUID().uuidString,
                                                    assetId: assetId,
                                                    type: type,
                                                    parameters: [AmountDecimal(value: parameter)])

                let strategy = try feeFactory
                    .createWithdrawFeeStrategyForDescription(feeDescription,
                                                             assetId: assetId,
                                                             optionId: option.identifier,
                                                             precision: precision)

                let result = try strategy.calculate(for: amounts[index])

                XCTAssertEqual(result.sending, expected[index].sending)
                XCTAssertEqual(result.fee, expected[index].fee)
                XCTAssertEqual(result.total, expected[index].total)
            }

        } catch {
            XCTFail("Unexpected error")
        }
    }
}
