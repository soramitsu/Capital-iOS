/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import SoraFoundation

enum ReceiveAmountModuleBuilderError: Error {}


final class ReceiveAmountModuleBuilder {
    fileprivate lazy var accountShareFactory: AccountShareFactoryProtocol = AccountShareFactory()
    fileprivate var title: LocalizableResource<String> = LocalizableResource { _ in L10n.Receive.title }
    fileprivate var fieldsInclusion: ReceiveFieldsInclusion = [.selectedAsset, .amount]
    fileprivate var settings: WalletTransactionSettingsProtocol = WalletTransactionSettings.defaultSettings
    fileprivate var viewFactory: ReceiveViewFactoryProtocol?

    lazy var walletStyle: WalletStyleProtocol = WalletStyle()

    private lazy var viewStyle: ReceiveStyleProtocol = {
        return ReceiveStyle.createDefaultStyle(with: walletStyle)
    }()

    func build() -> ReceiveAmountConfigurationProtocol {
        return ReceiveAmountConfiguration(accountShareFactory: accountShareFactory,
                                          title: title,
                                          fieldsInclusion: fieldsInclusion,
                                          settings: settings,
                                          receiveStyle: viewStyle,
                                          viewFactory: viewFactory)
    }
}


extension ReceiveAmountModuleBuilder: ReceiveAmountModuleBuilderProtocol {
    @discardableResult
    func with(accountShareFactory: AccountShareFactoryProtocol) -> Self {
        self.accountShareFactory = accountShareFactory
        return self
    }

    @discardableResult
    func with(title: LocalizableResource<String>) -> Self {
        self.title = title
        return self
    }

    @discardableResult
    func with(fieldsInclusion: ReceiveFieldsInclusion) -> Self {
        self.fieldsInclusion = fieldsInclusion
        return self
    }

    func with(settings: WalletTransactionSettingsProtocol) -> Self {
        self.settings = settings
        return self
    }

    func with(style: ReceiveStyleProtocol) -> Self {
        self.viewStyle = style
        return self
    }

    func with(viewFactory: ReceiveViewFactoryProtocol) -> Self {
        self.viewFactory = viewFactory
        return self
    }
}
