/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication

protocol ResolverProtocol: class {
    var account: WalletAccountSettingsProtocol { get }
    var networkResolver: WalletNetworkResolverProtocol { get }
    var networkOperationFactory: WalletNetworkOperationFactoryProtocol { get }
    var style: WalletStyleProtocol { get }
    var accountListConfiguration: AccountListConfigurationProtocol { get }
    var historyConfiguration: HistoryConfigurationProtocol { get }
    var contactsConfiguration: ContactsConfigurationProtocol { get }
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol { get }
    var receiveConfiguration: ReceiveAmountConfigurationProtocol { get }
    var navigation: NavigationProtocol? { get }
    var logger: WalletLoggerProtocol? { get }
    var amountFormatter: NumberFormatter { get }
    var statusDateFormatter: DateFormatter { get }
    var transferAmountLimit: Decimal { get }
    var transactionTypeList: [WalletTransactionType] { get }
    var commandFactory: WalletCommandFactoryProtocol { get }
    var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol? { get }
    var inputValidatorFactory: WalletInputValidatorFactoryProtocol { get }
    var feeCalculationFactory: FeeCalculationFactoryProtocol { get }
}

final class Resolver: ResolverProtocol {
    var account: WalletAccountSettingsProtocol
    var networkResolver: WalletNetworkResolverProtocol
    var networkOperationFactory: WalletNetworkOperationFactoryProtocol
    var accountListConfiguration: AccountListConfigurationProtocol
    var historyConfiguration: HistoryConfigurationProtocol
    var contactsConfiguration: ContactsConfigurationProtocol
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol
    var receiveConfiguration: ReceiveAmountConfigurationProtocol
    var inputValidatorFactory: WalletInputValidatorFactoryProtocol
    var feeCalculationFactory: FeeCalculationFactoryProtocol
    var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol?
    var navigation: NavigationProtocol?

    lazy var style: WalletStyleProtocol = WalletStyle()
    lazy var amountFormatter: NumberFormatter = NumberFormatter()
    lazy var statusDateFormatter: DateFormatter = DateFormatter.statusDateFormatter
    var transferAmountLimit: Decimal = 1e+7
    var transactionTypeList: [WalletTransactionType] = []

    var logger: WalletLoggerProtocol?

    var commandFactory: WalletCommandFactoryProtocol { return self }

    init(account: WalletAccountSettingsProtocol,
         networkResolver: WalletNetworkResolverProtocol,
         networkOperationFactory: WalletNetworkOperationFactoryProtocol,
         accountListConfiguration: AccountListConfigurationProtocol,
         historyConfiguration: HistoryConfigurationProtocol,
         contactsConfiguration: ContactsConfigurationProtocol,
         invoiceScanConfiguration: InvoiceScanConfigurationProtocol,
         receiveConfiguration: ReceiveAmountConfigurationProtocol,
         inputValidatorFactory: WalletInputValidatorFactoryProtocol,
         feeCalculationFactory: FeeCalculationFactoryProtocol) {
        self.account = account
        self.networkResolver = networkResolver
        self.networkOperationFactory = networkOperationFactory
        self.accountListConfiguration = accountListConfiguration
        self.historyConfiguration = historyConfiguration
        self.contactsConfiguration = contactsConfiguration
        self.invoiceScanConfiguration = invoiceScanConfiguration
        self.receiveConfiguration = receiveConfiguration
        self.inputValidatorFactory = inputValidatorFactory
        self.feeCalculationFactory = feeCalculationFactory
    }
}
