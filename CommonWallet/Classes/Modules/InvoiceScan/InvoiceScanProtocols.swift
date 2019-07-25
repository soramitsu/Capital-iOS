import AVFoundation

protocol InvoiceScanViewProtocol: ControllerBackedProtocol {
    func didReceive(session: AVCaptureSession)
    func present(message: String, animated: Bool)
}


protocol InvoiceScanPresenterProtocol: class {
    func prepareAppearance()
    func handleAppearance()
    func prepareDismiss()
    func handleDismiss()
}


protocol InvoiceScanCoordinatorProtocol: ApplicationSettingsPresentable {
    func process(payload: AmountPayload)
}


protocol InvoiceScanAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol) -> InvoiceScanViewProtocol?
}
