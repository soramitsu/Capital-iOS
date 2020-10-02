/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


class WalletNewFormViewController: UIViewController {
    private struct Constants {
        static let horizontalMargin: CGFloat = 20.0
    }

    let style: WalletStyleProtocol
    let definition: WalletFormDefining
    let accessoryViewFactory: AccessoryViewFactoryProtocol.Type

    var localizableTitle: LocalizableResource<String>?

    var presenter: WalletNewFormPresenterProtocol!

    var accessoryViewType: WalletAccessoryViewType = .titleIconActionBar

    private var accessoryView: AccessoryViewProtocol?

    private var containerView = ScrollableContainerView()

    private var needsCheckExtension: Bool = true
    private var heightConstraint: NSLayoutConstraint?

    init(definition: WalletFormDefining,
         style: WalletStyleProtocol,
         accessoryViewFactory: AccessoryViewFactoryProtocol.Type) {
        self.style = style
        self.definition = definition
        self.accessoryViewFactory = accessoryViewFactory

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = containerView

        if #available(iOS 11.0, *) {
            containerView.scrollView.contentInsetAdjustmentBehavior = .always
        }

        configureStyle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocalization()

        presenter.setup()
    }

    override func viewDidLayoutSubviews() {
        if needsCheckExtension,
            let accessoryView = accessoryView, accessoryView.extendsUnderSafeArea {
            if #available(iOS 11.0, *) {
                heightConstraint?.constant = accessoryView.contentView.frame.height +
                    view.safeAreaInsets.bottom
            }
        }

        needsCheckExtension = false

        super.viewDidLayoutSubviews()
    }

    private func configureStyle() {
        view.backgroundColor = style.backgroundColor
    }

    private func setupLocalization() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        if let localizableTitle = localizableTitle {
            title = localizableTitle.value(for: locale)
        }
    }

    private func clearForm() {
        for view in containerView.stackView.arrangedSubviews {
            containerView.stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }

    private func setupFormForViewModels(_ viewModels: [WalletFormViewBindingProtocol]) {
        let views = viewModels.compactMap { viewModel in
            viewModel.accept(definition: definition)
        }

        views.forEach {
            containerView.stackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor,
                                      constant: -2 * Constants.horizontalMargin).isActive = true
        }
    }

    private func adjustContentInsets() {
        var contentInset = containerView.scrollView.contentInset
        contentInset.bottom = accessoryView?.contentView.frame.height ?? 0.0
        containerView.scrollView.contentInset = contentInset
    }

    private func setupAccessoryViewIfNeeded() {
        guard accessoryView == nil else {
            return
        }

        let accesory = accessoryViewFactory.createAccessoryView(from: accessoryViewType,
                                                                style: style.accessoryStyle,
                                                                target: self,
                                                                completionSelector: #selector(performAction))

        accesory.contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(accesory.contentView)

        if accesory.extendsUnderSafeArea {
            accesory.contentView.bottomAnchor
                .constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
        } else {
            if #available(iOS 11.0, *) {
                accesory.contentView.bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
            } else {
                accesory.contentView.bottomAnchor
                    .constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
            }
        }

        heightConstraint = accesory.contentView
            .heightAnchor.constraint(equalToConstant: accesory.contentView.frame.size.height)
        heightConstraint?.isActive = true

        accesory.contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                             constant: 0.0).isActive = true

        accesory.contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                       constant: 0.0).isActive = true

        accessoryView = accesory
    }

    func clearAccessoryView() {
        accessoryView?.contentView.removeFromSuperview()
        accessoryView = nil
    }

    @objc private func performAction() {
        presenter.performAction()
    }
}

extension WalletNewFormViewController: WalletNewFormViewProtocol {
    func didReceive(viewModels: [WalletFormViewBindingProtocol]) {
        clearForm()
        setupFormForViewModels(viewModels)
    }

    func didReceive(accessoryViewModel: AccessoryViewModelProtocol?) {
        if let viewModel = accessoryViewModel {
            setupAccessoryViewIfNeeded()
            accessoryView?.bind(viewModel: viewModel)
        } else {
            clearAccessoryView()
        }

        adjustContentInsets()
    }
}

extension WalletNewFormViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
            view.setNeedsLayout()
        }
    }
}
