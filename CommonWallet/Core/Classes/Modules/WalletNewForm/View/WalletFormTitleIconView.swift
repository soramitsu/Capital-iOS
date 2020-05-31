/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

final class WalletFormTitleIconView: MultilineTitleIconView, WalletFormBordering,
    WalletFormTitleIconViewProtocol {

    var style: WalletFormTitleIconViewStyle? {
        didSet {
            guard let style = style else {
                return
            }

            titleLabel.textColor = style.title.color
            titleLabel.font = style.title.font
            horizontalSpacing = style.horizontalSpacing
            contentInsets = style.contentInsets
            borderedView.strokeColor = style.separatorStyle.color
            borderedView.strokeWidth = style.separatorStyle.lineWidth
        }
    }

    private(set) var borderedView = BorderedContainerView()

    var borderType: BorderType {
        get {
            borderedView.borderType
        }

        set {
            borderedView.borderType = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        borderedView.translatesAutoresizingMaskIntoConstraints = false
        borderedView.strokeWidth = 1.0
        borderedView.borderType = [.bottom]
        addSubview(borderedView)

        borderedView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        borderedView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        borderedView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        borderedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
