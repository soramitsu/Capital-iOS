/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

public struct ReceiveFieldsInclusion: OptionSet {
    public typealias RawValue = UInt8

    public static let selectedAsset = ReceiveFieldsInclusion(rawValue: 1 << 0)
    public static let amount = ReceiveFieldsInclusion(rawValue: 1 << 1)
    public static let description = ReceiveFieldsInclusion(rawValue: 1 << 2)

    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }

    public let rawValue: UInt8
}

protocol ReceiveAmountConfigurationProtocol {
    var accountShareFactory: AccountShareFactoryProtocol { get }
    var title: LocalizableResource<String> { get }
    var fieldsInclusion: ReceiveFieldsInclusion { get }
    var settings: WalletTransactionSettingsProtocol { get }
    var receiveStyle: ReceiveStyleProtocol { get }
    var viewFactory: ReceiveViewFactoryProtocol? { get }
}


struct ReceiveAmountConfiguration: ReceiveAmountConfigurationProtocol {
    var accountShareFactory: AccountShareFactoryProtocol
    var title: LocalizableResource<String>
    var fieldsInclusion: ReceiveFieldsInclusion
    var settings: WalletTransactionSettingsProtocol
    var receiveStyle: ReceiveStyleProtocol
    var viewFactory: ReceiveViewFactoryProtocol?
}
