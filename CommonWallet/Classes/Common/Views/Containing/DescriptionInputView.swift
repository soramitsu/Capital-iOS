/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

final class DescriptionInputView: UIView {
    @IBOutlet private(set) var borderedView: BorderedContainerView!
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var placeholderLabel: UILabel!
    @IBOutlet private(set) var keyboardIndicator: ActionTitleControl!
    @IBOutlet private(set) var textView: UITextView!
    @IBOutlet private var placeholderTop: NSLayoutConstraint!
    @IBOutlet private var textViewTop: NSLayoutConstraint!

    @IBOutlet private var topConstraint: NSLayoutConstraint!

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

    private(set) var viewModel: DescriptionInputViewModelProtocol?

    var contentInsets: UIEdgeInsets = .zero {
        didSet {
            topConstraint.constant = contentInsets.top

            if superview != nil {
                invalidateIntrinsicContentSize()
                setNeedsLayout()
            }
        }
    }

    var minimumHeight: CGFloat = 65.0 {
        didSet {
            if superview != nil {
                invalidateIntrinsicContentSize()
            }
        }
    }

    override var intrinsicContentSize: CGSize {
        let textBoundingSize = CGSize(width: textView.frame.size.width,
                                      height: CGFloat.greatestFiniteMagnitude)
        let newTextSize = textView.sizeThatFits(textBoundingSize)

        let height = contentInsets.top + titleLabel.intrinsicContentSize.height +
            placeholderTop.constant + textViewTop.constant + newTextSize.height +
            contentInsets.bottom

        return CGSize(width: UIView.noIntrinsicMetric, height: max(minimumHeight, height))
    }

    func bind(viewModel: DescriptionInputViewModelProtocol) {
        self.viewModel = viewModel

        titleLabel.text = viewModel.title
        placeholderLabel.text = viewModel.placeholder
        textView.text = viewModel.text

        updateState()
    }

    // MARK: Private

    @IBAction private func actionControlDidChange() {
        if keyboardIndicator.isActivated {
            textView.becomeFirstResponder()
        } else {
            textView.resignFirstResponder()
        }
    }

    @IBAction private func actionTap(_ gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == .ended,
            borderedView.frame.contains(gestureRecognizer.location(in: borderedView)) {
            textView.becomeFirstResponder()
        }
    }

    private func updateState() {
        let currentText = textView.text ?? ""

        placeholderLabel.isHidden = !currentText.isEmpty

        invalidateIntrinsicContentSize()
    }

    private func updateIndicatorState() {
        let shouldHide: Bool

        switch keyboardIndicatorMode {
        case .never:
            shouldHide = true
        case .editing:
            shouldHide = !textView.isFirstResponder
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

extension DescriptionInputView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return viewModel?.didReceiveReplacement(text, for: range) ?? false
    }

    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count != viewModel?.text.count {
            /**
            *  prevent from crashing when text view updates text
            *  without asking delegate (it can insert padding spacing
            *  after swiping input on iOS 13).
            */
            textView.text = viewModel?.text
        }

        updateState()
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        updateIndicatorState()
        keyboardIndicator.activate(animated: true)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        updateIndicatorState()
        keyboardIndicator.deactivate(animated: true)
    }
}
