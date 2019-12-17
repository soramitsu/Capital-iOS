/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI


final class ReceiveAmountViewController: UIViewController, AdaptiveDesignable {
    private struct Constants {
        static let collapsedQrSize: CGSize = CGSize(width: 228.0, height: 228.0)
        static let collapsedQrBackgroundHeight: CGFloat = 240.0
        static let expandedQrSize: CGSize = CGSize(width: 360.0, height: 360.0)
        static let expandedQrBackgroundHeight: CGFloat = 440.0
        static let expandedAdaptiveScaleWhenDecreased: CGFloat = 0.9
    }

    enum LayoutState {
        case collapsed
        case expanded
    }

    var presenter: ReceiveAmountPresenterProtocol!

    var style: WalletStyleProtocol?

    private(set) var layoutState: LayoutState = .expanded {
        didSet {
            if layoutState != oldValue {
                updateLayoutConstraints(for: layoutState)
            }
        }
    }

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var qrImageView: UIImageView!
    @IBOutlet private var assetTitleControl: ActionTitleControl!
    @IBOutlet private var qrSeparatorView: BorderedContainerView!
    @IBOutlet private var amountSeparatorView: BorderedContainerView!
    @IBOutlet private var keyboardControl: ActionTitleControl!
    @IBOutlet private var amountTitleLabel: UILabel!
    @IBOutlet private var amountSymbolLabel: UILabel!
    @IBOutlet private var amountField: UITextField!

    @IBOutlet private var qrBackgroundHeight: NSLayoutConstraint!
    @IBOutlet private var qrHeight: NSLayoutConstraint!
    @IBOutlet private var qrWidth: NSLayoutConstraint!

    @IBOutlet private var scrollBottom: NSLayoutConstraint!

    private var assetSelectionViewModel: AssetSelectionViewModelProtocol?
    private var amountInputViewModel: AmountInputViewModelProtocol?

    private var keyboardHandler: KeyboardHandler?

