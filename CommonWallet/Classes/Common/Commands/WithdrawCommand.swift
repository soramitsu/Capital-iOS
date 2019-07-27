import Foundation

final class WithdrawCommand {
    let resolver: ResolverProtocol

    var presentationStyle: WalletPresentationStyle = .push(hidesBottomBar: true)

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension WithdrawCommand: WalletPresentationCommandProtocol {
    func execute() throws {

    }
}
