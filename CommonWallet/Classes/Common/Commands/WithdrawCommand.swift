import Foundation

final class WithdrawCommand {
    let resolver: ResolverProtocol

    init(resolver: ResolverProtocol) {
        self.resolver = resolver
    }
}

extension WithdrawCommand: WalletCommandProtocol {
    func execute() throws {

    }
}
