/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

final class TransferConfirmationModuleBuilder {
    var customViewBinder: WalletFormViewModelBinderProtocol?
    var customItemViewFactory: WalletFormItemViewFactoryProtocol?
    var definitionFactory: WalletFormDefinitionFactoryProtocol?
    var viewModelFactoryOverriding: TransferConfirmationViewModelFactoryOverriding?
    var completion: TransferCompletion = .showResult
    var accessoryViewType: WalletAccessoryViewType = .titleIconActionBar

    func build() -> TransferConfirmationConfigurationProtocol {
        TransferConfirmationConfiguration(customViewBinder: customViewBinder,
                                          customItemViewFactory: customItemViewFactory,
                                          definitionFactory: definitionFactory,
                                          viewModelFactoryOverriding: viewModelFactoryOverriding,
                                          completion: completion,
                                          accessoryViewType: accessoryViewType)
    }
}

extension TransferConfirmationModuleBuilder: TransferConfirmationModuleBuilderProtocol {
    func with(viewBinder: WalletFormViewModelBinderProtocol) -> Self {
        customViewBinder = viewBinder
        return self
    }
    
    func with(itemViewFactory: WalletFormItemViewFactoryProtocol) -> Self {
        customItemViewFactory = itemViewFactory
        return self
    }

    func with(definitionFactory: WalletFormDefinitionFactoryProtocol) -> Self {
        self.definitionFactory = definitionFactory
        return self
    }

    func with(viewModelFactoryOverriding: TransferConfirmationViewModelFactoryOverriding) -> Self {
        self.viewModelFactoryOverriding = viewModelFactoryOverriding
        return self
    }

    func with(completion: TransferCompletion) -> Self {
        self.completion = completion
        return self
    }

    func with(accessoryViewType: WalletAccessoryViewType) -> Self {
        self.accessoryViewType = accessoryViewType
        return self
    }
}
