/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo
import SoraFoundation

class FilterTests: XCTestCase {
    static let numberOfDates = 3
    
    func testSetupForMoreThanOneAsset() {
        do {
            let assetsCount = 2
            let accountSettings = try createRandomAccountSettings(for: assetsCount)

            let transactionTypesCount = 4
            let transactionTypes = (0..<transactionTypesCount).map { _ in createRandomTransactionType() }

            let typeFilters = WalletTransactionTypeFilter.createAllFilters(from: transactionTypes)

            let expectedViewModelCount = FilterTests.numberOfDates + assetsCount + 1
                + typeFilters.count + 1

            let assetIds = accountSettings.assets.map { $0.identifier }
            let filter = WalletHistoryRequest(assets: assetIds)
            _ = performSetupTest(accountSettings: accountSettings,
                                                     typeFilters: typeFilters,
                                                     filter: filter,
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

            let typeFilters = WalletTransactionTypeFilter.createAllFilters(from: transactionTypes)

            let expectedViewModelCount = FilterTests.numberOfDates + typeFilters.count + 1

            let assetIds = accountSettings.assets.map { $0.identifier }
            let filter = WalletHistoryRequest(assets: assetIds)
            _ = performSetupTest(accountSettings: accountSettings,
                                 typeFilters: typeFilters,
                                 filter: filter,
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

            let typeFilters = WalletTransactionTypeFilter.createAllFilters(from: transactionTypes)

            let expectedViewModelCount = FilterTests.numberOfDates + assetsCount + 1
                + typeFilters.count + 1

            let view = MockHistoryFilterViewProtocol()

            let filter = WalletHistoryRequest(assets: [accountSettings.assets[0].identifier])
            let (presenter, optionalSetupViewModel) = performSetupTest(for: view,
                                                                       accountSettings: accountSettings,
                                                                       typeFilters: typeFilters,
                                                                       filter: filter,
                                                                       expectedViewModelCount: expectedViewModelCount)

            guard let setupViewModel = optionalSetupViewModel else {
                XCTFail("Setup view model must not be nil")
                return
            }

            try setupViewModel[1].command?.execute()

            XCTAssert(validateAssets(viewModel: setupViewModel, assetsCount: assetsCount))
            XCTAssert(validateTypes(viewModel: setupViewModel, typesCount: typeFilters.count))

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

            let typeFilters = WalletTransactionTypeFilter.createAllFilters(from: transactionTypes)

            let expectedViewModelCount = FilterTests.numberOfDates + assetsCount + 1
                + typeFilters.count + 1

            let view = MockHistoryFilterViewProtocol()
            let coordinator = MockHistoryFilterCoordinatorProtocol()

            let assetIds = accountSettings.assets.map { $0.identifier }
            let filter = WalletHistoryRequest(assets: assetIds)
            var (presenter, optionalViewModel) = performSetupTest(for: view,
                                                                  coordinator: coordinator,
                                                                  accountSettings: accountSettings,
                                                                  typeFilters: typeFilters,
                                                                  filter: filter,
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
                when(stub).presentDatePicker(for: any(), maxDate: any(), delegate: any(), locale: any()).then { (_, _, delegate, _) in
                    delegate?.modalDatePickerView(ModalDatePickerView(), didSelect: firstDate)
                }
            }

            try optionalViewModel?[assetsCount + 2].command?.execute()

            wait(for: [firstDateExpectation], timeout: Constants.networkTimeout)

            guard
                let viewModels = optionalViewModel,
                let firstDateViewModel = viewModels[assetsCount + 2] as? HistoryFilterDateViewModel else {
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
                when(stub).presentDatePicker(for: any(), maxDate: any(), delegate: any(), locale: any()).then { (_, _, delegate, _) in
                    delegate?.modalDatePickerView(ModalDatePickerView(), didSelect: secondDate)
                }
            }

            try optionalViewModel?[assetsCount + 3].command?.execute()

            wait(for: [secondDateExpectation], timeout: Constants.networkTimeout)

            guard
                let viewModel = optionalViewModel,
                let secondDateViewModel = viewModel[assetsCount + 3] as? HistoryFilterDateViewModel else {
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

    func testTransactionTypeFilterSuccessfullSelection() {
        do {
            // given

            let assetsCount = 2
            let accountSettings = try createRandomAccountSettings(for: assetsCount)

            let transactionTypesCount = 4
            let transactionTypes = (0..<transactionTypesCount).map { _ in createRandomTransactionType() }

            let typeFilters = WalletTransactionTypeFilter.createAllFilters(from: transactionTypes)

            let expectedViewModelCount = FilterTests.numberOfDates + assetsCount + 1
                + typeFilters.count + 1

            let view = MockHistoryFilterViewProtocol()
            let coordinator = MockHistoryFilterCoordinatorProtocol()

            let assetIds = accountSettings.assets.map { $0.identifier }
            let filter = WalletHistoryRequest(assets: assetIds)
            let (presenter, optionalViewModel) = performSetupTest(for: view,
                                                                  coordinator: coordinator,
                                                                  accountSettings: accountSettings,
                                                                  typeFilters: typeFilters,
                                                                  filter: filter,
                                                                  expectedViewModelCount: expectedViewModelCount)

            // when

            let expectation = XCTestExpectation()

            stub(view) { stub in
                when(stub).set(filter: any()).then { _ in
                    expectation.fulfill()
                }
            }

            guard let viewModels = optionalViewModel else {
                XCTFail()
                return
            }

            guard let selectionViewModel = viewModels.last as? HistoryFilterSelectionViewModel else {
                XCTFail("Can't extract transaction type view model")
                return
            }

            try selectionViewModel.execute()

            // then

            wait(for: [expectation], timeout: Constants.networkTimeout)

            XCTAssertNil(presenter.fromDate)
            XCTAssertNil(presenter.toDate)

        } catch {
            XCTFail("Unexpected error \(error)")
        }
    }

    func testFilterApply() {
        do {
            // given

            let assetsCount = 1
            let accountSettings = try createRandomAccountSettings(for: assetsCount)

            let transactionTypesCount = 4
            let transactionTypes = (0..<transactionTypesCount).map { _ in createRandomTransactionType() }

            let typeFilters = WalletTransactionTypeFilter.createAllFilters(from: transactionTypes)

            let expectedViewModelCount = FilterTests.numberOfDates + typeFilters.count + 1

            let delegate = MockHistoryFilterEditingDelegate()

            let assetIds = accountSettings.assets.map { $0.identifier }
            let (presenter, _) = performSetupTest(delegate: delegate, accountSettings: accountSettings,
                                                  typeFilters: typeFilters,
                                                  filter: WalletHistoryRequest(assets: assetIds),
                                                  expectedViewModelCount: expectedViewModelCount)

            let expectation = XCTestExpectation()

            stub(delegate) { stub in
                when(stub).historyFilterDidEdit(request: any()).then { _ in
                    expectation.fulfill()
                }
            }

            // when

            presenter.apply()

            // then

            wait(for: [expectation], timeout: Constants.networkTimeout)

        } catch {
            XCTFail("Unexpected error \(error)")
        }

    }

    // MARK: Private

    func performSetupTest(
        for view: MockHistoryFilterViewProtocol = MockHistoryFilterViewProtocol(),
        coordinator: MockHistoryFilterCoordinatorProtocol = MockHistoryFilterCoordinatorProtocol(),
        delegate: HistoryFilterEditingDelegate = MockHistoryFilterEditingDelegate(),
        accountSettings: WalletAccountSettingsProtocol,
        typeFilters: [WalletTransactionTypeFilter],
        filter: WalletHistoryRequest,
        expectedViewModelCount: Int) -> (HistoryFilterPresenter, HistoryFilterViewModel?) {
        // given

        let resolver = MockResolverProtocol()

        let presenter = HistoryFilterPresenter(view: view,
                                               coordinator: coordinator,
                                               assets: accountSettings.assets,
                                               typeFilters: typeFilters,
                                               filter: filter,
                                               delegate: delegate)

        // when
        let expectation = XCTestExpectation()

        var filterViewModel: HistoryFilterViewModel?

        stub(view) { (stub) in
            when(stub).set(filter: any()).then { viewModels in
                filterViewModel = viewModels
                expectation.fulfill()
            }

            when(stub).isSetup.get.thenReturn(false, true)
        }

        stub(resolver) { stub in
            when(stub).style.get.thenReturn(WalletStyle())
        }

        presenter.localizationManager = LocalizationManager(localization: WalletLanguage.english.rawValue)

        presenter.setup()

        // then

        wait(for: [expectation], timeout: Constants.networkTimeout)

        guard let viewModel = filterViewModel else {
            XCTFail("View model must not be nil")
            return (presenter, nil)
        }

        XCTAssertEqual(viewModel.count, expectedViewModelCount)
        XCTAssert(validateAssets(viewModel: viewModel, assetsCount: accountSettings.assets.count))
        XCTAssert(validateTypes(viewModel: viewModel, typesCount: typeFilters.count))

        return (presenter, viewModel)
    }

    private func validateAssets(viewModel: HistoryFilterViewModel, assetsCount: Int) -> Bool {
        if assetsCount > 1 {
            let invalid = viewModel[1..<assetsCount].allSatisfy { subModel in
                if let selectionViewModel = subModel as? HistoryFilterSelectionViewModel {
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

    private func validateTypes(viewModel: HistoryFilterViewModel, typesCount: Int) -> Bool {
        if typesCount > 0 {
            let invalid = viewModel.reversed()[0..<typesCount].allSatisfy { subModel in
                if let selectionViewModel = subModel as? HistoryFilterSelectionViewModel {
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
