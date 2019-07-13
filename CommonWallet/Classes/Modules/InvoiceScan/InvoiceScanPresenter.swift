/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import AVFoundation
import IrohaCommunication

final class InvoiceScanPresenter {
    enum ScanState {
        case initializing(accessRequested: Bool)
        case inactive
        case active
        case processing(receiverInfo: ReceiveInfo, operation: Operation)
        case failed(code: String)
    }

    weak var view: InvoiceScanViewProtocol?
    var coordinator: InvoiceScanCoordinatorProtocol

    var logger: WalletLoggerProtocol?

    private(set) var qrScanService: WalletQRCaptureServiceProtocol
    private(set) var qrMatcher = InvoiceScanMatcher()
    private(set) var networkService: WalletServiceProtocol
    private(set) var currentAccountId: IRAccountId

    private(set) var scanState: ScanState = .initializing(accessRequested: false)

    init(view: InvoiceScanViewProtocol,
         coordinator: InvoiceScanCoordinatorProtocol,
         qrScanServiceFactory: WalletQRCaptureServiceFactoryProtocol,
         networkService: WalletServiceProtocol,
         currentAccountId: IRAccountId) {
        self.view = view
        self.coordinator = coordinator
        self.networkService = networkService
        self.currentAccountId = currentAccountId

        self.qrScanService = qrScanServiceFactory.createService(with: qrMatcher,
                                                                delegate: nil,
                                                                delegateQueue: nil)
        self.qrScanService.delegate = self
    }

    private func handleQRService(error: Error) {
        guard let qrServiceError = error as? WalletQRCaptureServiceError else {
            logger?.error("Unexpected qr service error \(error)")
            return
        }

        guard case .initializing(let alreadyAskedAccess) = scanState, !alreadyAskedAccess else {
            logger?.warning("Requested to ask access but already done earlier")
            return
        }

        scanState = .initializing(accessRequested: true)

        switch qrServiceError {
        case .deviceAccessRestricted:
            view?.present(message: "Unfortunatelly, access to the camera is restricted.", animated: true)
        case .deviceAccessDeniedPreviously:
            let message = "Unfortunatelly, you denied access to camera previously. Would you like to allow access now?"
            let title = "Camera Access"
            coordinator.askOpenApplicationSettins(with: message, title: title, from: view)
        default:
            break
        }
    }

    private func handleReceived(captureSession: AVCaptureSession) {
        if case .initializing = scanState {
            scanState = .active

            view?.didReceive(session: captureSession)
        }
    }

    private func handleMatched(receiverInfo: ReceiveInfo) {
        if receiverInfo.accountId.identifier() == currentAccountId.identifier() {
            let message = "Sender and Receiver must be different"
            view?.present(message: message, animated: true)
            return
        }

        switch scanState {
        case .processing(let oldReceiverInfo, let oldOperation) where oldReceiverInfo != receiverInfo:
            if !oldOperation.isFinished {
                oldOperation.cancel()
            }

            performProcessing(of: receiverInfo)
        case .active:
            performProcessing(of: receiverInfo)
        default:
            break
        }
    }

    private func handleFailedMatching(for code: String) {
        let message = "Can't extract receiver's data"
        view?.present(message: message, animated: true)
    }

    private func performProcessing(of receiverInfo: ReceiveInfo) {
        let operation = networkService.search(for: receiverInfo.accountId.identifier(),
                                              runCompletionIn: .main) { [weak self] (optionalResult) in
                                                if let result = optionalResult {
                                                    switch result {
                                                    case .success(let searchResult):
                                                        self?.handleProccessing(searchResult: searchResult)
                                                    case .error(let error):
                                                        self?.handleProcessing(error: error)
                                                    }
                                                }
        }

        scanState = .processing(receiverInfo: receiverInfo, operation: operation)
    }

    private func handleProccessing(searchResult: [SearchData]) {
        guard case .processing(let receiverInfo, _) = scanState else {
            logger?.warning("Unexpected state \(scanState) after successfull processing")
            return
        }

        scanState = .active

        guard
            let foundAccount = searchResult.first,
            foundAccount.accountId == receiverInfo.accountId.identifier() else {
                let message = "Receiver couldn't be found"
                view?.present(message: message, animated: true)
                return
        }

        let receiverName = "\(foundAccount.firstName) \(foundAccount.lastName)"
        let payload = AmountPayload(receiveInfo: receiverInfo,
                                    receiverName: receiverName)

        coordinator.process(payload: payload)
    }

    private func handleProcessing(error: Error) {
        guard case .processing = scanState else {
            logger?.warning("Unexpected state \(scanState) after failed processing")
            return
        }

        scanState = .active

        let message = "Please, check internet connection"
        view?.present(message: message, animated: true)
    }
}

extension InvoiceScanPresenter: InvoiceScanPresenterProtocol {
    func prepareAppearance() {
        qrScanService.start()
    }

    func handleAppearance() {
        if case .inactive = scanState {
            scanState = .active
        }
    }

    func prepareDismiss() {
        if case .initializing = scanState {
            return
        }

        if case .processing(_, let operation) = scanState, !operation.isFinished {
            operation.cancel()
        }

        scanState = .inactive
    }

    func handleDismiss() {
        qrScanService.stop()
    }
}

extension InvoiceScanPresenter: WalletQRCaptureServiceDelegate {
    func qrCapture(service: WalletQRCaptureServiceProtocol, didSetup captureSession: AVCaptureSession) {
        DispatchQueue.main.async {
            self.handleReceived(captureSession: captureSession)
        }
    }

    func qrCapture(service: WalletQRCaptureServiceProtocol, didMatch code: String) {
        guard let receiverInfo = qrMatcher.receiverInfo else {
            logger?.warning("Can't find receiver's info for matched code")
            return
        }

        DispatchQueue.main.async {
            self.handleMatched(receiverInfo: receiverInfo)
        }
    }

    func qrCapture(service: WalletQRCaptureServiceProtocol, didFailMatching code: String) {
        DispatchQueue.main.async {
            self.handleFailedMatching(for: code)
        }
    }

    func qrCapture(service: WalletQRCaptureServiceProtocol, didReceive error: Error) {
        DispatchQueue.main.async {
            self.handleQRService(error: error)
        }
    }
}
