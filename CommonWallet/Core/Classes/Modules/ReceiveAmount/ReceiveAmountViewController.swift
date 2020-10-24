/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI
import SoraFoundation


final class ReceiveAmountViewController: UIViewController, AdaptiveDesignable {
    private struct Constants {
        static let horizontalMargin: CGFloat = 20.0
        static let verticalSpacing: CGFloat = 17.0
        static let bottomMargin: CGFloat = 8.0
        static let collapsedQrMargin: CGFloat = 6.0
        static let collapsedQrBackgroundHeight: CGFloat = 230.0
        static let expandedQrMargin: CGFloat = 40.0
        static let expandedQrBackgroundHeight: CGFloat = 440.0
        static let assetViewHeight: CGFloat = 54.0
        static let amountViewHeight: CGFloat = 31.0
        static let separatorHeight: CGFloat = 1.0
        static let expandedAdaptiveScaleWhenDecreased: CGFloat = 0.9
    }

    enum LayoutState {
        case collapsed
        case expanded
    }

    var presenter: ReceiveAmountPresenterProtocol!

    let containingFactory: ContainingViewFactoryProtocol

    let style: WalletStyleProtocol
    let viewStyle: ReceiveStyleProtocol
    let customViewFactory: ReceiveViewFactoryProtocol?

    var localizableTitle: LocalizableResource<String>?

    private(set) var layoutState: LayoutState = .expanded {
        didSet {
            if layoutState != oldValue {
                updateLayoutConstraints(for: layoutState)
            }
        }
    }

    private var containerView = ScrollableContainerView()

    private var qrView: QRView!
    private var qrSeparatorView: BorderedContainerView!
    private var selectedAssetView: SelectedAssetView?
    private var amountInputTitleView: MultilineTitleIconView?
    private var amountInputView: AmountInputView?
    private var descriptionInputTitleView: MultilineTitleIconView?
    private var descriptionInputView: DescriptionInputView?

    private var qrHeight: NSLayoutConstraint!
    private var amountHeight: NSLayoutConstraint!

    private var keyboardHandler: KeyboardHandler?

