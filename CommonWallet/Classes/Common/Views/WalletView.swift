import Foundation

public protocol WalletViewProtocol: class {
    var viewModel: WalletViewModelProtocol? { get }
    func bind(viewModel: WalletViewModelProtocol)
}
