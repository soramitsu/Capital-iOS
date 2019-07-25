/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import IrohaCommunication

class FilterTests: XCTestCase {
    static let numberOfDates = 3
    
    func testSetupForMoreThanOneAsset() {
        do {
            let assetsCount = 2
            let accountSettings = try createRandomAccountSettings(for: assetsCount)

            let transactionTypesCount = 4
            let transactionTypes = (0..<transactionTypesCount).map { _ in createRandomTransactionType() }

            let expectedViewModelCount = FilterTests.numberOfDates + assetsCount + 1
                + transactionTypesCount + 1

            _ = performSetupTest(accountSettings: accountSettings,
                                                     transactionTypes: transactionTypes,
                                                     filter: nil,
                                                     expectedViewModelCount: expectedViewModelCount)

        } catch {
            XCTFail("\(error)")
        }
    }

    func testSetupForOneAsset() {
        do {
            let assetsCount = 1
            let accountSettings = try createRandomAccountSettings(for: assetsCount)

            let transactionTypesCount = 4
            let transactionTypes = (0..<transactionTypesCount).map { _ in createRandomTransactionType() }

            let expectedViewModelCount = FilterTests.numberOfDates + transactionTypesCount + 1

            _ = performSetupTest(accountSettings: accountSettings,
                                 transactionTypes: transactionTypes,
                                 filter: nil,
                                 expectedViewModelCount: expectedViewModelCount)

        } catch {
            XCTFail("\(error)")
        }
    }

    func testAssetSelection() {
        do {
            let assetsCount = 2
            let accountSettings = try createRandomAccountSettings(for: assetsCount)

            let transactionTypesCount = 4
            let transactionTypes = (0..<transactionTypesCount).map { _ in createRandomTransactionType() }

            let expectedViewModelCount = FilterTests.numberOfDates + assetsCount + 1
                + transactionTypesCount + 1

            let view = MockFilterViewProtocol()

            let filter = WalletHistoryRequest(assets: [accountSettings.assets[0].identifier])
            let (presenter, optionalSetupViewModel) = performSetupTest(for: view,
                                                                       accountSettings: accountSettings,
                                                                       transactionTypes: transactionTypes,
                                                                       filter: filter,
                                                                       expectedViewModelCount: expectedViewModelCount)

            guard let setupViewModel = optionalSetupViewModel else {
                XCTFail("Setup view model must not be nil")
                return
            }

            setupViewModel[1].didSelect()

            XCTAssert(validateAssets(viewModel: setupViewModel, assetsCount: assetsCount))
            XCTAssert(validateTypes(viewModel: setupViewModel, typesCount: transactionTypesCount))

            XCTAssertNil(presenter.fromDate)
            XCTAssertNil(presenter.toDate)

        } catch {
            XCTFail("\(error)")
        }
    }

    func testDateSelection() {
        do {
            let assetsCount = 2
            let accountSettings = try createRandomAccountSettings(for: assetsCount)

            let transactionTypesCount = 4
            let transactionTypes = (0..<transactionTypesCount).map { _ in createRandomTransactionType() }

            let expectedViewModelCount = FilterTests.numberOfDates + assetsCount + 1
                + transactionTypesCount + 1

            let view = MockFilterViewProtocol()
            let coordinator = MockFilterCoordinatorProtocol()

            var (presenter, optionalViewModel) = performSetupTest(for: view,
                                                                  coordinator: coordinator,
                                                                  accountSettings: accountSettings,
                                                                  transactionTypes: transactionTypes,
                                                                  filter: nil,
                                                                  expectedViewModelCount: expectedViewModelCount)

            let firstDate = Date().addingTimeInterval(-7200)
            let secondDate = firstDate.addingTimeInterval(-3600)

            // first date

            let firstDateExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).set(filter: any()).then { viewModels in
                    optionalViewModel = viewModels
                    firstDateExpectation.fulfill()
                }
            }

            stub(coordinator) { stub in
                when(stub).presentDatePicker(for: any(), maxDate: any(), delegate: any()).then { (_, _, delegate) in
                    delegate?.modalDatePickerView(ModalDatePickerView(), didSelect: firstDate)
                }
            }