    init(containingFactory: ContainingViewFactoryProtocol,
         customViewFactory: ReceiveViewFactoryProtocol?,
         viewStyle: ReceiveStyleProtocol,
         style: WalletStyleProtocol) {
        self.containingFactory = containingFactory
        self.customViewFactory = customViewFactory
        self.viewStyle = viewStyle
        self.style = style

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = containerView

        configureNavigationItems()
        configureContentView()

        adjustLayout()
        applyStyle()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupLocalization()

        if let qrSize = viewStyle.qrSize {
            presenter.setup(qrSize: qrSize)
        } else {
            let qrHeight = calculateQrBackgrounHeight(for: .expanded)
            let qrMargin = calculateQrMargin(for: .expanded)
            presenter.setup(qrSize: CGSize(width: qrHeight - 2 * qrMargin, height: qrHeight - 2 * qrMargin))
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupKeyboardHandler()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        clearKeyboardHandler()
    }

    private func configureContentView() {
        qrView = containingFactory.createQrView()
        qrView.backgroundColor = viewStyle.qrBackgroundColor
        qrView.imageView.contentMode = viewStyle.qrMode
        qrView.margin = Constants.expandedQrMargin
        qrView.borderedView.borderType = []

        let height = viewStyle.qrSize?.height ?? Constants.expandedQrBackgroundHeight
        qrHeight = qrView.heightAnchor.constraint(equalToConstant: height)
        qrHeight?.isActive = true

        qrSeparatorView = createSeparatorView()

        let views: [UIView]

        if let header = customViewFactory?.createHeaderView() {
            views = [header, qrView, qrSeparatorView]
        } else {
            views = [qrView, qrSeparatorView]
        }

        views.forEach { containerView.stackView.addArrangedSubview($0) }

        views[0...1].forEach {
            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        }

        if views.count > 2 {
            views[2...].forEach {
                $0.widthAnchor.constraint(equalTo: view.widthAnchor,
                                          constant: -2 * Constants.horizontalMargin).isActive = true
            }
        }
    }

    private func configureNavigationItems() {
        let shareItem = UIBarButtonItem(image: style.shareIcon,
                                        style: .plain,
                                        target: self,
                                        action: #selector(actionShare))

        navigationItem.rightBarButtonItem = shareItem
    }

    private func createSeparatorView() -> BorderedContainerView {
        let separatorView = containingFactory.createSeparatorView()
        separatorView.strokeWidth = Constants.separatorHeight
        separatorView.borderType = []

        separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorHeight).isActive = true

        return separatorView
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
        if selectedAssetView != nil || amountInputView != nil || descriptionInputView != nil {
            qrSeparatorView.borderType = [.top]
        } else {
            qrSeparatorView.borderType = []
        }

        if amountInputView != nil || descriptionInputView != nil {
            selectedAssetView?.borderType = [.bottom]
        } else {
            selectedAssetView?.borderType = []
        }

        if descriptionInputView != nil {
            amountInputView?.borderType = [.bottom]
        } else {
            amountInputView?.borderType = []
        }

        descriptionInputView?.borderType = []
    }

    private func updateKeyboardIndicatorModes() {
        if amountInputView != nil, descriptionInputView != nil {
            amountInputView?.keyboardIndicatorMode = .editing
            descriptionInputView?.keyboardIndicatorMode = .editing
        } else {
            amountInputView?.keyboardIndicatorMode = .always
            descriptionInputView?.keyboardIndicatorMode = .always
        }
    }

    private func addSelectedAssetView() {
        let selectedAssetView = containingFactory.createSelectedAssetView()
        selectedAssetView.borderedView.borderType = [.bottom]
        selectedAssetView.delegate = self

        selectedAssetView.heightAnchor.constraint(equalToConstant: Constants.assetViewHeight).isActive = true

        arrange(newView: selectedAssetView, after: qrSeparatorView)

        self.selectedAssetView = selectedAssetView

        updateSeparators()
    }

    private func addDescriptionView() {
        let descriptionInputTitleView = containingFactory.createTitleView()
        descriptionInputTitleView.contentInsets = UIEdgeInsets(top: Constants.verticalSpacing,
                                                               left: 0.0,
                                                               bottom: Constants.bottomMargin,
                                                               right: 0.0)

        let descriptionView = containingFactory.createDescriptionInputView()
        descriptionView.contentInsets = UIEdgeInsets(top: 0.0, left: 0.0,
                                                     bottom: Constants.bottomMargin, right: 0.0)

        containerView.stackView.addArrangedSubview(descriptionInputTitleView)
        containerView.stackView.addArrangedSubview(descriptionView)

        descriptionInputTitleView.widthAnchor
            .constraint(equalTo: view.widthAnchor,
                        constant: -2 * Constants.horizontalMargin).isActive = true

        descriptionView.widthAnchor.constraint(equalTo: view.widthAnchor,
                                               constant: -2 * Constants.horizontalMargin).isActive = true

        self.descriptionInputView = descriptionView
        self.descriptionInputTitleView = descriptionInputTitleView

        setupDescriptionTitleLocalizationIfNeeded()

        updateKeyboardIndicatorModes()
        updateSeparators()
    }

    private func addAmountView() {
        let amountInputTitleView = containingFactory.createTitleView()
        amountInputTitleView.contentInsets = UIEdgeInsets(top: Constants.verticalSpacing,
                                                          left: 0.0,
                                                          bottom: Constants.bottomMargin,
                                                          right: 0.0)

        let amountInputView = containingFactory.createAmountInputView(for: .small)
        amountInputView.contentInsets = UIEdgeInsets(top: 0.0, left: 0.0,
                                                     bottom: Constants.bottomMargin, right: 0.0)

        let amountHeightValue = Constants.amountViewHeight + Constants.bottomMargin
        amountHeight = amountInputView.heightAnchor
            .constraint(equalToConstant: amountHeightValue)
        amountHeight.isActive = true

        if let selectedAssetView = selectedAssetView {
            arrange(newView: amountInputTitleView, after: selectedAssetView)
        } else {
            arrange(newView: amountInputTitleView, after: qrSeparatorView)
        }

        arrange(newView: amountInputView, after: amountInputTitleView)

        self.amountInputTitleView = amountInputTitleView
        self.amountInputView = amountInputView

        setupAmountTitleLocalization()

        updateKeyboardIndicatorModes()
        updateSeparators()
    }

    private func setupLocalization() {
        setupTitleLocalization()
        setupAmountTitleLocalization()
        setupDescriptionTitleLocalizationIfNeeded()
    }

    private func setupTitleLocalization() {
        let locale = localizationManager?.selectedLocale ?? Locale.current

        if let localizableTitle = localizableTitle {
            title = localizableTitle.value(for: locale)
        }
    }

    private func setupAmountTitleLocalization() {
        let amountTitleViewModel = MultilineTitleIconViewModel(text: L10n.Amount.title)
        amountInputTitleView?.bind(viewModel: amountTitleViewModel)
    }

    private func setupDescriptionTitleLocalizationIfNeeded() {
        if let descriptionTitleView = descriptionInputTitleView {
            let viewModel = MultilineTitleIconViewModel(text: L10n.Common.description)
            descriptionTitleView.bind(viewModel: viewModel)
        }
    }

    private func adjustLayout() {
        updateLayoutConstraints(for: layoutState)
    }

    private func applyStyle() {
        view.backgroundColor = style.backgroundColor
    }

    private func updateLayoutConstraints(for state: LayoutState) {
        qrView?.margin = viewStyle.qrMargin ?? calculateQrMargin(for: state)
        qrHeight?.constant = viewStyle.qrSize?.height ?? calculateQrBackgrounHeight(for: state)
    }

    private func calculateQrMargin(for state: LayoutState) -> CGFloat {
        var qrMargin: CGFloat

        switch state {
        case .collapsed:
            qrMargin = Constants.collapsedQrMargin
        case .expanded:
            qrMargin = Constants.expandedQrMargin

            if isAdaptiveWidthDecreased {
                qrMargin *= Constants.expandedAdaptiveScaleWhenDecreased
            }
        }

        qrMargin *= designScaleRatio.width

        return qrMargin
    }

    private func calculateQrBackgrounHeight(for state: LayoutState) -> CGFloat {
        var qrBackgroundHeight: CGFloat

        switch state {
        case .collapsed:
            qrBackgroundHeight = Constants.collapsedQrBackgroundHeight
        case .expanded:
            qrBackgroundHeight = Constants.expandedQrBackgroundHeight

            if isAdaptiveWidthDecreased {
                qrBackgroundHeight *= Constants.expandedAdaptiveScaleWhenDecreased
            }
        }

        qrBackgroundHeight *= designScaleRatio.width

        return qrBackgroundHeight
    }

    // MARK: Keyboard Handling

    private func setupKeyboardHandler() {
        keyboardHandler = KeyboardHandler()
        keyboardHandler?.animateOnFrameChange = animateKeyboardBoundsChange(for:)
    }

    private func clearKeyboardHandler() {
        keyboardHandler = nil
    }

    private func animateKeyboardBoundsChange(for keyboardFrame: CGRect) {
        let localKeyboardFrame = view.convert(keyboardFrame, from: nil)
        containerView.scrollBottomOffset = max(view.bounds.maxY - localKeyboardFrame.minY, 0.0)

        if containerView.scrollBottomOffset > 0.0 {
            layoutState = .collapsed
        } else {
            layoutState = .expanded
        }

        view.layoutIfNeeded()

        if containerView.scrollBottomOffset > 0.0 {
            scrollToFirstReponder(for: localKeyboardFrame)
        } else {
            scrollToQrCode()
        }
    }

    private func scrollToFirstReponder(for localKeyboardFrame: CGRect) {
        let inputView: UIView?

        if let descriptionView = descriptionInputView, descriptionView.textView.isFirstResponder {
            inputView = descriptionView
        } else if let amountView = amountInputView, amountView.isFirstResponder {
            inputView = amountView
        } else {
            inputView = nil
        }

        guard let currentInputView = inputView else {
            return
        }

        let scrollHeight = view.bounds.maxY - containerView.scrollView.frame.minY -
            containerView.scrollBottomOffset
        let currentInputFrame = containerView.scrollView.convert(currentInputView.frame,
                                                                 from: containerView.stackView)

        if containerView.scrollView.contentOffset.y + scrollHeight < currentInputFrame.maxY {
            let contentOffset = CGPoint(x: 0.0, y: currentInputFrame.maxY - scrollHeight)
            containerView.scrollView.contentOffset = contentOffset
        }
    }

    private func scrollToQrCode() {
        containerView.scrollView.contentOffset = .zero
    }

    // MARK: Action

    @objc private func actionShare() {
        presenter.share()
    }
}


extension ReceiveAmountViewController: ReceiveAmountViewProtocol {
    func didReceive(image: UIImage) {
        qrView.imageView.image = image
    }

    func didReceive(assetSelectionViewModel: AssetSelectionViewModelProtocol) {
        if selectedAssetView == nil {
            addSelectedAssetView()
        }

        selectedAssetView?.bind(viewModel: assetSelectionViewModel)
    }

    func didReceive(amountInputViewModel: AmountInputViewModelProtocol) {
        if amountInputView == nil {
            addAmountView()
        }

        amountInputView?.bind(inputViewModel: amountInputViewModel)
    }

    func didReceive(descriptionViewModel: DescriptionInputViewModelProtocol) {
        if descriptionInputView == nil {
            addDescriptionView()
        }

        descriptionInputView?.bind(viewModel: descriptionViewModel)
    }
}

extension ReceiveAmountViewController: SelectedAssetViewDelegate {
    func selectedAssetViewDidChange(_ view: SelectedAssetViewProtocol) {
        if view.activated {
            presenter.presentAssetSelection()
        }
    }
}

extension ReceiveAmountViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
            view.setNeedsLayout()
        }
    }
}
