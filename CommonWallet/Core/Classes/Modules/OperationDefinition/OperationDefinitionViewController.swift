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
        static let amountHeight: CGFloat = 42.0
    }

    var presenter: OperationDefinitionPresenterProtocol!

    let containingFactory: OperationDefinitionViewFactoryProtocol
    let style: WalletStyleProtocol

    var localizableTitle: LocalizableResource<String>?

    var separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol
        = DefaultSeparatorsDistribution() {
        didSet {
            if isViewLoaded {
                updateSeparators()
            }
        }
    }

    override var accessoryStyle: WalletAccessoryStyleProtocol? {
        style.accessoryStyle
    }

    private var containerView = ScrollableContainerView()

    private var selectedAssetDef: OperationDefinition<UIView>!
    private var selectedAssetView: BaseSelectedAssetView!

    private var amountInputDef: OperationDefinition<UIView>!
    private var amountInputView: BaseAmountInputView!

    private var feeDefs: [OperationDefinition<UIView>] = []
    private var feeViews: [BaseFeeView] = []

    private var descriptionInputDef: OperationDefinition<UIView>?
    private var descriptionInputView: BaseDescriptionInputView?

    private var receiverDef: OperationDefinition<UIView>?
    private var receiverView: BaseReceiverView?

    init(containingFactory: OperationDefinitionViewFactoryProtocol, style: WalletStyleProtocol) {
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
        let selectedAssetView = containingFactory.createAssetView()
        selectedAssetView.delegate = self
        self.selectedAssetDef = OperationDefinition(mainView: selectedAssetView)
        self.selectedAssetView = selectedAssetView

        let amountInputView = containingFactory.createAmountView()

        self.amountInputView = amountInputView

        if amountInputView.intrinsicContentSize.height == UIView.noIntrinsicMetric {
            let amountHeight = Constants.amountHeight + amountInputView.contentInsets.top
                + amountInputView.contentInsets.bottom
            amountInputView.heightAnchor
                .constraint(equalToConstant: amountHeight).isActive = true
        }

        amountInputDef = OperationDefinition(mainView: amountInputView)

        let views: [UIView] = [selectedAssetView, amountInputView]

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

    private func rearrangeByRemoving(view: UIView) {
        containerView.stackView.removeArrangedSubview(view)
        view.removeFromSuperview()
    }

    private func updateSeparators() {
        selectedAssetView.borderType = separatorsDistribution.assetBorderType

        receiverView?.borderType = separatorsDistribution.receiverBorderType

        if feeDefs.count > 0 {
            amountInputView.borderType = separatorsDistribution.amountWithFeeBorderType
        } else {
            amountInputView.borderType = separatorsDistribution.amountWithoutFeeBorderType
        }

        if feeDefs.count == 1 {
            feeViews.first?.borderType = separatorsDistribution.singleFeeBorderType
        } else if feeDefs.count > 1 {
            feeViews.first?.borderType = separatorsDistribution.firstFeeBorderType
            feeViews.last?.borderType = separatorsDistribution.lastFeeBorderType

            feeViews[1..<feeDefs.count-1].forEach { feeView in
                feeView.borderType = separatorsDistribution.middleFeeBorderType
            }
        }

        descriptionInputView?.borderType = separatorsDistribution.descriptionBorderType
    }

    private func updatingDef<T: UIView>(_ definition: OperationDefinition<T>,
                                        type: OperationDefinitionType,
                                        withHeader viewModel: MultilineTitleIconViewModelProtocol)
        -> OperationDefinition<T> {

        var modifiedDefinition = definition

        if definition.titleView == nil {
            let titleView = containingFactory.createHeaderViewForItem(type: type)
            arrange(newView: titleView, before: modifiedDefinition.mainView)
            modifiedDefinition.titleView = titleView
        }

        modifiedDefinition.titleView?.bind(viewModel: viewModel)

        return modifiedDefinition
    }

    private func updatingDef<T: UIView>(_ definition: OperationDefinition<T>,
                                        type: OperationDefinitionType,
                                        withError viewModel: MultilineTitleIconViewModelProtocol)
        -> OperationDefinition<T> {

        var modifiedDefinition = definition

        if modifiedDefinition.errorView == nil {
            let errorView = containingFactory.createErrorViewForItem(type: type)
            arrange(newView: errorView, after: modifiedDefinition.mainView)
            modifiedDefinition.errorView = errorView
        }

        modifiedDefinition.errorView?.bind(viewModel: viewModel)

        return modifiedDefinition
    }

    private func updatingDefByRemovingHeader<T: UIView>(_ definition: OperationDefinition<T>)
        -> OperationDefinition<T> {
        var modifiedDefinition = definition

        if let headerView = modifiedDefinition.titleView {
            modifiedDefinition.titleView = nil
            rearrangeByRemoving(view: headerView)
        }

        return modifiedDefinition
    }

    private func updatingDefByRemovingError<T: UIView>(_ definition: OperationDefinition<T>)
        -> OperationDefinition<T> {
        var modifiedDefinition = definition

        if let errorView = modifiedDefinition.errorView {
            modifiedDefinition.errorView = nil
            rearrangeByRemoving(view: errorView)
        }

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
        let isEnabled = (amountInputView.inputViewModel?.isValid ?? false) &&
            (descriptionInputView?.viewModel?.isValid ?? true)

        accessoryView?.isActionEnabled = isEnabled
    }

    private func scrollToAmount(animated: Bool) {
        let amountFrame = containerView.scrollView.convert(amountInputDef.mainView.frame,
                                                           from: containerView.stackView)
        containerView.scrollView.scrollRectToVisible(amountFrame, animated: animated)
    }

    private func scrollToDescription(animated: Bool) {
        if let descriptionView = descriptionInputView,
            let selectedFrame = descriptionView.selectedFrame {
            let scrollFrame = containerView.scrollView.convert(selectedFrame,
                                                               from: descriptionView)
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

        if amountInputView.isFirstResponder {
            scrollToAmount(animated: false)
        }

        if let descriptionView = descriptionInputView, descriptionView.isFirstResponder {
            scrollToDescription(animated: false)
        }
    }

    @objc override func actionAccessory() {
        super.actionAccessory()

        amountInputDef.mainView.resignFirstResponder()
        descriptionInputView?.resignFirstResponder()

        presenter.proceed()
    }
}


extension OperationDefinitionViewController: OperationDefinitionViewProtocol {

    func setAssetHeader(_ viewModel: MultilineTitleIconViewModelProtocol?) {
        if let viewModel = viewModel {
            selectedAssetDef = updatingDef(selectedAssetDef, type: .asset, withHeader: viewModel)
        } else {
            selectedAssetDef = updatingDefByRemovingHeader(selectedAssetDef)
        }
    }

    func set(assetViewModel: AssetSelectionViewModelProtocol) {
        selectedAssetView.bind(viewModel: assetViewModel)

        updateConfirmationState()
    }

    func presentAssetError(_ message: String?) {
        if let message = message {
            let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
            selectedAssetDef = updatingDef(selectedAssetDef, type: .asset, withError: viewModel)
        } else {
            selectedAssetDef = updatingDefByRemovingError(selectedAssetDef)
        }
    }

    func setAmountHeader(_ viewModel: MultilineTitleIconViewModelProtocol?) {
        if let viewModel = viewModel {
            amountInputDef = updatingDef(amountInputDef, type: .amount, withHeader: viewModel)
        } else {
            amountInputDef = updatingDefByRemovingHeader(amountInputDef)
        }
    }

    func set(amountViewModel: AmountInputViewModelProtocol) {
        self.amountInputView.inputViewModel?.observable.remove(observer: self)

        amountViewModel.observable.add(observer: self)

        amountInputView.bind(inputViewModel: amountViewModel)

        updateConfirmationState()
    }

    func presentAmountError(_ message: String?) {
        if let message = message {
            let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
            amountInputDef = updatingDef(amountInputDef, type: .amount, withError: viewModel)
        } else {
            amountInputDef = updatingDefByRemovingError(amountInputDef)
        }
    }

    func setReceiverHeader(_ viewModel: MultilineTitleIconViewModelProtocol?) {
        guard let receiverDef = receiverDef else {
            return
        }

        if let viewModel = viewModel {
            self.receiverDef = updatingDef(receiverDef, type: .receiver, withHeader: viewModel)
        } else {
            self.receiverDef = updatingDefByRemovingHeader(receiverDef)
        }
    }

    func set(receiverViewModel: MultilineTitleIconViewModelProtocol) {
        if let receiveView = receiverView {
            receiveView.bind(viewModel: receiverViewModel)
        } else {
            let mainView = containingFactory.createReceiverView()

            receiverDef = OperationDefinition(mainView: mainView)
            receiverView = mainView

            let anchorView = selectedAssetDef.errorView ?? selectedAssetDef.mainView

            arrange(newView: mainView, after: anchorView)

            mainView.bind(viewModel: receiverViewModel)

            updateSeparators()
        }
    }

    func presentReceiverError(_ message: String?) {
        guard let receiverDef = receiverDef else {
            return
        }

        if let message = message {
            let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
            self.receiverDef = updatingDef(receiverDef, type: .receiver, withError: viewModel)
        } else {
            self.receiverDef = updatingDefByRemovingError(receiverDef)
        }
    }

    func setDescriptionHeader(_ viewModel: MultilineTitleIconViewModelProtocol?) {
        guard let descriptionDef = descriptionInputDef else {
            return
        }

        if let viewModel = viewModel {
            descriptionInputDef = updatingDef(descriptionDef, type: .description, withHeader: viewModel)
        } else {
            descriptionInputDef = updatingDefByRemovingHeader(descriptionDef)
        }
    }

    func set(descriptionViewModel: DescriptionInputViewModelProtocol) {
        if descriptionInputDef == nil {
            let view = containingFactory.createDescriptionView()

            descriptionInputDef = OperationDefinition(mainView: view)
            descriptionInputView = view

            let anchorView: UIView

            if let lastFee = feeDefs.last {
                anchorView = lastFee.errorView ?? lastFee.mainView
            } else {
                anchorView = amountInputDef.errorView ?? amountInputDef.mainView
            }

            arrange(newView: view, after: anchorView)

            descriptionViewModel.observable.add(observer: self)

            view.bind(viewModel: descriptionViewModel)

            updateSeparators()
        } else {
            descriptionInputView?.viewModel?.observable.remove(observer: self)
            descriptionViewModel.observable.add(observer: self)

            descriptionInputView?.bind(viewModel: descriptionViewModel)
        }

        updateConfirmationState()
    }

    func presentDescriptionError(_ message: String?) {
        guard let descriptionDef = descriptionInputDef else {
            return
        }

        if let message = message {
            let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
            descriptionInputDef = updatingDef(descriptionDef, type: .description, withError: viewModel)
        } else {
            descriptionInputDef = updatingDefByRemovingError(descriptionDef)
        }
    }

    func setFeeHeader(_ viewModel: MultilineTitleIconViewModelProtocol?, at index: Int) {
        guard index < feeDefs.count else {
            return
        }

        if let viewModel = viewModel {
            feeDefs[index] = updatingDef(feeDefs[index], type: .fee, withHeader: viewModel)
        } else {
            feeDefs[index] = updatingDefByRemovingHeader(feeDefs[index])
        }
    }

    func set(feeViewModels: [FeeViewModelProtocol]) {
        let newItemsCount = feeViewModels.count - feeDefs.count

        if newItemsCount > 0 {
            var anchorView = (feeDefs.last?.errorView ?? feeDefs.last?.mainView)
                ?? (amountInputDef.errorView ?? amountInputDef.mainView)

            (0..<newItemsCount).forEach { _ in
                let feeView = containingFactory.createFeeView()

                feeDefs.append(OperationDefinition(mainView: feeView))
                feeViews.append(feeView)

                arrange(newView: feeView, after: anchorView)

                anchorView = feeView
            }
        }

        if newItemsCount < 0 {
            feeDefs[feeViewModels.count..<feeDefs.count].forEach { def in
                if let headerView = def.titleView {
                    rearrangeByRemoving(view: headerView)
                }

                rearrangeByRemoving(view: def.mainView)

                if let errorView = def.errorView {
                    rearrangeByRemoving(view: errorView)
                }
            }

            feeDefs = Array(feeDefs[0..<feeViewModels.count])
        }

        for (index, viewModel) in feeViewModels.enumerated() {
            feeViews[index].bind(viewModel: viewModel)
        }

        updateSeparators()
    }

    func presentFeeError(_ message: String?, at index: Int) {
        guard index < feeDefs.count else {
            return
        }

        if let message = message {
            let viewModel = MultilineTitleIconViewModel(text: message, icon: style.inlineErrorStyle.icon)
            feeDefs[index] = updatingDef(feeDefs[index], type: .fee, withError: viewModel)
        } else {
            feeDefs[index] = updatingDefByRemovingError(feeDefs[index])
        }
    }

    func set(accessoryViewModel: AccessoryViewModelProtocol) {
        accessoryView?.bind(viewModel: accessoryViewModel)
    }
}

extension OperationDefinitionViewController: SelectedAssetViewDelegate {
    func selectedAssetViewDidChange(_ view: SelectedAssetViewProtocol) {
        if view.activated {
            presenter.presentAssetSelection()
        }
    }
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
