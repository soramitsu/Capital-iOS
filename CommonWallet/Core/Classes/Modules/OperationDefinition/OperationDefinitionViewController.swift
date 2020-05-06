/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import UIKit
import SoraUI
import SoraFoundation

class OperationDefinitionViewController: AccessoryViewController {
    private struct Constants {
        static let horizontalMargin: CGFloat = 20.0
        static let assetHeight: CGFloat = 54.0
        static let amountHeight: CGFloat = 42.0
        static let amountInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 14.0, right: 0.0)
        static let feeInsets = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 17.0, right: 0.0)
        static let descriptionInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 8.0, right: 0.0)
        static let titleInsets = UIEdgeInsets(top: 17.0, left: 0.0, bottom: 4.0, right: 0.0)
    }

    var presenter: OperationDefinitionPresenterProtocol!

    let containingFactory: ContainingViewFactoryProtocol
    let style: WalletStyleProtocol

    var localizableTitle: LocalizableResource<String>?

    override var accessoryStyle: WalletAccessoryStyleProtocol? {
        style.accessoryStyle
    }

    private var containerView = ScrollableContainerView()

    private var selectedAssetDef: OperationDefinition<SelectedAssetView>!
    private var amountInputDef: OperationDefinition<AmountInputView>!
    private var feeDefs: [OperationDefinition<FeeView>] = []
    private var descriptionInputDef: OperationDefinition<DescriptionInputView>!
    private var receiverDef: OperationDefinition<MultilineTitleIconView>?

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

        updateSeparators()

        configureStyle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocalization()

        presenter.setup()
    }

    private func configureContentView() {
        let selectedAssetView = containingFactory.createSelectedAssetView()
        selectedAssetView.delegate = self
        selectedAssetView.borderedView.borderType = [.bottom]
        selectedAssetView.heightAnchor.constraint(equalToConstant: Constants.assetHeight).isActive = true
        selectedAssetDef = OperationDefinition(mainView: selectedAssetView)

        let amountInputView = containingFactory.createAmountInputView(for: .large)
        amountInputView.borderedView.borderType = [.bottom]
        amountInputView.contentInsets = Constants.amountInsets
        amountInputView.keyboardIndicatorMode = .never
        let amountHeight = Constants.amountHeight + Constants.amountInsets.top + Constants.amountInsets.bottom
        amountInputView.heightAnchor.constraint(equalToConstant: amountHeight).isActive = true
        amountInputDef = OperationDefinition(mainView: amountInputView)

        let descriptionInputView = containingFactory.createDescriptionInputView()
        descriptionInputView.contentInsets = Constants.descriptionInsets
        descriptionInputView.keyboardIndicatorMode = .never
        descriptionInputView.borderedView.borderType = []
        descriptionInputDef = OperationDefinition(mainView: descriptionInputView)

        let views: [UIView] = [selectedAssetView, amountInputView, descriptionInputView]

        views.forEach {
            containerView.stackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalTo: view.widthAnchor,
                                      constant: -2 * Constants.horizontalMargin).isActive = true
        }
    }

    private func arrange(newView: UIView, before arrangedView: UIView) {
        if let index = containerView.stackView.arrangedSubviews.firstIndex(of: arrangedView) {
            containerView.stackView.insertArrangedSubview(newView, at: index)
            newView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                           constant: -2 * Constants.horizontalMargin).isActive = true
        }
    }

    private func arrange(newView: UIView, after arrangedView: UIView) {
        if let index = containerView.stackView.arrangedSubviews.firstIndex(of: arrangedView) {
            containerView.stackView.insertArrangedSubview(newView, at: index + 1)
            newView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                           constant: -2 * Constants.horizontalMargin).isActive = true
        }
    }

    private func updateSeparators() {
        if feeDefs.count > 1 {
            feeDefs[0..<feeDefs.count-1].forEach { feeDef in
                feeDef.mainView.borderedView.borderType = []
            }
        }

        feeDefs.last?.mainView.borderedView.borderType = [.bottom]
    }

    private func updatingDef<T: UIView>(_ definition: OperationDefinition<T>,
                                        withHeader viewModel: MultilineTitleIconViewModelProtocol)
        -> OperationDefinition<T> {

        var modifiedDefinition = definition

        if definition.titleView == nil {
            let titleView = containingFactory.createTitleView()
            titleView.contentInsets = Constants.titleInsets
            arrange(newView: titleView, before: modifiedDefinition.mainView)
            modifiedDefinition.titleView = titleView
        }

        modifiedDefinition.titleView?.bind(viewModel: viewModel)

        return modifiedDefinition
    }

    private func updatingDef<T: UIView>(_ definition: OperationDefinition<T>,
                                        withError viewModel: MultilineTitleIconViewModelProtocol)
        -> OperationDefinition<T> {

        var modifiedDefinition = definition

        if modifiedDefinition.errorView == nil {
            let errorView = containingFactory.createErrorView()
            arrange(newView: errorView, after: modifiedDefinition.mainView)
            modifiedDefinition.errorView = errorView
        }

        modifiedDefinition.titleView?.bind(viewModel: viewModel)

        return modifiedDefinition
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

    private func updateConfirmationState() {
        let isEnabled = (selectedAssetDef.mainView.viewModel?.isValid ?? false) &&
            (amountInputDef.mainView.inputViewModel?.isValid ?? false) &&
            (descriptionInputDef.mainView.viewModel?.isValid ?? false)

        accessoryView?.isActionEnabled = isEnabled
    }

    private func scrollToAmount(animated: Bool) {
        let amountFrame = containerView.scrollView.convert(amountInputDef.mainView.frame,
                                                           from: containerView.stackView)
        containerView.scrollView.scrollRectToVisible(amountFrame, animated: animated)
    }

    private func scrollToDescription(animated: Bool) {
        if let selectionRange = descriptionInputDef.mainView.textView.selectedTextRange {
            var caretRectangle = descriptionInputDef.mainView.textView.caretRect(for: selectionRange.start)
            caretRectangle.origin.x += descriptionInputDef.mainView.textView.frame.minX
            caretRectangle.origin.y += descriptionInputDef.mainView.textView.frame.minY

            let scrollFrame = containerView.scrollView.convert(caretRectangle, from: descriptionInputDef.mainView)
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

        if amountInputDef.mainView.amountField.isFirstResponder {
            scrollToAmount(animated: false)
        }

        if descriptionInputDef.mainView.textView.isFirstResponder {
            scrollToDescription(animated: false)
        }
    }

    @objc override func actionAccessory() {
        super.actionAccessory()

        amountInputDef.mainView.amountField.resignFirstResponder()
        descriptionInputDef.mainView.textView.resignFirstResponder()

        presenter.proceed()
    }
}


extension OperationDefinitionViewController: OperationDefinitionViewProtocol {

    func setAssetHeader(_ viewModel: MultilineTitleIconViewModelProtocol) {
        selectedAssetDef = updatingDef(selectedAssetDef, withHeader: viewModel)
    }

    func set(assetViewModel: AssetSelectionViewModelProtocol) {
        selectedAssetDef.mainView.viewModel?.observable.remove(observer: self)

        assetViewModel.observable.add(observer: self)

        selectedAssetDef.mainView.bind(viewModel: assetViewModel)
        amountInputDef.mainView.bind(assetSelectionViewModel: assetViewModel)

        updateConfirmationState()
    }

    func presentAssetError(_ message: String) {
        let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
        selectedAssetDef = updatingDef(selectedAssetDef, withError: viewModel)
    }

    func setAmountHeader(_ viewModel: MultilineTitleIconViewModelProtocol) {
        amountInputDef = updatingDef(amountInputDef, withHeader: viewModel)
    }

    func set(amountViewModel: AmountInputViewModelProtocol) {
        self.amountInputDef.mainView.inputViewModel?.observable.remove(observer: self)

        amountViewModel.observable.add(observer: self)

        amountInputDef.mainView.bind(inputViewModel: amountViewModel)

        updateConfirmationState()
    }

    func presentAmountError(_ message: String) {
        let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
        amountInputDef = updatingDef(amountInputDef, withError: viewModel)
    }

    func setReceiverHeader(_ viewModel: MultilineTitleIconViewModelProtocol) {
        guard let receiverDef = receiverDef else {
            return
        }

        self.receiverDef = updatingDef(receiverDef, withHeader: viewModel)
    }

    func set(receiverViewModel: MultilineTitleIconViewModelProtocol) {
        if receiverDef == nil {
            let mainView = containingFactory.createReceiver()
            receiverDef = OperationDefinition(mainView: mainView)

            let anchorView = selectedAssetDef.errorView ?? selectedAssetDef.mainView

            arrange(newView: mainView, after: anchorView)
        }
    }

    func presentReceiverError(_ message: String) {
        guard let receiverDef = receiverDef else {
            return
        }

        let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
        self.receiverDef = updatingDef(receiverDef, withError: viewModel)
    }

    func setDescriptionHeader(_ viewModel: MultilineTitleIconViewModelProtocol) {
        descriptionInputDef = updatingDef(descriptionInputDef, withHeader: viewModel)
    }

    func set(descriptionViewModel: DescriptionInputViewModelProtocol) {
        descriptionInputDef.mainView.viewModel?.observable.remove(observer: self)
        descriptionViewModel.observable.add(observer: self)

        descriptionInputDef.mainView.bind(viewModel: descriptionViewModel)

        updateConfirmationState()
    }

    func presentDescriptionError(_ message: String) {
        let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
        descriptionInputDef = updatingDef(descriptionInputDef, withError: viewModel)
    }

    func setFeeHeader(_ viewModel: MultilineTitleIconViewModelProtocol, at index: Int) {
        guard index < feeDefs.count else {
            return
        }

        feeDefs[index] = updatingDef(feeDefs[index], withHeader: viewModel)
    }

    func set(feeViewModels: [FeeViewModelProtocol]) {
        let newItemsCount = feeViewModels.count - feeDefs.count

        if newItemsCount > 0 {
            var anchorView = (feeDefs.last?.errorView ?? feeDefs.last?.mainView)
                ?? (amountInputDef.errorView ?? amountInputDef.mainView)

            (0..<newItemsCount).forEach { _ in
                let feeView = containingFactory.createFeeView()
                feeView.contentInsets = Constants.feeInsets

                feeDefs.append(OperationDefinition(mainView: feeView))

                arrange(newView: feeView, after: anchorView)

                anchorView = feeView
            }
        }

        if newItemsCount < 0 {
            feeDefs = Array(feeDefs[0..<feeViewModels.count])
        }

        for (index, viewModel) in feeViewModels.enumerated() {
            feeDefs[index].mainView.bind(viewModel: viewModel)
        }

        updateSeparators()
    }

    func presentFeeError(_ message: String, at index: Int) {
        guard index < feeDefs.count else {
            return
        }

        let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
        feeDefs[index] = updatingDef(feeDefs[index], withError: viewModel)
    }

    func set(accessoryViewModel: AccessoryViewModelProtocol) {
        accessoryView?.bind(viewModel: accessoryViewModel)
    }
}

extension OperationDefinitionViewController: SelectedAssetViewDelegate {
    func selectedAssetViewDidChange(_ view: SelectedAssetView) {
        if view.activated {
            presenter.presentAssetSelection()
        }
    }
}

extension OperationDefinitionViewController: AssetSelectionViewModelObserver {
    func assetSelectionDidChangeTitle() {
        updateConfirmationState()
    }

    func assetSelectionDidChangeSymbol() {}

    func assetSelectionDidChangeState() {}
}

extension OperationDefinitionViewController: AmountInputViewModelObserver {
    func amountInputDidChange() {
        updateConfirmationState()
    }
}

extension OperationDefinitionViewController: DescriptionInputViewModelObserver {
    func descriptionInputDidChangeText() {
        updateConfirmationState()
    }
}

extension OperationDefinitionViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
            view.setNeedsLayout()
        }
    }
}
