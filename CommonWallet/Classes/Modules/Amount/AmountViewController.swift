/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI
import SoraFoundation

final class AmountViewController: AccessoryViewController {
    private struct Constants {
        static let horizontalMargin: CGFloat = 20.0
        static let assetHeight: CGFloat = 54.0
        static let amountHeight: CGFloat = 70.0
        static let amountInsets = UIEdgeInsets(top: 17.0, left: 0.0, bottom: 8.0, right: 0.0)
        static let feeInsets = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 17.0, right: 0.0)
        static let descriptionInsets = UIEdgeInsets(top: 17.0, left: 0.0, bottom: 8.0, right: 0.0)
    }

    var presenter: AmountPresenterProtocol!

    let containingFactory: ContainingViewFactoryProtocol
    let style: WalletStyleProtocol

    override var accessoryStyle: WalletAccessoryStyleProtocol? {
        style.accessoryStyle
    }

    private var containerView = ScrollableContainerView()

    private var selectedAssetView: SelectedAssetView!
    private var amountInputView: AmountInputView!
    private var feeView: FeeView!
    private var descriptionInputView: DescriptionInputView!

    init(containingFactory: ContainingViewFactoryProtocol, style: WalletStyleProtocol) {
        self.containingFactory = containingFactory
        self.style = style

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = containerView

        configureContentView()

        configureStyle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocalization()

        presenter.setup()
    }

    private func configureContentView() {
        selectedAssetView = containingFactory.createSelectedAssetView()
        selectedAssetView.delegate = self
        selectedAssetView.borderedView.borderType = []
        selectedAssetView.heightAnchor.constraint(equalToConstant: Constants.assetHeight).isActive = true

        amountInputView = containingFactory.createAmountInputView(for: .large)
        amountInputView.borderedView.borderType = [.top]
        amountInputView.contentInsets = Constants.amountInsets
        amountInputView.keyboardIndicatorMode = .never
        let amountHeight = Constants.amountHeight + Constants.amountInsets.top + Constants.amountInsets.bottom
        amountInputView.heightAnchor.constraint(equalToConstant: amountHeight).isActive = true

        feeView = containingFactory.createFeeView()
        feeView.contentInsets = Constants.feeInsets
        feeView.borderedView.borderType = [.bottom]

        descriptionInputView = containingFactory.createDescriptionInputView()
        descriptionInputView.contentInsets = Constants.descriptionInsets
        descriptionInputView.keyboardIndicatorMode = .never
        descriptionInputView.borderedView.borderType = []

        let views: [UIView] = [selectedAssetView, amountInputView, feeView, descriptionInputView]

        views.forEach {
            containerView.stackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor,
                                      constant: -2 * Constants.horizontalMargin).isActive = true
        }
    }
    
    private func configureStyle() {
        view.backgroundColor = style.backgroundColor
    }
    
    private func setupLocalization() {
        amountInputView.titleLabel.text = L10n.Amount.title
    }

    private func updateConfirmationState() {
        let isEnabled = (selectedAssetView.viewModel?.isValid ?? false) &&
            (amountInputView.inputViewModel?.isValid ?? false) &&
            (descriptionInputView.viewModel?.isValid ?? false)

        accessoryView?.isActionEnabled = isEnabled
    }

    private func scrollToAmount(animated: Bool) {
        let amountFrame = containerView.scrollView.convert(amountInputView.frame,
                                                           from: containerView.stackView)
        containerView.scrollView.scrollRectToVisible(amountFrame, animated: animated)
    }

    private func scrollToDescription(animated: Bool) {
        if let selectionRange = descriptionInputView.textView.selectedTextRange {
            var caretRectangle = descriptionInputView.textView.caretRect(for: selectionRange.start)
            caretRectangle.origin.x += descriptionInputView.textView.frame.minX
            caretRectangle.origin.y += descriptionInputView.textView.frame.minY

            let scrollFrame = containerView.scrollView.convert(caretRectangle, from: descriptionInputView)
            containerView.scrollView.scrollRectToVisible(scrollFrame, animated: animated)
        }
    }

    // MARK: Override Superclass

    override func updateBottom(inset: CGFloat) {
        super.updateBottom(inset: inset)

        var currentInsets = containerView.scrollView.contentInset
        currentInsets.bottom = inset

        containerView.scrollView.contentInset = currentInsets

        view.layoutIfNeeded()

        if amountInputView.amountField.isFirstResponder {
            scrollToAmount(animated: false)
        }

        if descriptionInputView.textView.isFirstResponder {
            scrollToDescription(animated: false)
        }
    }

    @objc override func actionAccessory() {
        super.actionAccessory()

        amountInputView.amountField.resignFirstResponder()
        descriptionInputView.textView.resignFirstResponder()

        presenter.confirm()
    }
}


extension AmountViewController: AmountViewProtocol {
    func set(title: String) {
        self.title = title
    }

    func set(assetViewModel: AssetSelectionViewModelProtocol) {
        selectedAssetView.viewModel?.observable.remove(observer: self)

        assetViewModel.observable.add(observer: self)

        selectedAssetView.bind(viewModel: assetViewModel)
        amountInputView.bind(assetSelectionViewModel: assetViewModel)

        updateConfirmationState()
    }

    func set(amountViewModel: AmountInputViewModelProtocol) {
        self.amountInputView.inputViewModel?.observable.remove(observer: self)

        amountViewModel.observable.add(observer: self)

        amountInputView.bind(inputViewModel: amountViewModel)

        updateConfirmationState()
    }

    func set(descriptionViewModel: DescriptionInputViewModelProtocol) {
        descriptionInputView.viewModel?.observable.remove(observer: self)
        descriptionViewModel.observable.add(observer: self)

        descriptionInputView.bind(viewModel: descriptionViewModel)

        updateConfirmationState()
    }

    func set(accessoryViewModel: AccessoryViewModelProtocol) {
        accessoryView?.bind(viewModel: accessoryViewModel)
    }

    func set(feeViewModel: FeeViewModelProtocol) {
        feeView.bind(viewModel: feeViewModel)
    }
}

extension AmountViewController: SelectedAssetViewDelegate {
    func selectedAssetViewDidChange(_ view: SelectedAssetView) {
        if view.activated {
            presenter.presentAssetSelection()
        }
    }
}

extension AmountViewController: AssetSelectionViewModelObserver {
    func assetSelectionDidChangeTitle() {
        updateConfirmationState()
    }

    func assetSelectionDidChangeSymbol() {}

    func assetSelectionDidChangeState() {}
}

extension AmountViewController: AmountInputViewModelObserver {
    func amountInputDidChange() {
        updateConfirmationState()
    }
}

extension AmountViewController: DescriptionInputViewModelObserver {
    func descriptionInputDidChangeText() {
        updateConfirmationState()
    }
}

extension AmountViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
            view.setNeedsLayout()
        }
    }
}
