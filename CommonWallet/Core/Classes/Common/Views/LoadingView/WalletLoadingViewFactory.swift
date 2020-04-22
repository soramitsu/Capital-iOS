/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI


protocol WalletLoadingOverlayFactoryProtocol: class {
    func createLoadingView() -> LoadingView
}

final class WalletLoadingOverlayFactory: WalletLoadingOverlayFactoryProtocol {
    let style: WalletLoadingOverlayStyleProtocol

    init(style: WalletLoadingOverlayStyleProtocol) {
        self.style = style
    }

    func createLoadingView() -> LoadingView {

        let loadingView = LoadingView(frame: UIScreen.main.bounds,
                                      indicatorImage: style.indicator ?? UIImage())
        loadingView.backgroundColor = style.background
        loadingView.contentBackgroundColor = style.contentColor
        loadingView.contentSize = style.contentSize
        loadingView.animationDuration = style.animationDuration

        return loadingView
    }
}
