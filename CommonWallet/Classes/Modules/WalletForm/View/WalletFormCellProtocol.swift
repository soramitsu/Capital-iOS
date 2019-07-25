import Foundation

protocol WalletFormCellProtocol: class {
    var viewModel: WalletFormViewModelProtocol? { get }

    var style: WalletFormCellStyleProtocol? { get set }

    func bind(viewModel: WalletFormViewModelProtocol)

    static func calculateHeight(for viewModel: WalletFormViewModelProtocol,
                                style: WalletFormCellStyleProtocol,
                                preferredWidth: CGFloat) -> CGFloat
}
