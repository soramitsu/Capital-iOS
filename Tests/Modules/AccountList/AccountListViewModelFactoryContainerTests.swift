/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet

class AccountListViewModelFactoryContainerTests: XCTestCase {

    func testInitialization() {
        // when
        let context = AccountListViewModelFactoryContainer()

        // then
        XCTAssertEqual(context.totalViewModelsCount, 2)
    }

    func testInsertSingleBeforeAllReplaceAndRemove() {
        do {
            // given
            var context = AccountListViewModelFactoryContainer()

            // when
            try context.insert(viewModelFactory: createDummyWalletViewModel, at: 0)

            // then
            XCTAssertEqual(context.totalViewModelsCount, 3)
            XCTAssertEqual(context.viewModelFactories.count, 1)
            XCTAssertEqual(context.assetsIndex, 1)
            XCTAssertEqual(context.actionsIndex, 2)

            // when
            try context.replace(viewModelFactory: createDummyWalletViewModel, at: 0)

            // then
            XCTAssertEqual(context.totalViewModelsCount, 3)
            XCTAssertEqual(context.viewModelFactories.count, 1)
            XCTAssertEqual(context.assetsIndex, 1)
            XCTAssertEqual(context.actionsIndex, 2)

            // when
            try context.removeViewModel(at: 0)

            // then
            XCTAssertEqual(context.totalViewModelsCount, 2)
            XCTAssertTrue(context.viewModelFactories.isEmpty)
            XCTAssertEqual(context.assetsIndex, 0)
            XCTAssertEqual(context.actionsIndex, 1)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testInsertSingleAfterAllReplaceAndRemove() {
        do {
            // given
            var context = AccountListViewModelFactoryContainer()

            // when
            try context.insert(viewModelFactory: createDummyWalletViewModel, at: 2)

            // then
            XCTAssertEqual(context.totalViewModelsCount, 3)
            XCTAssertEqual(context.viewModelFactories.count, 1)
            XCTAssertEqual(context.assetsIndex, 0)
            XCTAssertEqual(context.actionsIndex, 1)

            // when
            try context.replace(viewModelFactory: createDummyWalletViewModel, at: 2)

            // then
            XCTAssertEqual(context.totalViewModelsCount, 3)
            XCTAssertEqual(context.viewModelFactories.count, 1)
            XCTAssertEqual(context.assetsIndex, 0)
            XCTAssertEqual(context.actionsIndex, 1)

            // when
            try context.removeViewModel(at: 2)

            // then
            XCTAssertEqual(context.totalViewModelsCount, 2)
            XCTAssertTrue(context.viewModelFactories.isEmpty)
            XCTAssertEqual(context.assetsIndex, 0)
            XCTAssertEqual(context.actionsIndex, 1)
        } catch {
            XCTFail("\(error)")
        }
    }

    func testInsertSingleInBetweenReplacenAndRemove() {
        do {
            // given
            var context = AccountListViewModelFactoryContainer()

            // when
            try context.insert(viewModelFactory: createDummyWalletViewModel, at: 1)

            // then
            XCTAssertEqual(context.totalViewModelsCount, 3)
            XCTAssertEqual(context.viewModelFactories.count, 1)
            XCTAssertEqual(context.assetsIndex, 0)
            XCTAssertEqual(context.actionsIndex, 2)

            // when
            try context.replace(viewModelFactory: createDummyWalletViewModel, at: 1)

            // then
            XCTAssertEqual(context.totalViewModelsCount, 3)
            XCTAssertEqual(context.viewModelFactories.count, 1)
            XCTAssertEqual(context.assetsIndex, 0)
            XCTAssertEqual(context.actionsIndex, 2)

            // when
            try context.removeViewModel(at: 1)

            // then
            XCTAssertEqual(context.totalViewModelsCount, 2)
            XCTAssertTrue(context.viewModelFactories.isEmpty)
            XCTAssertEqual(context.assetsIndex, 0)
            XCTAssertEqual(context.actionsIndex, 1)
        } catch {
            XCTFail("\(error)")
        }
    }
}
