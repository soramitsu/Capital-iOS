/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

extension WalletLoadingOverlayStyle {
    static func createDefault() -> WalletLoadingOverlayStyle {
        let indicator = UIImage(named: "loadingIcon",
                                in: Bundle(for: WalletStyle.self),
                                compatibleWith: nil)
        return WalletLoadingOverlayStyle(background: UIColor.black.withAlphaComponent(0.22),
                                         contentColor: .clear,
                                         contentSize: CGSize(width: 120.0, height: 120.0),
                                         indicator: indicator,
                                         animationDuration: 1.0)
    }
}
