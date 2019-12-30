/**
 * Copyright Soramitsu Co., Ltd. All Rights Reserved.
 * SPDX-License-Identifier: GPL-3.0
 */

import UIKit
import SoraUI
import SoraFoundation


final class WithdrawAmountViewController: AccessoryViewController {
    private struct Constants {
        static let minimumDescriptionHeight: CGFloat = 45.0
        static let placeholderOpacity: CGFloat = 0.22
    }

    var presenter: WithdrawAmountPresenterProtocol!

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var assetSeparator: BorderedContainerView!
    @IBOutlet private var assetTitleControl: ActionTitleControl!
    @IBOutlet private var amountField: UITextField!
    @IBOutlet private var amountLabel: UILabel!
    @IBOutlet private var amountSymbol: UILabel!
    @IBOutlet private var amountSeparator: BorderedContainerView!
    @IBOutlet private var feeTitleLabel: UILabel!
    @IBOutlet private var feeActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var descriptionPlaceholderLabel: UILabel!
    @IBOutlet private var descriptionTextView: UITextView!
    @IBOutlet private var descriptionHeight: NSLayoutConstraint!

    var style: WalletStyleProtocol?

    override var accessoryStyle: WalletAccessoryStyleProtocol? {
        return style?.accessoryStyle
    }

    private var assetSelectionViewModel: AssetSelectionViewModelProtocol?
    private var amountInputViewModel: AmountInputViewModelProtocol?
    private var descriptionInputViewModel: DescriptionInputViewModelProtocol?
    private var feeViewModel: FeeViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        applyStyle()
        
        setupLocalization()
        
        presenter.setup()
    }

    // MARK: Style

    private func setupLocalization() {
        amountLabel.text = L10n.Amount.send
    }

    private func applyStyle() {
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

        feeActivityIndicator.tintColor = style.captionTextColor

        descriptionTextView.textColor = style.bodyTextColor
        descriptionTextView.font = style.bodyRegularFont

        if let caretColor = style.caretColor {
            amountField.tintColor = caretColor
            descriptionTextView.tintColor = caretColor
        }

        descriptionPlaceholderLabel.textColor = style.bodyTextColor
            .withAlphaComponent(Constants.placeholderOpacity)
        descriptionPlaceholderLabel.font = style.bodyRegularFont
    }

    // MARK: Handle Changes

    private func updateDescriptionState() {
        let currentText = descriptionTextView.text ?? ""

        descriptionPlaceholderLabel.isHidden = !currentText.isEmpty

        let boundingSize = CGSize(width: descriptionTextView.frame.size.width, height: CGFloat.greatestFiniteMagnitude)
        let newContentSize = descriptionTextView.sizeThatFits(boundingSize)

        descriptionHeight.constant = max(newContentSize.height, Constants.minimumDescriptionHeight)

        if descriptionTextView.isFirstResponder {
            scrollToDescription(animated: true)
        }
    }

    private func updateConfirmationState() {
        let isEnabled = (assetSelectionViewModel?.isValid ?? false) &&
            (amountInputViewModel?.isValid ?? false) &&
            (descriptionInputViewModel?.isValid ?? false)

        accessoryView?.isActionEnabled = isEnabled
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

    // MARK: Override Superclass

    override func updateBottom(inset: CGFloat) {
        super.updateBottom(inset: inset)

        var currentInsets = scrollView.contentInset
        currentInsets.bottom = inset

        scrollView.contentInset = currentInsets

        view.layoutIfNeeded()

        if amountField.isFirstResponder {
            scrollToAmount(animated: false)
        }

        if descriptionTextView.isFirstResponder {
            scrollToDescription(animated: false)
        }
    }

    @objc override func actionAccessory() {
        super.actionAccessory()

        amountField.resignFirstResponder()
        descriptionTextView.resignFirstResponder()

        presenter.confirm()
    }

    // MARK: Action

    @IBAction private func actionTitleControl() {
        presenter.presentAssetSelection()
    }
}

extension WithdrawAmountViewController: WithdrawAmountViewProtocol {
    func set(title: String) {
        self.title = title
    }

    func set(assetViewModel: AssetSelectionViewModelProtocol) {
        self.assetSelectionViewModel?.observable.remove(observer: self)

        assetTitleControl.titleLabel.text = assetViewModel.title
        assetTitleControl.isUserInteractionEnabled = assetViewModel.canSelect
        assetTitleControl.imageView.image = assetViewModel.canSelect ? style?.downArrowIcon : nil
        assetTitleControl.invalidateLayout()

        amountSymbol.text = assetViewModel.symbol

        self.assetSelectionViewModel = assetViewModel
        assetViewModel.observable.add(observer: self)

        updateConfirmationState()
    }
    
    func set(amountViewModel: AmountInputViewModelProtocol) {
        self.amountInputViewModel?.observable.remove(observer: self)

        amountField.text = amountViewModel.displayAmount

        self.amountInputViewModel = amountViewModel

        amountViewModel.observable.add(observer: self)

        updateConfirmationState()
    }

    func set(descriptionViewModel: DescriptionInputViewModelProtocol) {
        descriptionLabel.text = descriptionViewModel.title
        descriptionTextView.text = descriptionViewModel.text
        descriptionPlaceholderLabel.text = descriptionViewModel.placeholder

        self.descriptionInputViewModel = descriptionViewModel

        updateDescriptionState()
        updateConfirmationState()
    }

    func didChange(accessoryViewModel: AccessoryViewModelProtocol) {
        accessoryView?.bind(viewModel: accessoryViewModel)
        updateConfirmationState()
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

extension WithdrawAmountViewController: AssetSelectionViewModelObserver {
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

extension WithdrawAmountViewController: AmountInputViewModelObserver {
    func amountInputDidChange() {
        amountField.text = amountInputViewModel?.displayAmount

        updateConfirmationState()
    }
}

extension WithdrawAmountViewController: FeeViewModelObserver {
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

extension WithdrawAmountViewController: UITextFieldDelegate {

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

extension WithdrawAmountViewController: UITextViewDelegate {

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

extension WithdrawAmountViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
            view.setNeedsLayout()
        }
    }
}
