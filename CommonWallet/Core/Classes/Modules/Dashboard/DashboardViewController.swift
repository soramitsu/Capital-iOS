/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit

final class DashboardViewController: ContainerViewController, WalletNavigationBarConcealable {
    var presenter: DashboardPresenterProtocol!

    var style: WalletStyleProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()

        presenter.reload()
    }

    private func configure() {
        view.backgroundColor = style?.backgroundColor
    }
}

extension DashboardViewController: DashboardViewProtocol {}
