import Foundation

public protocol WalletCommandDecoratorProtocol: WalletCommandProtocol {
    var undelyingCommand: WalletCommandProtocol? { get set }
}

public protocol WalletCommandDecoratorFactoryProtocol: class {
    func createSendCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol?
    func createReceiveCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol?
}

extension WalletCommandDecoratorFactoryProtocol {
    func createSendCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol? {
        return nil
    }

    func createReceiveCommandDecorator(with commandFactory: WalletCommandFactoryProtocol)
        -> WalletCommandDecoratorProtocol? {
        return nil
    }
}
