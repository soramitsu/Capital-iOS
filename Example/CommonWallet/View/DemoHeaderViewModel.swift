/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import CommonWallet

protocol DemoHeaderViewModelProtocol: WalletViewModelProtocol {
    var title: String { get }
    var style: WalletTextStyleProtocol { get }
    var delegate: DemoHeaderViewModelDelegate? { get }
}

protocol DemoHeaderViewModelDelegate: class {
    func didSelectClose(for viewModel: DemoHeaderViewModelProtocol)
}

final class DemoHeaderViewModel: DemoHeaderViewModelProtocol {
    let cellReuseIdentifier: String = "co.jp.demo.header.identifier"
    let itemHeight: CGFloat = 60.0

    let title: String
    let style: WalletTextStyleProtocol

    var command: WalletCommandProtocol? { return nil }

    weak var delegate: DemoHeaderViewModelDelegate?

    init(title: String, style: WalletTextStyleProtocol) {
        self.title = title
        self.style = style
    }
}
