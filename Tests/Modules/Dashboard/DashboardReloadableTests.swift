/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import XCTest
@testable import CommonWallet
import Cuckoo

class DashboardReloadableTests: XCTestCase {

    func testReloadDraggableOnContentReload() {
        // given

        let bundle = Bundle(for: DashboardViewController.self)

        let dashboardView = DashboardViewController()
        let dashboardPresenter = MockDashboardPresenterProtocol()
        dashboardView.presenter = dashboardPresenter

        let assetsListView = AccountListViewController(nibName: "AccountListViewController", bundle: bundle)
        let assetsListPresenter = MockAccountListPresenterProtocol()
        assetsListView.presenter = assetsListPresenter

        let historyView = HistoryViewController(nibName: "HistoryViewController", bundle: bundle)
        let historyPresenter = MockHistoryPresenterProtocol()
        historyView.presenter = historyPresenter

        dashboardView.content = assetsListView
        dashboardView.draggable = historyView

        // when

        stub(dashboardPresenter) { (stub) in
            when(stub).reload().thenDoNothing()
        }

        stub(assetsListPresenter) { (stub) in
            when(stub).setup().thenDoNothing()
            when(stub).viewDidAppear().thenDoNothing()
            when(stub).reload().thenDoNothing()
        }

        stub(historyPresenter) { (stub) in
            when(stub).setup().thenDoNothing()
            when(stub).numberOfSections().thenReturn(0)
            when(stub).loadNext().thenReturn(false)
            when(stub).showTransaction(at: any(), in: any()).thenDoNothing()
            when(stub).reloadCache().thenDoNothing()
            when(stub).reload().thenDoNothing()
        }

        _ = dashboardView.view

        assetsListView.actionReload()

        // then

        verify(assetsListPresenter, times(1)).reload()
        verify(historyPresenter, times(1)).reload()
    }

}
