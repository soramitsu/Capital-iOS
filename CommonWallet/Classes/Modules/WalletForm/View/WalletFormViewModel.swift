/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit

public enum WalletFormLayoutType: CaseIterable {
    case accessory
    case details
}

public protocol WalletFormViewModelProtocol {
    var layoutType: WalletFormLayoutType { get }
    var title: String { get }
    var details: String? { get }
    var detailsColor: UIColor? { get }
    var icon: UIImage? { get }
    var command: WalletCommandProtocol? { get }
}

public struct WalletFormViewModel: WalletFormViewModelProtocol {
    public let layoutType: WalletFormLayoutType
    public let title: String
    public let details: String?
    public let detailsColor: UIColor?
    public let icon: UIImage?
    public let command: WalletCommandProtocol?

    public init(layoutType: WalletFormLayoutType,
                title: String,
                details: String?,
                detailsColor: UIColor? = nil,
                icon: UIImage? = nil,
                command: WalletCommandProtocol? = nil) {
        self.layoutType = layoutType
        self.title = title
        self.details = details
        self.detailsColor = detailsColor
        self.icon = icon
        self.command = command
    }
}