    override var navigationItem: UINavigationItem {
        let navigationItem = super.navigationItem

        let shareItem = UIBarButtonItem(image: style?.shareIcon,
                                        style: .plain,
                                        target: self,
                                        action: #selector(actionShare))
        navigationItem.rightBarButtonItem = shareItem

        return navigationItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCloseButton()
        adjustLayout()
        applyStyle()
        
        amountTitleLabel.text = L10n.Amount.title

        presenter.setup(qrSize: calculateQrSize(for: .expanded))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        setupKeyboardHandler()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        clearKeyboardHandler()
    }

    private func adjustLayout() {
        updateLayoutConstraints(for: layoutState)
    }

    private func setupCloseButton() {
        let closeBarItem = UIBarButtonItem(image: style?.closeIcon,
                                           style: .plain,
                                           target: self,
                                           action: #selector(actionClose))
        navigationItem.leftBarButtonItem = closeBarItem
    }

    private func applyStyle() {
        if let style = style {
            view.backgroundColor = style.backgroundColor

            amountTitleLabel.textColor = style.captionTextColor
            amountTitleLabel.font = style.bodyRegularFont

            qrSeparatorView.strokeColor = style.thickBorderColor
            amountSeparatorView.strokeColor = style.thickBorderColor

            assetTitleControl.titleLabel.textColor = style.bodyTextColor
            assetTitleControl.titleLabel.font = style.bodyRegularFont
            assetTitleControl.imageView.image = style.downArrowIcon

            amountField.textColor = style.bodyTextColor
            amountField.font = style.header2Font

            amountSymbolLabel.textColor = style.bodyTextColor
            amountSymbolLabel.font = style.header2Font

            if let caretColor = style.caretColor {
                amountField.tintColor = caretColor
            }

            keyboardControl.imageView.image = style.keyboardIcon
        }
    }

    private func updateLayoutConstraints(for state: LayoutState) {
        let qrSize: CGSize = calculateQrSize(for: state)
        let qrBackgroundHeightValue: CGFloat = calculateQrBackgrounHeight(for: state)

        qrWidth.constant = qrSize.width
        qrHeight.constant = qrSize.height
        qrBackgroundHeight.constant = qrBackgroundHeightValue
    }

    private func calculateQrSize(for state: LayoutState) -> CGSize {
        var qrSize: CGSize

        switch state {
        case .collapsed:
            qrSize = Constants.collapsedQrSize
        case .expanded:
            qrSize = Constants.expandedQrSize

            if isAdaptiveWidthDecreased {
                qrSize.width *= Constants.expandedAdaptiveScaleWhenDecreased
                qrSize.height *= Constants.expandedAdaptiveScaleWhenDecreased
            }
        }

        qrSize.width *= designScaleRatio.width
        qrSize.height *= designScaleRatio.width

        return qrSize
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
        keyboardHandler = KeyboardHandler(with: self)
        keyboardHandler?.animateOnFrameChange = animateKeyboardBoundsChange(for:)
    }

    private func clearKeyboardHandler() {
        keyboardHandler = nil
    }

    private func animateKeyboardBoundsChange(for keyboardFrame: CGRect) {
        let localKeyboardFrame = view.convert(keyboardFrame, from: nil)
        scrollBottom.constant = max(view.bounds.maxY - localKeyboardFrame.minY, 0.0)

        if scrollBottom.constant > 0.0 {
            layoutState = .collapsed
        } else {
            layoutState = .expanded
        }

        view.layoutIfNeeded()

        if scrollBottom.constant > 0.0 {
            scrollToAmount(for: localKeyboardFrame)
        } else {
            scrollToQrCode()
        }
    }

    private func scrollToAmount(for localKeyboardFrame: CGRect) {
        let scrollHeight = view.bounds.maxY - scrollView.frame.minY - scrollBottom.constant
        let amountFrame = scrollView.convert(amountField.frame, from: amountSeparatorView)

        if scrollView.contentOffset.y + scrollHeight < amountFrame.maxY {
            let contentOffset = CGPoint(x: 0.0, y: amountFrame.maxY - scrollHeight)
            scrollView.contentOffset = contentOffset
        }
    }

    private func scrollToQrCode() {
        scrollView.contentOffset = .zero
    }

    // MARK: Action

    @objc private func actionShare() {
        presenter.share()
    }

    @IBAction private func actionKeyboardControl() {
        if keyboardControl.isActivated {
            amountField.becomeFirstResponder()
        } else {
            amountField.resignFirstResponder()
        }
    }

    @IBAction private func actionAssetControlDidChange() {
        presenter.presentAssetSelection()
    }

    @objc private func actionClose() {
        presenter.close()
    }
}


extension ReceiveAmountViewController: ReceiveAmountViewProtocol {
    func didReceive(image: UIImage) {
        qrImageView.image = image
    }

    func didReceive(assetSelectionViewModel: AssetSelectionViewModelProtocol) {
        self.assetSelectionViewModel?.observable.remove(observer: self)

        self.assetSelectionViewModel = assetSelectionViewModel
        assetSelectionViewModel.observable.add(observer: self)

        assetTitleControl.titleLabel.text = assetSelectionViewModel.title
        assetTitleControl.isUserInteractionEnabled = assetSelectionViewModel.canSelect
        assetTitleControl.imageView.image = assetSelectionViewModel.canSelect ? style?.downArrowIcon : nil
        assetTitleControl.invalidateLayout()

        assetTitleControl.isUserInteractionEnabled = assetSelectionViewModel.canSelect

        amountSymbolLabel.text = assetSelectionViewModel.symbol
    }

    func didReceive(amountInputViewModel: AmountInputViewModelProtocol) {
        self.amountInputViewModel?.observable.remove(observer: self)

        self.amountInputViewModel = amountInputViewModel
        amountInputViewModel.observable.add(observer: self)

        amountField.text = amountInputViewModel.displayAmount
    }
}


extension ReceiveAmountViewController: AssetSelectionViewModelObserver {
    func assetSelectionDidChangeTitle() {
        assetTitleControl.titleLabel.text = assetSelectionViewModel?.title
    }

    func assetSelectionDidChangeSymbol() {
        amountSymbolLabel.text = assetSelectionViewModel?.symbol
    }

    func assetSelectionDidChangeState() {
        guard let assetSelectionViewModel = assetSelectionViewModel else {
            return
        }

        if assetSelectionViewModel.isSelecting {
            assetTitleControl.activate(animated: true)
        } else {
            assetTitleControl.deactivate(animated: true)
        }
    }


}


extension ReceiveAmountViewController: AmountInputViewModelObserver {
    func amountInputDidChange() {
        amountField.text = amountInputViewModel?.displayAmount
    }
}


extension ReceiveAmountViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        return amountInputViewModel?.didReceiveReplacement(string, for: range) ?? false
    }

}


extension ReceiveAmountViewController: KeyboardHandlerDelegate {
    func keyboardDidShow(notification: Notification) {
        keyboardControl.activate(animated: true)
    }

    func keyboardDidHide(notification: Notification) {
        keyboardControl.deactivate(animated: true)
    }

    func keyboardWillShow(notification: Notification) {
        keyboardControl.activate(animated: true)
    }

    func keyboardWillHide(notification: Notification) {
        keyboardControl.deactivate(animated: true)
    }
}
