import Foundation

final class ScanReceiverCommand {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension ScanReceiverCommand: WalletCommandProtocol {
    func execute() throws {
        guard let scanView = InvoiceScanAssembly.assembleView(with: resolver) else {
            return
        }

        resolver.navigation?.push(scanView.controller)
    }
}
