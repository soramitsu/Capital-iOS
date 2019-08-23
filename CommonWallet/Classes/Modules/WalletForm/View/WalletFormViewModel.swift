/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit

enum WalletFormLayoutType: CaseIterable {
    case accessory
    case details
}

protocol WalletFormViewModelProtocol {
    var layoutType: WalletFormLayoutType { get }
    var title: String { get }
    var details: String? { get }
    var detailsColor: UIColor? { get }
    var icon: UIImage? { get }
}

final class WalletFormViewModel: WalletFormViewModelProtocol {
    var layoutType: WalletFormLayoutType
    var title: String
    var details: String?
    var detailsColor: UIColor?
    var icon: UIImage?

    init(layoutType: WalletFormLayoutType,
         title: String, details: String?,
         detailsColor: UIColor? = nil,
         icon: UIImage? = nil) {
        self.layoutType = layoutType
        self.title = title
        self.details = details
        self.detailsColor = detailsColor
        self.icon = icon
    }
}
