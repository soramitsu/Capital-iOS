/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraFoundation

final class AccountDetailsViewController: ContainerViewController {
    override var presentationNavigationItem: UINavigationItem? {
        return navigationController != nil ? navigationItem : nil
    }

    var presenter: AccountDetailsPresenterProtocol!

    var localizableTile: LocalizableResource<String>?
    var additionalInsets: UIEdgeInsets?

    var style: WalletStyleProtocol?

    override var inheritedInsets: UIEdgeInsets {
        var inset = super.inheritedInsets

        if let additionalInsets = additionalInsets {
            inset.top += additionalInsets.top
            inset.bottom += additionalInsets.bottom
            inset.right += additionalInsets.right
            inset.left += additionalInsets.left
        }

        return inset
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
        setupLocalization()

        presenter.setup()
    }

    private func setupLocalization() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        title = localizableTile?.value(for: locale) ?? L10n.Account.detailsTitle
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
