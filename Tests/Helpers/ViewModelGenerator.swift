import Foundation
@testable import CommonWallet

final class DummyWalletViewModel: WalletViewModelProtocol {
    var cellReuseIdentifier: String

    var itemHeight: CGFloat

    func didSelect() {}

    init(cellReuseIdentifier: String, itemHeight: CGFloat) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
    }
}

func createDummyWalletViewModel() throws -> WalletViewModelProtocol {
    return DummyWalletViewModel(cellReuseIdentifier: UUID().uuidString,
                                itemHeight: CGFloat.random(in: 0...100))
}
