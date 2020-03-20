/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

final class AmountInputView: UIView {
    @IBOutlet private(set) var borderedView: BorderedContainerView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var assetLabel: UILabel!
    @IBOutlet private(set) var amountField: UITextField!
    @IBOutlet private(set) var keyboardIndicator: ActionTitleControl!

    @IBOutlet private var topConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomConstraint: NSLayoutConstraint!

    private(set) var inputViewModel: AmountInputViewModelProtocol?
    private(set) var assetSelectionViewModel: AssetSelectionViewModelProtocol?

    var keyboardIndicatorSpacing: CGFloat = 8.0 {
        didSet {
            updateIndicatorState()
        }
    }

    var keyboardIndicatorIcon: UIImage? {
        didSet {
            updateIndicatorState()
        }
    }

    var keyboardIndicatorMode: KeyboardIndicatorDisplayMode = .editing {
        didSet {
            updateIndicatorState()
        }
    }

    var contentInsets: UIEdgeInsets {
        get {
            UIEdgeInsets(top: topConstraint.constant,
                         left: 0.0,
                         bottom: -bottomConstraint.constant,
                         right: 0.0)
        }

        set {
            topConstraint.constant = newValue.top
            bottomConstraint.constant = -newValue.bottom

            if superview != nil {
                setNeedsLayout()
            }
        }
    }

    func bind(inputViewModel: AmountInputViewModelProtocol) {
        self.inputViewModel?.observable.remove(observer: self)

        self.inputViewModel = inputViewModel
        inputViewModel.observable.add(observer: self)

        amountField.text = inputViewModel.displayAmount
    }

    func bind(assetSelectionViewModel: AssetSelectionViewModelProtocol) {
        self.assetSelectionViewModel?.observable.remove(observer: self)

        self.assetSelectionViewModel = assetSelectionViewModel
        assetSelectionViewModel.observable.add(observer: self)

        assetLabel.text = assetSelectionViewModel.symbol
    }

    // MARK: Private

    @IBAction private func actionControlDidChange() {
        if keyboardIndicator.isActivated {
            amountField.becomeFirstResponder()
        } else {
            amountField.resignFirstResponder()
        }
    }

    @IBAction private func actionTap(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == .ended,
            borderedView.frame.contains(gestureRecognizer.location(in: borderedView)) {
            amountField.becomeFirstResponder()
        }
    }

    private func updateIndicatorState() {
        let shouldHide: Bool

        switch keyboardIndicatorMode {
        case .never:
            shouldHide = true
        case .editing:
            shouldHide = !amountField.isFirstResponder
        case .always:
            shouldHide = false
        }

        if !shouldHide {
            keyboardIndicator.imageView.image = keyboardIndicatorIcon
            keyboardIndicator.horizontalSpacing = keyboardIndicatorSpacing
        } else {
            keyboardIndicator.imageView.image = nil
            keyboardIndicator.horizontalSpacing = 0
        }
    }
}

extension AmountInputView: AmountInputViewModelObserver {
    func amountInputDidChange() {
        amountField.text = inputViewModel?.displayAmount
    }
}

extension AmountInputView: AssetSelectionViewModelObserver {
    func assetSelectionDidChangeTitle() {}

    func assetSelectionDidChangeSymbol() {
        assetLabel.text = assetSelectionViewModel?.symbol
    }

    func assetSelectionDidChangeState() {}
}

extension AmountInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        return inputViewModel?.didReceiveReplacement(string, for: range) ?? false
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        updateIndicatorState()
        keyboardIndicator.activate(animated: true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateIndicatorState()
        keyboardIndicator.deactivate(animated: true)
    }
}
