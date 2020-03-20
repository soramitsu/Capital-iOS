/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI
import SoraFoundation

final class AmountViewController: UIViewController, AdaptiveDesignable {
    private struct Constants {
        static let minimumDescriptionHeight: CGFloat = 45.0
        static let placeholderOpacity: CGFloat = 0.22
    }

    var presenter: AmountPresenterProtocol!

    var style: WalletStyleProtocol?

    var accessoryFactory: AccessoryViewFactoryProtocol.Type?

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var assetSeparator: BorderedContainerView!
    @IBOutlet private var assetTitleControl: ActionTitleControl!
    @IBOutlet private var amountField: UITextField!
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var amountSymbol: UILabel!
    @IBOutlet private var feeTitleLabel: UILabel!
    @IBOutlet private var feeActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private var amountSeparator: BorderedContainerView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var descriptionPlaceholderLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var descriptionHeight: NSLayoutConstraint!

    private var accessoryView: AccessoryViewProtocol?
    private var accessoryBottom: NSLayoutConstraint?

    private var assetSelectionViewModel: AssetSelectionViewModelProtocol?
    private var amountInputViewModel: AmountInputViewModelProtocol?
    private var descriptionInputViewModel: DescriptionInputViewModelProtocol?
    private var feeViewModel: FeeViewModelProtocol?

    private var keyboardHandler: KeyboardHandler?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureAccessoryView()
        configureStyle()
        setupLocalization()

        presenter.setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupKeyboardHandler()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        clearKeyboardHandler()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupContentInsets()
    }

    private func configureAccessoryView() {
        guard let style = style else {
            return
        }

        let optionalView = accessoryFactory?.createAccessoryView(from: style.accessoryStyle, target: self,
                                                                 completionSelector: #selector(actionNext))

        if let contentView = optionalView?.contentView {
            contentView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(contentView)

            if #available(iOS 11.0, *) {
                accessoryBottom = contentView.bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0)
            } else {
                accessoryBottom = contentView.bottomAnchor
                    .constraint(equalTo: view.bottomAnchor, constant: 0.0)
            }

            accessoryBottom?.isActive = true

            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: 0.0).isActive = true

            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: 0.0).isActive = true

            contentView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height).isActive = true

            accessoryView = optionalView

        }
    }
    
    private func configureStyle() {
        guard let style = style else {
            return
        }
        
        view.backgroundColor = style.backgroundColor
        
        [amountLabel, descriptionLabel, feeTitleLabel].forEach {
            $0?.textColor = style.captionTextColor
            $0?.font = style.bodyRegularFont
        }

        assetSeparator.strokeColor = style.thickBorderColor
        amountSeparator.strokeColor = style.thinBorderColor
        
        assetTitleControl.titleLabel.textColor = style.bodyTextColor
        assetTitleControl.titleLabel.font = style.bodyRegularFont
        assetTitleControl.imageView.image = style.downArrowIcon

        amountField.textColor = style.bodyTextColor
        amountField.font = style.header1Font

        amountSymbol.textColor = style.bodyTextColor
        amountSymbol.font = style.header1Font

        descriptionTextView.textColor = style.bodyTextColor
        descriptionTextView.font = style.bodyRegularFont

        if let caretColor = style.caretColor {
            amountField.tintColor = caretColor
            descriptionTextView.tintColor = caretColor
        }

        feeActivityIndicator.tintColor = style.captionTextColor

        descriptionPlaceholderLabel.textColor = style.bodyTextColor
            .withAlphaComponent(Constants.placeholderOpacity)
        descriptionPlaceholderLabel.font = style.bodyRegularFont
    }
    
    private func setupLocalization() {
        title = L10n.Amount.moduleTitle
        amountLabel.text = L10n.Amount.title
    }

    private func updateConfirmationState() {
        let isEnabled = (assetSelectionViewModel?.isValid ?? false) &&
            (amountInputViewModel?.isValid ?? false) &&
            (descriptionInputViewModel?.isValid ?? false)

        accessoryView?.isActionEnabled = isEnabled
    }

    private func updateDescriptionState() {
        let currentText = descriptionTextView.text ?? ""

        descriptionPlaceholderLabel.isHidden = !currentText.isEmpty

        let boundingSize = CGSize(width: descriptionTextView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let newContentSize = descriptionTextView.sizeThatFits(boundingSize)

        descriptionHeight.constant = max(newContentSize.height, Constants.minimumDescriptionHeight)

        scrollToDescription(animated: true)
    }

    // MARK: Keyboard Handling

    private func setupContentInsets() {
        let accessoryHeight = accessoryView?.contentView.frame.height ?? 0.0
        let accessoryBottomOffset = accessoryBottom?.constant ?? 0.0

        var currentInsets = scrollView.contentInset
        currentInsets.bottom = accessoryBottomOffset +  accessoryHeight
        scrollView.contentInset = currentInsets
    }

    private func setupKeyboardHandler() {
        keyboardHandler = KeyboardHandler()
        keyboardHandler?.animateOnFrameChange = animateKeyboardBoundsChange(for:)
    }

    private func clearKeyboardHandler() {
        keyboardHandler = nil
    }

    private func animateKeyboardBoundsChange(for keyboardFrame: CGRect) {
        let localKeyboardFrame = view.convert(keyboardFrame, from: nil)
        let safeAreaHeight = view.bounds.height - scrollView.frame.maxY
        let accessoryInset = max(view.bounds.height - safeAreaHeight - localKeyboardFrame.minY, 0.0)
        let accessoryHeight = accessoryView?.contentView.frame.height ?? 0.0

        accessoryBottom?.constant = -accessoryInset

        var currentInsets = scrollView.contentInset
        currentInsets.bottom = accessoryInset + accessoryHeight

        scrollView.contentInset = currentInsets

        view.layoutIfNeeded()

        if amountField.isFirstResponder {
            scrollToAmount(animated: false)
        }

        if descriptionTextView.isFirstResponder {
            scrollToDescription(animated: false)
        }
    }

    private func scrollToAmount(animated: Bool) {
        let amountFrame = scrollView.convert(amountField.frame, from: amountSeparator)
        scrollView.scrollRectToVisible(amountFrame, animated: animated)
    }

    private func scrollToDescription(animated: Bool) {
        if let selectionRange = descriptionTextView.selectedTextRange {
            var caretRectangle = descriptionTextView.caretRect(for: selectionRange.start)
            caretRectangle.origin.x += descriptionTextView.frame.minX
            caretRectangle.origin.y += descriptionTextView.frame.minY

            scrollView.scrollRectToVisible(caretRectangle, animated: animated)
        }
    }

    // MARK: Action
    
    @objc private func actionNext() {
        amountField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()

        presenter.confirm()
    }

    @IBAction private func actionTitleControl() {
        presenter.presentAssetSelection()
    }

    @objc private func actionClose() {
        presenter.close()
    }
}


