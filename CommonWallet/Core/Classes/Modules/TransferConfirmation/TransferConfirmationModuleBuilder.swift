/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

final class TransferConfirmationModuleBuilder {
    private var customViewBinder: WalletFormViewModelBinderProtocol?
    private var customItemViewFactory: WalletFormItemViewFactoryOverriding?
    private var definitionFactory: WalletFormDefinitionFactoryProtocol?
    private var viewModelFactoryOverriding: TransferConfirmationViewModelFactoryOverriding?
    private var completion: TransferCompletion = .showResult
    private var accessoryViewType: WalletAccessoryViewType = .titleIconActionBar
    private var localizableTitle: LocalizableResource<String>?

    func build() -> TransferConfirmationConfigurationProtocol {
        TransferConfirmationConfiguration(customViewBinder: customViewBinder,
                                          customItemViewFactory: customItemViewFactory,
                                          definitionFactory: definitionFactory,
                                          viewModelFactoryOverriding: viewModelFactoryOverriding,
                                          completion: completion,
                                          accessoryViewType: accessoryViewType,
                                          localizableTitle: localizableTitle)
    }
}

extension TransferConfirmationModuleBuilder: TransferConfirmationModuleBuilderProtocol {
    func with(viewBinder: WalletFormViewModelBinderProtocol) -> Self {
        customViewBinder = viewBinder
        return self
    }
    
    func with(itemViewFactory: WalletFormItemViewFactoryOverriding) -> Self {
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

    func with(localizableTitle: LocalizableResource<String>) -> Self {
        self.localizableTitle = localizableTitle
        return self
    }
}
