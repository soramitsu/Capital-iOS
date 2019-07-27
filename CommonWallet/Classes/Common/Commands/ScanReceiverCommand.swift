import Foundation

final class ScanReceiverCommand {
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension ScanReceiverCommand: WalletPresentationCommandProtocol {
    func execute() throws {
        guard
            let scanView = InvoiceScanAssembly.assembleView(with: resolver),
            let navigation = resolver.navigation else {
            return
        }

        present(view: scanView, in: navigation)
    }
}
