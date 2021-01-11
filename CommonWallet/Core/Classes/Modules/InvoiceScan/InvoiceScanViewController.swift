/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import AVFoundation
import SoraUI
import SoraFoundation


final class InvoiceScanViewController: UIViewController, AdaptiveDesignable {
    private struct Constants {
        static let decreasingBottomFactor: CGFloat = 0.8
    }

    var presenter: InvoiceScanPresenterProtocol!

    var style: InvoiceScanViewStyleProtocol?

    @IBOutlet private var qrFrameView: CameraFrameView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var uploadButton: RoundedButton!

    @IBOutlet private var titleTop: NSLayoutConstraint!
    @IBOutlet private var titleLeading: NSLayoutConstraint!
    @IBOutlet private var titleTralling: NSLayoutConstraint!
    @IBOutlet private var messageBottom: NSLayoutConstraint!
    @IBOutlet private var messageLeading: NSLayoutConstraint!
    @IBOutlet private var messageTralling: NSLayoutConstraint!
    @IBOutlet private var uploadBottom: NSLayoutConstraint!

    lazy var messageAppearanceAnimator: BlockViewAnimatorProtocol = BlockViewAnimator()
    lazy var messageDissmisAnimator: BlockViewAnimatorProtocol = BlockViewAnimator()

    var messageVisibilityDuration: TimeInterval = 5.0

    var showsUpload: Bool = false

    deinit {
        invalidateMessageScheduling()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        presenter.prepareDismiss()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.prepareAppearance()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        presenter.handleDismiss()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.handleAppearance()
    }

    private func configure() {
        uploadButton.isHidden = !showsUpload

        configureStyle()
        adjustLayout()

        setupLocalization()
    }

    private func setupLocalization() {
        title = L10n.InvoiceScan.title
        titleLabel.text = L10n.InvoiceScan.scan
        uploadButton.imageWithTitleView?.title = L10n.InvoiceScan.upload
    }

    private func configureStyle() {
        if let style = style {
            view.backgroundColor = style.background

            titleLabel.textColor = style.title.color
            titleLabel.font = style.title.font

            messageLabel.textColor = style.message.color
            messageLabel.font = style.message.font

            qrFrameView.fillColor = style.maskBackground

            style.upload.apply(to: uploadButton)
        }
    }

    private func adjustLayout() {
        titleTop.constant *= designScaleRatio.width
        titleLeading.constant *= designScaleRatio.width
        titleTralling.constant *= designScaleRatio.width

        messageLeading.constant *= designScaleRatio.width
        messageTralling.constant *= designScaleRatio.width

        if isAdaptiveHeightDecreased {
            let newFontSize = messageLabel.font.pointSize * designScaleRatio.width
            messageLabel.font = UIFont(name: messageLabel.font.fontName, size: newFontSize)

            messageBottom.constant *= designScaleRatio.height * Constants.decreasingBottomFactor
            uploadBottom.constant *= designScaleRatio.height * Constants.decreasingBottomFactor
        }

        var windowSize = qrFrameView.windowSize
        windowSize.width *= designScaleRatio.width
        windowSize.height *= designScaleRatio.width
        qrFrameView.windowSize = windowSize
    }

    private func configureVideoLayer(with captureSession: AVCaptureSession) {
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer.frame = view.layer.bounds

        qrFrameView.frameLayer = videoPreviewLayer
    }

    // MARK: Message Management

    private func scheduleMessageHide() {
        invalidateMessageScheduling()

        perform(#selector(hideMessage), with: true, afterDelay: messageVisibilityDuration)
    }

    private func invalidateMessageScheduling() {
        NSObject.cancelPreviousPerformRequests(withTarget: self,
                                               selector: #selector(hideMessage),
                                               object: true)
    }

    @objc private func hideMessage() {
        let block: () -> Void = { [weak self] in
            self?.messageLabel.alpha = 0.0
        }

        messageDissmisAnimator.animate(block: block, completionBlock: nil)
    }

    // MARK: Actions

    @IBAction private func actionUpload() {
        presenter.activateImport()
    }
}

extension InvoiceScanViewController: InvoiceScanViewProtocol {
    func didReceive(session: AVCaptureSession) {
        configureVideoLayer(with: session)
    }

    func present(message: String, animated: Bool) {
        messageLabel.text = message

        let block: () -> Void = { [weak self] in
            self?.messageLabel.alpha = 1.0
        }

        if animated {
            messageAppearanceAnimator.animate(block: block, completionBlock: nil)
        } else {
            block()
        }

        scheduleMessageHide()
    }
}

extension InvoiceScanViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
            uploadButton?.invalidateLayout()
            view.setNeedsLayout()
        }
    }
}
