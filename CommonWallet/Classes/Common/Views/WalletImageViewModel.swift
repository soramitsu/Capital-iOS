import Foundation

public protocol WalletImageViewModelProtocol: class {
    var image: UIImage? { get }
    func loadImage(with completionBlock: @escaping (UIImage?, Error?) -> Void)
    func cancel()
}