            optionalViewModel?[assetsCount + 2].didSelect()

            wait(for: [firstDateExpectation], timeout: Constants.networkTimeout)

            guard let firstDateViewModel = optionalViewModel?[assetsCount + 2] as? FilterDateViewModel else {
                XCTFail("View Model must not be nil")
                return
            }

            XCTAssert(!firstDateViewModel.title.isEmpty)

            // second date

            let secondDateExpectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).set(filter: any()).then { viewModels in
                    optionalViewModel = viewModels
                    secondDateExpectation.fulfill()
                }
            }

            stub(coordinator) { stub in
                when(stub).presentDatePicker(for: any(), maxDate: any(), delegate: any()).then { (_, _, delegate) in
                    delegate?.modalDatePickerView(ModalDatePickerView(), didSelect: secondDate)
                }
            }

            optionalViewModel?[assetsCount + 3].didSelect()

            wait(for: [secondDateExpectation], timeout: Constants.networkTimeout)

            guard let secondDateViewModel = optionalViewModel?[assetsCount + 3] as? FilterDateViewModel else {
                XCTFail("View Model must not be nil")
                return
            }

            XCTAssert(!secondDateViewModel.title.isEmpty)

            XCTAssertEqual(presenter.fromDate, firstDate)
            XCTAssertEqual(presenter.toDate, secondDate)

        } catch {
            XCTFail("\(error)")
        }
    }

    // MARK: Private

    func performSetupTest(for view: MockFilterViewProtocol = MockFilterViewProtocol(),
                          coordinator: MockFilterCoordinatorProtocol = MockFilterCoordinatorProtocol(),
                          accountSettings: WalletAccountSettingsProtocol,
                          transactionTypes: [WalletTransactionType]?,
                          filter: WalletHistoryRequest?,
                          expectedViewModelCount: Int) -> (FilterPresenter, FilterViewModel?) {
        // given

        let resolver = MockResolverProtocol()

        let filterable = MockFilterable()

        let presenter = FilterPresenter(view: view,
                                        coordinator: coordinator,
                                        assets: accountSettings.assets,
                                        transactionTypes: transactionTypes,
                                        filteringInstance: filterable,
                                        filter: filter)

        // when
        let expectation = XCTestExpectation()

        var filterViewModel: FilterViewModel?

        stub(view) { (stub) in
            when(stub).set(filter: any()).then { viewModels in
                filterViewModel = viewModels
                expectation.fulfill()
            }
        }

        stub(resolver) { stub in
            when(stub).style.get.thenReturn(WalletStyle())
        }

        presenter.setup()

        // then

        wait(for: [expectation], timeout: Constants.networkTimeout)

        guard let viewModel = filterViewModel else {
            XCTFail("View model must not be nil")
            return (presenter, nil)
        }

        XCTAssertEqual(viewModel.count, expectedViewModelCount)
        XCTAssert(validateAssets(viewModel: viewModel, assetsCount: accountSettings.assets.count))
        XCTAssert(validateTypes(viewModel: viewModel, typesCount: transactionTypes?.count ?? 0))

        return (presenter, viewModel)
    }

    private func validateAssets(viewModel: FilterViewModel, assetsCount: Int) -> Bool {
        if assetsCount > 1 {
            let invalid = viewModel[1..<assetsCount].allSatisfy { subModel in
                if let selectionViewModel = subModel as? FilterSelectionViewModel {
                    return !selectionViewModel.selected
                } else {
                    return true
                }
            }

            return !invalid
        } else {
            return true
        }
    }

    private func validateTypes(viewModel: FilterViewModel, typesCount: Int) -> Bool {
        if typesCount > 0 {
            let invalid = viewModel.reversed()[0..<typesCount].allSatisfy { subModel in
                if let selectionViewModel = subModel as? FilterSelectionViewModel {
                    return !selectionViewModel.selected
                } else {
                    return true
                }
            }

            return !invalid
        } else {
            return true
        }
    }
}
