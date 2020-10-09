/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

final class AccountDetailsContainingController: UIViewController {
    var presenter: AccountListPresenterProtocol!

    let containingView: BaseAccountDetailsContainingView

    let observable: WalletViewModelObserverContainer<ContainableObserver>

    init(containingView: BaseAccountDetailsContainingView) {
        self.containingView = containingView

        observable = WalletViewModelObserverContainer<ContainableObserver>()

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = containingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.setup()
    }
}

extension AccountDetailsContainingController: Containable {
    var contentView: UIView {
        view
    }

    var contentInsets: UIEdgeInsets {
        containingView.contentInsets
    }

    var preferredContentHeight: CGFloat {
        containingView.preferredContentHeight
    }

    func setContentInsets(_ contentInsets: UIEdgeInsets, animated: Bool) {
        containingView.setContentInsets(contentInsets, animated: animated)
    }
}

extension AccountDetailsContainingController: AccountListViewProtocol {
    func didLoad(viewModels: [WalletViewModelProtocol], collapsingRange: Range<Int>) {
        observable.observers.forEach { $0.observer?.willChangePreferredContentHeight() }

        containingView.bind(viewModels: viewModels)

        let contentHeight = containingView.preferredContentHeight
        observable.observers.forEach { $0.observer?.didChangePreferredContentHeight(to: contentHeight) }
    }

    func didCompleteReload() {}

    func set(expanded: Bool, animated: Bool) {}
}
