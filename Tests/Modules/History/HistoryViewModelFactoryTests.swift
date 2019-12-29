/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import IrohaCommunication

class HistoryViewModelFactoryTests: XCTestCase {
    func testFeeInclusion() {
        do {
            var assetDataWithFee = try createRandomAssetTransactionData(includeFee: true)

            let assetId = try IRAssetIdFactory.asset(withIdentifier: assetDataWithFee.assetId)
            let asset = WalletAsset(identifier: assetId, symbol: "", details: "")

            guard let type = WalletTransactionType.required.first(where: { !$0.isIncome })?.backendName else {
                XCTFail("Unexpected type")
                return
            }

            assetDataWithFee.type = type

            for includesFee in [false, true] {
                var viewModels: [TransactionSectionViewModel] = []
                let viewModelFactory = createViewModelFactory(for: [asset], includesFee: includesFee)

                _ = try viewModelFactory.merge(newItems: [assetDataWithFee], into: &viewModels, locale: Locale.current)

                guard let viewModel = viewModels.first?.items.first else {
                    XCTFail("Unexpected empty view model")
                    return
                }

                guard let amount = Decimal(string: assetDataWithFee.amount) else {
                        XCTFail("Unexpected amount")
                        return
                }

                var expectedAmount = amount

                if includesFee {
                    guard let feeString = assetDataWithFee.fee, let fee = Decimal(string: feeString) else {
                        XCTFail("Unexpected missing fee")
                        return
                    }

                    expectedAmount += fee
                }

                guard let currentAmount = viewModelFactory.amountFormatter.value(for: Locale.current)
                    .number(from: viewModel.amount) else {
                    XCTFail("Unexpected current amount")
                    return
                }

                XCTAssertEqual(expectedAmount, currentAmount.decimalValue)
            }

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    // MARK: Private

    private func createViewModelFactory(for assets: [WalletAsset],
                                        includesFee: Bool) -> HistoryViewModelFactory {
        let dateFormatterFactory = TransactionListSectionFormatterFactory.self
        let dateFormatterProvider = DateFormatterProvider(dateFormatterFactory: dateFormatterFactory,
                                                          dayChangeHandler: DayChangeHandler())

        let viewModelFactory = HistoryViewModelFactory(dateFormatterProvider: dateFormatterProvider,
                                                       amountFormatter: NumberFormatter().localizableResource(),
                                                       assets: assets,
                                                       transactionTypes: WalletTransactionType.required,
                                                       includesFeeInAmount: includesFee)

        return viewModelFactory
    }
}
