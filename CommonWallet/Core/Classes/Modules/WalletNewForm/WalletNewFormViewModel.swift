/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

public protocol WalletFormViewBindingProtocol {
    func accept(definition: WalletFormDefining) -> WalletFormItemView?
}

extension MultilineTitleIconViewModel: WalletFormViewBindingProtocol {
    public func accept(definition: WalletFormDefining) -> WalletFormItemView? {
        definition.defineViewForMultilineTitleIconModel(self)
    }
}

public struct WalletNewFormDetailsViewModel: WalletFormViewBindingProtocol {
    public let title: String
    public let titleIcon: UIImage?
    public let details: String?
    public let detailsIcon: UIImage?

    public init(title: String,
                titleIcon: UIImage? = nil,
                details: String? = nil,
                detailsIcon: UIImage? = nil) {
        self.title = title
        self.titleIcon = titleIcon
        self.details = details
        self.detailsIcon = detailsIcon
    }

    public func accept(definition: WalletFormDefining) -> WalletFormItemView? {
        definition.defineViewForDetailsModel(self)
    }
}

public struct WalletFormSingleHeaderModel: WalletFormViewBindingProtocol {
    public let title: String
    public let icon: UIImage?

    public init(title: String, icon: UIImage? = nil) {
        self.title = title
        self.icon = icon
    }

    public func accept(definition: WalletFormDefining) -> WalletFormItemView? {
        definition.defineViewForSingleHeaderModel(self)
    }
}

public struct WalletFormDetailsHeaderModel: WalletFormViewBindingProtocol {
    public let title: String
    public let icon: UIImage?

    public init(title: String, icon: UIImage? = nil) {
        self.title = title
        self.icon = icon
    }

    public func accept(definition: WalletFormDefining) -> WalletFormItemView? {
        definition.defineViewForDetailsHeaderModel(self)
    }
}

public struct WalletFormSpentAmountModel: WalletFormViewBindingProtocol {
    public let title: String
    public let amount: String

    public init(title: String, amount: String) {
        self.title = title
        self.amount = amount
    }

    public func accept(definition: WalletFormDefining) -> WalletFormItemView? {
        definition.defineViewForSpentAmountModel(self)
    }
}

public struct WalletFormTokenViewModel: WalletFormViewBindingProtocol {
    public let title: String
    public let subtitle: String
    public let icon: UIImage?

    public init(title: String, subtitle: String, icon: UIImage? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.icon = icon
    }

    public func accept(definition: WalletFormDefining) -> WalletFormItemView? {
        definition.defineViewForTokenViewModel(self)
    }
}

public struct WalletFormSeparatedViewModel<T: WalletFormViewBindingProtocol>: WalletFormViewBindingProtocol {
    public let content: T
    public let borderType: BorderType

    public init(content: T, borderType: BorderType) {
        self.content = content
        self.borderType = borderType
    }

    public func accept(definition: WalletFormDefining) -> WalletFormItemView? {
        definition.defineViewForSeparatedViewModel(self)
    }
}
