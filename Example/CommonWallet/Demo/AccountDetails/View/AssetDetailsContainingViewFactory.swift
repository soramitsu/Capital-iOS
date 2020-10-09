/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import CommonWallet

struct AssetDetailsContainingViewFactory: AccountDetailsContainingViewFactoryProtocol {
    func createView() -> BaseAccountDetailsContainingView {
        let view = UINib(nibName: "CustomDetailsView", bundle: Bundle.main)
            .instantiate(withOwner: nil, options: nil).first as? CustomDetailsView
        return view!
    }
}
