import Foundation

public typealias WalletViewModelFactory = () throws -> WalletViewModelProtocol

public protocol WalletViewModelProtocol: class {
    var cellReuseIdentifier: String { get }
    var itemHeight: CGFloat { get }

    func didSelect()
}
