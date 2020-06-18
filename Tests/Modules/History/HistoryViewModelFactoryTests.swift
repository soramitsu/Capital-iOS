/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import SoraFoundation

class HistoryViewModelFactoryTests: XCTestCase {
    func testFeeInclusion() {
        do {
            let assetId = try createRandomAssetId()
            let asset = WalletAsset(identifier: assetId,
                                    name: LocalizableResource { _ in "" },
                                    platform: LocalizableResource { _ in "" },
                                    symbol: "",
                                    precision: 2)

            guard let type = WalletTransactionType.required.first(where: { !$0.isIncome })?.backendName else {
                XCTFail("Unexpected type")
                return
            }

            let assetDataWithFee = try createRandomAssetTransactionData(includeFee: true,
                                                                        txAssetId: assetId,
                                                                        txType: type)

            for includesFee in [false, true] {
                var viewModels: [TransactionSectionViewModel] = []
                let viewModelFactory = createViewModelFactory(for: [asset], includesFee: includesFee)

                _ = try viewModelFactory.merge(newItems: [assetDataWithFee], into: &viewModels, locale: Locale.current)

                guard let viewModel = viewModels.first?.items.first else {
                    XCTFail("Unexpected empty view model")
                    return
                }

                let amount = assetDataWithFee.amount.decimalValue

                var expectedAmount = amount

                if includesFee {
                    guard let fee = assetDataWithFee.fee?.decimalValue else {
                        XCTFail("Unexpected missing fee")
                        return
                    }

                    expectedAmount += fee
                }

                let amountFormatter = viewModelFactory.amountFormatterFactory.createDisplayFormatter(for: asset)

                guard let currentAmount = amountFormatter.value(for: Locale.current)
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
                                                       amountFormatterFactory: NumberFormatterFactory(),
                                                       assets: assets,
                                                       transactionTypes: WalletTransactionType.required,
                                                       includesFeeInAmount: includesFee)

        return viewModelFactory
    }
}
