/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import UIKit
import CommonWallet

final class CustomDetailsView: BaseAccountDetailsContainingView {
    @IBOutlet private var amountLabel: UILabel!

    var contentInsets: UIEdgeInsets = .zero

    func setContentInsets(_ contentInsets: UIEdgeInsets, animated: Bool) {
        self.contentInsets = contentInsets
    }

    var preferredContentHeight: CGFloat { 80.0 }

    func bind(viewModels: [WalletViewModelProtocol]) {
        guard
            let assetViewModel = viewModels
                .first(where: { ($0 as? AssetViewModelProtocol) != nil }) as? AssetViewModelProtocol else {
            return
        }

        if let symbol = assetViewModel.symbol {
            amountLabel.text = "\(symbol) \(assetViewModel.amount)"
        } else {
            amountLabel.text = assetViewModel.amount
        }

    }
}
