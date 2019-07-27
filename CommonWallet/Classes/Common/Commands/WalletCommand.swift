import Foundation

public protocol WalletCommandProtocol: class {
    func execute() throws
}
