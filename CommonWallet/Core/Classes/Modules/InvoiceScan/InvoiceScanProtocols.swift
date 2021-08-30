/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import AVFoundation

protocol InvoiceScanViewProtocol: ControllerBackedProtocol {
    func didReceive(session: AVCaptureSession)
    func present(message: String, animated: Bool)
}


protocol InvoiceScanPresenterProtocol: AnyObject {
    func prepareAppearance()
    func handleAppearance()
    func prepareDismiss()
    func handleDismiss()
    func activateImport()
}


protocol InvoiceScanCoordinatorProtocol: ApplicationSettingsPresentable, ImageGalleryPresentable {
    func process(payload: TransferPayload)
}


protocol InvoiceScanAssemblyProtocol: AnyObject {
    static func assembleView(with resolver: ResolverProtocol) -> InvoiceScanViewProtocol?
}
