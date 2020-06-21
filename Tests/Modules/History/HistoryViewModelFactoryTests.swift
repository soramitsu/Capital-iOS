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
                let numberFormatterFactory = NumberFormatterFactory()
                let viewModelFactory =
                    createViewModelFactory(for: [asset],
                                           numberFormatterFactory: numberFormatterFactory,
                                           includesFee: includesFee)

                _ = try viewModelFactory.merge(newItems: [assetDataWithFee], into: &viewModels, locale: Locale.current)

                guard let viewModel = viewModels.first?.items.first as? TransactionItemViewModel else {
                    XCTFail("Unexpected empty view model")
                    return
                }

                let amount = assetDataWithFee.amount.decimalValue

                var expectedAmount = amount

                if includesFee {
                    let fee = assetDataWithFee.fees.reduce(Decimal(0)) { result, item in
                        if item.assetId == assetDataWithFee.assetId {
                            return result + item.amount.decimalValue
                        } else {
                            return result
                        }
                    }

                    expectedAmount += fee
                }

                let amountFormatter = numberFormatterFactory.createTokenFormatter(for: asset)

                guard let currentAmount = amountFormatter.value(for: Locale.current)
                    .string(from: expectedAmount) else {
                    XCTFail("Unexpected current amount")
                    return
                }

                XCTAssertEqual(currentAmount, viewModel.amount)
            }

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    // MARK: Private

    private func createViewModelFactory(for assets: [WalletAsset],
                                        numberFormatterFactory: NumberFormatterFactoryProtocol,
                                        includesFee: Bool) -> HistoryViewModelFactory {
        let dateFormatterFactory = TransactionListSectionFormatterFactory.self
        let dateFormatterProvider = DateFormatterProvider(dateFormatterFactory: dateFormatterFactory,
                                                          dayChangeHandler: DayChangeHandler())

        let commandFactory = createMockedCommandFactory()

        let itemViewModelFactory = HistoryItemViewModelFactory(amountFormatterFactory: numberFormatterFactory,
                                                               includesFeeInAmount: includesFee, transactionTypes: WalletTransactionType.required,
                                                               assets: assets,
                                                               commandFactory: commandFactory)

        let viewModelFactory = HistoryViewModelFactory(dateFormatterProvider: dateFormatterProvider,
                                                       itemViewModelFactory: itemViewModelFactory)

        return viewModelFactory
    }
}
