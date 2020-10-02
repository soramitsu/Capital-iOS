/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


final class TransactionDetailsModuleBuilder {
    private var accessoryViewFactory: AccessoryViewFactoryProtocol.Type?
    private var sendBackTransactionTypes: [String] = []
    private var sendAgainTransactionTypes: [String] = []
    private var customViewBinder: WalletFormViewModelBinderOverriding?
    private var customItemViewFactory: WalletFormItemViewFactoryOverriding?
    private var definitionFactory: WalletFormDefinitionFactoryProtocol?
    private var viewModelFactory: WalletTransactionDetailsFactoryOverriding?

    func build() -> TransactionDetailsConfigurationProtocol {
        return TransactionDetailsConfiguration(sendBackTransactionTypes: sendBackTransactionTypes,
                                               sendAgainTransactionTypes: sendAgainTransactionTypes,
                                               customViewBinder: customViewBinder,
                                               customItemViewFactory: customItemViewFactory,
                                               definitionFactory: definitionFactory,
                                               viewModelFactory: viewModelFactory,
                                               accessoryViewFactory: accessoryViewFactory)
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

    func with(viewBinder: WalletFormViewModelBinderOverriding) -> Self {
        self.customViewBinder = viewBinder
        return self
    }

    func with(itemViewFactory: WalletFormItemViewFactoryOverriding) -> Self {
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

    func with(accessoryViewFactory: AccessoryViewFactoryProtocol.Type) -> Self {
        self.accessoryViewFactory = accessoryViewFactory
        return self
    }
}
