/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

protocol TransferConfigurationProtocol {
    var resultValidator: TransferValidating { get }
    var receiverPosition: TransferReceiverPosition { get }
    var headerFactory: OperationDefinitionHeaderModelFactoryProtocol { get }
    var separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol { get }
    var settings: WalletTransactionSettingsProtocol { get }
    var style: OperationDefinitionViewStyle { get }
    var generatingIconStyle: WalletNameIconStyleProtocol { get }
    var accessoryViewType: WalletAccessoryViewType { get }
    var localizableTitle: LocalizableResource<String>? { get }
    var assetSelectionFactory: AssetSelectionFactoryProtocol? { get }
}

struct TransferConfiguration: TransferConfigurationProtocol {
    let resultValidator: TransferValidating
    let receiverPosition: TransferReceiverPosition
    let headerFactory: OperationDefinitionHeaderModelFactoryProtocol
    let separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol
    let settings: WalletTransactionSettingsProtocol
    let style: OperationDefinitionViewStyle
    let generatingIconStyle: WalletNameIconStyleProtocol
    let accessoryViewType: WalletAccessoryViewType
    let localizableTitle: LocalizableResource<String>?
    var assetSelectionFactory: AssetSelectionFactoryProtocol?
}
