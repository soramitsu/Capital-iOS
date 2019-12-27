/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import IrohaCommunication
import SoraFoundation

protocol ResolverProtocol: class {
    var account: WalletAccountSettingsProtocol { get }
    var networkOperationFactory: WalletNetworkOperationFactoryProtocol { get }
    var eventCenter: WalletEventCenterProtocol { get }
    var style: WalletStyleProtocol { get }
    var accountListConfiguration: AccountListConfigurationProtocol { get }
    var historyConfiguration: HistoryConfigurationProtocol { get }
    var contactsConfiguration: ContactsConfigurationProtocol { get }
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol { get }
    var receiveConfiguration: ReceiveAmountConfigurationProtocol { get }
    var transactionDetailsConfiguration: TransactionDetailsConfigurationProtocol { get }
    var navigation: NavigationProtocol? { get }
    var logger: WalletLoggerProtocol? { get }
    var localizationManager: LocalizationManagerProtocol? { get }
    var amountFormatter: NumberFormatter { get }
    var statusDateFormatter: DateFormatter { get }
    var transferAmountLimit: Decimal { get }
    var transactionTypeList: [WalletTransactionType] { get }
    var commandFactory: WalletCommandFactoryProtocol { get }
    var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol? { get }
    var inputValidatorFactory: WalletInputValidatorFactoryProtocol { get }
    var feeCalculationFactory: FeeCalculationFactoryProtocol { get }
    var qrCoderFactory: WalletQRCoderFactoryProtocol { get }
}

final class Resolver: ResolverProtocol {
    var account: WalletAccountSettingsProtocol
    var networkOperationFactory: WalletNetworkOperationFactoryProtocol
    var accountListConfiguration: AccountListConfigurationProtocol
    var historyConfiguration: HistoryConfigurationProtocol
    var contactsConfiguration: ContactsConfigurationProtocol
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol
    var receiveConfiguration: ReceiveAmountConfigurationProtocol
    var transactionDetailsConfiguration: TransactionDetailsConfigurationProtocol
    var inputValidatorFactory: WalletInputValidatorFactoryProtocol
    var feeCalculationFactory: FeeCalculationFactoryProtocol
    var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol?
    var navigation: NavigationProtocol?

    lazy var qrCoderFactory: WalletQRCoderFactoryProtocol = WalletQRCoderFactory()

    lazy var eventCenter: WalletEventCenterProtocol = WalletEventCenter()

    lazy var style: WalletStyleProtocol = WalletStyle()
    lazy var amountFormatter: NumberFormatter = NumberFormatter()
    lazy var statusDateFormatter: DateFormatter = DateFormatter.statusDateFormatter
    var transferAmountLimit: Decimal = 1e+7
    var transactionTypeList: [WalletTransactionType] = []

    var logger: WalletLoggerProtocol?

    var localizationManager: LocalizationManagerProtocol?

    var commandFactory: WalletCommandFactoryProtocol { return self }

    init(account: WalletAccountSettingsProtocol,
         networkOperationFactory: WalletNetworkOperationFactoryProtocol,
         accountListConfiguration: AccountListConfigurationProtocol,
         historyConfiguration: HistoryConfigurationProtocol,
         contactsConfiguration: ContactsConfigurationProtocol,
         invoiceScanConfiguration: InvoiceScanConfigurationProtocol,
         receiveConfiguration: ReceiveAmountConfigurationProtocol,
         transactionDetailsConfiguration: TransactionDetailsConfigurationProtocol,
         inputValidatorFactory: WalletInputValidatorFactoryProtocol,
         feeCalculationFactory: FeeCalculationFactoryProtocol) {
        self.account = account
        self.networkOperationFactory = networkOperationFactory
        self.accountListConfiguration = accountListConfiguration
        self.historyConfiguration = historyConfiguration
        self.contactsConfiguration = contactsConfiguration
        self.invoiceScanConfiguration = invoiceScanConfiguration
        self.receiveConfiguration = receiveConfiguration
        self.transactionDetailsConfiguration = transactionDetailsConfiguration
        self.inputValidatorFactory = inputValidatorFactory
        self.feeCalculationFactory = feeCalculationFactory
    }
}
