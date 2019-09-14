/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

protocol ResolverProtocol: class {
    var account: WalletAccountSettingsProtocol { get }
    var networkResolver: WalletNetworkResolverProtocol { get }
    var style: WalletStyleProtocol { get }
    var accountListConfiguration: AccountListConfigurationProtocol { get }
    var historyConfiguration: HistoryConfigurationProtocol { get }
    var contactsConfiguration: ContactsConfigurationProtocol { get }
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol { get }
    var navigation: NavigationProtocol? { get }
    var logger: WalletLoggerProtocol? { get }
    var amountFormatter: NumberFormatter { get }
    var statusDateFormatter: DateFormatter { get }
    var transferAmountLimit: Decimal { get }
    var transactionTypeList: [WalletTransactionType]? { get }
    var commandFactory: WalletCommandFactoryProtocol { get }
    var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol? { get }
    var inputValidatorFactory: WalletInputValidatorFactoryProtocol { get }
}

final class Resolver: ResolverProtocol {
    var account: WalletAccountSettingsProtocol
    var networkResolver: WalletNetworkResolverProtocol
    var accountListConfiguration: AccountListConfigurationProtocol
    var historyConfiguration: HistoryConfigurationProtocol
    var contactsConfiguration: ContactsConfigurationProtocol
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol
    var inputValidatorFactory: WalletInputValidatorFactoryProtocol
    var navigation: NavigationProtocol?

    lazy var style: WalletStyleProtocol = WalletStyle()
    lazy var amountFormatter: NumberFormatter = NumberFormatter()
    lazy var statusDateFormatter: DateFormatter = DateFormatter.statusDateFormatter
    var transferAmountLimit: Decimal = 1e+7
    var logger: WalletLoggerProtocol?
    var transactionTypeList: [WalletTransactionType]?
    var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol?

    var commandFactory: WalletCommandFactoryProtocol { return self }

    init(account: WalletAccountSettingsProtocol,
         networkResolver: WalletNetworkResolverProtocol,
         accountListConfiguration: AccountListConfigurationProtocol,
         historyConfiguration: HistoryConfigurationProtocol,
         contactsConfiguration: ContactsConfigurationProtocol,
         invoiceScanConfiguration: InvoiceScanConfigurationProtocol,
         inputValidatorFactory: WalletInputValidatorFactoryProtocol) {
        self.account = account
        self.networkResolver = networkResolver
        self.accountListConfiguration = accountListConfiguration
        self.historyConfiguration = historyConfiguration
        self.contactsConfiguration = contactsConfiguration
        self.invoiceScanConfiguration = invoiceScanConfiguration
        self.inputValidatorFactory = inputValidatorFactory
    }
}
