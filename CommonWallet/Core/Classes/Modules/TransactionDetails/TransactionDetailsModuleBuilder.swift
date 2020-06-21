/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class TransactionDetailsModuleBuilder {
    private var sendBackTransactionTypes: [String] = []
    private var sendAgainTransactionTypes: [String] = []
    private lazy var fieldActionFactory: WalletFieldActionFactoryProtocol = WalletFieldActionFactory()
    private var customViewBinder: WalletFormViewModelBinderProtocol?
    private var customItemViewFactory: WalletFormItemViewFactoryProtocol?
    private var definitionFactory: WalletFormDefinitionFactoryProtocol?
    private var viewModelFactory: WalletTransactionDetailsFactoryOverriding?

    func build() -> TransactionDetailsConfigurationProtocol {
        return TransactionDetailsConfiguration(sendBackTransactionTypes: sendBackTransactionTypes,
                                               sendAgainTransactionTypes: sendAgainTransactionTypes,
                                               fieldActionFactory: fieldActionFactory,
                                               customViewBinder: customViewBinder,
                                               customItemViewFactory: customItemViewFactory,
                                               definitionFactory: definitionFactory,
                                               viewModelFactory: viewModelFactory)
    }
}

extension TransactionDetailsModuleBuilder: TransactionDetailsModuleBuilderProtocol {
    func with(sendBackTransactionTypes: [String]) -> Self {
        self.sendBackTransactionTypes = sendBackTransactionTypes
        return self
    }

    func with(sendAgainTransactionTypes: [String]) -> Self {
        self.sendAgainTransactionTypes = sendAgainTransactionTypes
        return self
    }

    func with(fieldActionFactory: WalletFieldActionFactoryProtocol) -> Self {
        self.fieldActionFactory = fieldActionFactory
        return self
    }

    func with(viewBinder: WalletFormViewModelBinderProtocol) -> Self {
        self.customViewBinder = viewBinder
        return self
    }

    func with(itemViewFactory: WalletFormItemViewFactoryProtocol) -> Self {
        self.customItemViewFactory = itemViewFactory
        return self
    }

    func with(definitionFactory: WalletFormDefinitionFactoryProtocol) -> Self {
        self.definitionFactory = definitionFactory
        return self
    }

    func with(viewModelFactory: WalletTransactionDetailsFactoryOverriding) -> Self {
        self.viewModelFactory = viewModelFactory
        return self
    }
}
