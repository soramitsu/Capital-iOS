/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol WithdrawModuleBuilderProtocol {
    @discardableResult
    func with(headerFactory: OperationDefinitionHeaderModelFactoryProtocol) -> Self

    @discardableResult
    func with(separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol) -> Self

    @discardableResult
    func with(headerContentInsets: UIEdgeInsets) -> Self

    @discardableResult
    func with(containingViewInsets: UIEdgeInsets) -> Self

    @discardableResult
    func with(errorContentInsets: UIEdgeInsets) -> Self

    @discardableResult
    func with(containingHeaderStyle: WalletContainingHeaderStyle) -> Self

    @discardableResult
    func with(containingErrorStyle: WalletContainingErrorStyle) -> Self

    @discardableResult
    func with(selectedAssetDisplayStyle: SelectedAssetViewDisplayStyle) -> Self

    @discardableResult
    func with(feeDisplayStyle: FeeViewDisplayStyle) -> Self

    @discardableResult
    func with(selectedAssetStyle: WalletContainingAssetStyle) -> Self

    @discardableResult
    func with(receiverStyle: WalletContainingReceiverStyle) -> Self

    @discardableResult
    func with(amountStyle: WalletContainingAmountStyle) -> Self

    @discardableResult
    func with(feeStyle: WalletContainingFeeStyle) -> Self

    @discardableResult
    func with(descriptionStyle: WalletContainingDescriptionStyle) -> Self

    @discardableResult
    func with(settings: WalletTransactionSettingsProtocol) -> Self
}