extension AmountViewController: AmountViewProtocol {
    func set(assetViewModel: AssetSelectionViewModelProtocol) {
        self.assetSelectionViewModel?.observable.remove(observer: self)

        self.assetSelectionViewModel = assetViewModel
        assetViewModel.observable.add(observer: self)

        assetTitleControl.titleLabel.text = assetViewModel.title
        assetTitleControl.isUserInteractionEnabled = assetViewModel.canSelect
        assetTitleControl.imageView.image = assetViewModel.canSelect ? style?.downArrowIcon : nil
        assetTitleControl.invalidateLayout()

        amountSymbol.text = assetViewModel.symbol

        updateConfirmationState()
    }

    func set(amountViewModel: AmountInputViewModelProtocol) {
        self.amountInputViewModel?.observable.remove(observer: self)

        self.amountInputViewModel = amountViewModel
        amountViewModel.observable.add(observer: self)

        amountField.text = amountViewModel.displayAmount

        updateConfirmationState()
    }

    func set(descriptionViewModel: DescriptionInputViewModelProtocol) {
        self.descriptionInputViewModel = descriptionViewModel

        descriptionLabel.text = descriptionViewModel.title
        descriptionTextView.text = descriptionViewModel.text
        descriptionPlaceholderLabel.text = descriptionViewModel.placeholder

        updateDescriptionState()
        updateConfirmationState()
    }

    func set(accessoryViewModel: AccessoryViewModelProtocol) {
        accessoryView?.bind(viewModel: accessoryViewModel)
    }

    func set(feeViewModel: FeeViewModelProtocol) {
        self.feeViewModel?.observable.remove(observer: self)
        feeTitleLabel.text = feeViewModel.title

        if feeViewModel.isLoading {
            feeActivityIndicator.startAnimating()
        } else {
            feeActivityIndicator.stopAnimating()
        }

        self.feeViewModel = feeViewModel
        feeViewModel.observable.add(observer: self)

        updateConfirmationState()
    }
}

extension AmountViewController: AssetSelectionViewModelObserver {
    func assetSelectionDidChangeTitle() {
        assetTitleControl.titleLabel.text = assetSelectionViewModel?.title
        assetTitleControl.invalidateLayout()

        updateConfirmationState()
    }

    func assetSelectionDidChangeSymbol() {
        amountSymbol.text = assetSelectionViewModel?.symbol
    }

    func assetSelectionDidChangeState() {
        guard let isSelecting = assetSelectionViewModel?.isSelecting else {
            return
        }

        if isSelecting {
            assetTitleControl.activate(animated: true)
        } else {
            assetTitleControl.deactivate(animated: true)
        }
    }
}

extension AmountViewController: AmountInputViewModelObserver {
    func amountInputDidChange() {
        amountField.text = amountInputViewModel?.displayAmount

        updateConfirmationState()
    }
}

extension AmountViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        descriptionTextView.becomeFirstResponder()

        return false
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        return amountInputViewModel?.didReceiveReplacement(string, for: range) ?? false
    }
    
}

extension AmountViewController: FeeViewModelObserver {
    func feeTitleDidChange() {
        if let viewModel = feeViewModel {
            feeTitleLabel.text = viewModel.title
        }
    }

    func feeLoadingStateDidChange() {
        if let viewModel = feeViewModel {
            if viewModel.isLoading {
                feeActivityIndicator.startAnimating()
            } else {
                feeActivityIndicator.stopAnimating()
            }
        }
    }
}

extension AmountViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return descriptionInputViewModel?.didReceiveReplacement(text, for: range) ?? false
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count != descriptionInputViewModel?.text.count {
            /**
            *  prevent from crashing when text view updates text
            *  without asking delegate (it can insert padding spacing
            *  after swiping input on iOS 13).
            */
            textView.text = descriptionInputViewModel?.text
        }

        updateDescriptionState()
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
