/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

class WalletFormTokenView: SelectedAssetView, WalletFormTokenViewProtocol, WalletFormBordering {
    var style: WalletFormTokenViewStyle? {
        didSet {
            guard let style = style else {
                return
            }

            titleColor = style.title.color
            titleFont = style.title.font

            subtitleColor = style.subtitle.color
            subtitleFont = style.subtitle.font

            contentInsets = style.contentInset
            titleHorizontalSpacing = style.iconTitleSpacing

            borderedView.strokeColor = style.separatorStyle.color
            borderedView.strokeWidth = style.separatorStyle.lineWidth

            displayStyle = style.displayStyle
        }
    }

    func bind(viewModel: WalletFormTokenViewModel) {
        let state = SelectedAssetState(isSelecting: false, canSelect: false)
        let selectedAssetViewModel = AssetSelectionViewModel(title: viewModel.title,
                                                             subtitle: viewModel.subtitle,
                                                             details: "",
                                                             icon: viewModel.icon,
                                                             state: state)
        bind(viewModel: selectedAssetViewModel)
    }
}
