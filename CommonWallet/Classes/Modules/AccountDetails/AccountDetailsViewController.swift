/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraFoundation

final class AccountDetailsViewController: ContainerViewController {
    private struct Constants {
        static let additionalTopInset: CGFloat = 10.0
    }

    override var presentationNavigationItem: UINavigationItem? {
        return navigationController != nil ? navigationItem : nil
    }

    var presenter: AccountDetailsPresenterProtocol!

    var style: WalletStyleProtocol?

    override var inheritedInsets: UIEdgeInsets {
        var inset = super.inheritedInsets

        inset.top += Constants.additionalTopInset

        return inset
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupLocalization()

        presenter.setup()
    }

    private func setupLocalization() {
        title = L10n.Account.detailsTitle
    }

    private func configure() {
        view.backgroundColor = style?.backgroundColor
    }
}

extension AccountDetailsViewController: AccountDetailsViewProtocol {}

extension AccountDetailsViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
        }
    }
}
