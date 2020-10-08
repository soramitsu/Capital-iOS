/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation

protocol ResolverProtocol: class {
    var account: WalletAccountSettingsProtocol { get }
    var networkOperationFactory: WalletNetworkOperationFactoryProtocol { get }
    var eventCenter: WalletEventCenterProtocol { get }
    var style: WalletStyleProtocol { get }
    var accountListConfiguration: AccountListConfigurationProtocol { get }
    var accountDetailsConfiguration: AccountDetailsConfigurationProtocol { get }
    var historyConfiguration: HistoryConfigurationProtocol { get }
    var contactsConfiguration: ContactsConfigurationProtocol { get }
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol { get }
    var receiveConfiguration: ReceiveAmountConfigurationProtocol { get }
    var transactionDetailsConfiguration: TransactionDetailsConfigurationProtocol { get }
    var transferConfiguration: TransferConfigurationProtocol { get }
    var withdrawConfiguration: WithdrawConfigurationProtocol { get }
    var transferConfirmationConfiguration: TransferConfirmationConfigurationProtocol { get }
    var navigation: NavigationProtocol? { get }
    var logger: WalletLoggerProtocol? { get }
    var localizationManager: LocalizationManagerProtocol? { get }
    var amountFormatterFactory: NumberFormatterFactoryProtocol { get }
    var statusDateFormatter: LocalizableResource<DateFormatter> { get }
    var transactionTypeList: [WalletTransactionType] { get }
    var commandFactory: WalletCommandFactoryProtocol { get }
    var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol? { get }
    var inputValidatorFactory: WalletInputValidatorFactoryProtocol { get }
    var feeCalculationFactory: FeeCalculationFactoryProtocol { get }
    var feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol { get }
    var qrCoderFactory: WalletQRCoderFactoryProtocol { get }
    var singleValueIdentifierFactory: SingleProviderIdentifierFactoryProtocol { get }
}

final class Resolver: ResolverProtocol {
    var account: WalletAccountSettingsProtocol
    var networkOperationFactory: WalletNetworkOperationFactoryProtocol
    var accountListConfiguration: AccountListConfigurationProtocol
    var accountDetailsConfiguration: AccountDetailsConfigurationProtocol
    var historyConfiguration: HistoryConfigurationProtocol
    var contactsConfiguration: ContactsConfigurationProtocol
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol
    var receiveConfiguration: ReceiveAmountConfigurationProtocol
    var transactionDetailsConfiguration: TransactionDetailsConfigurationProtocol
    var transferConfiguration: TransferConfigurationProtocol
    var withdrawConfiguration: WithdrawConfigurationProtocol
    var transferConfirmationConfiguration: TransferConfirmationConfigurationProtocol
    var inputValidatorFactory: WalletInputValidatorFactoryProtocol
    var feeCalculationFactory: FeeCalculationFactoryProtocol
    var feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol
    var singleValueIdentifierFactory: SingleProviderIdentifierFactoryProtocol
    var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol?
    var navigation: NavigationProtocol?

    lazy var qrCoderFactory: WalletQRCoderFactoryProtocol = WalletQRCoderFactory()

    lazy var eventCenter: WalletEventCenterProtocol = WalletEventCenter()

    lazy var style: WalletStyleProtocol = WalletStyle()
    lazy var amountFormatterFactory: NumberFormatterFactoryProtocol = NumberFormatterFactory()

    lazy var statusDateFormatter: LocalizableResource<DateFormatter> =
        DateFormatter.statusDateFormatter.localizableResource()

    var transactionTypeList: [WalletTransactionType] = []

    var logger: WalletLoggerProtocol?

    var localizationManager: LocalizationManagerProtocol?

    var commandFactory: WalletCommandFactoryProtocol { return self }

    init(account: WalletAccountSettingsProtocol,
         networkOperationFactory: WalletNetworkOperationFactoryProtocol,
         accountListConfiguration: AccountListConfigurationProtocol,
         accountDetailsConfiguration: AccountDetailsConfigurationProtocol,
         historyConfiguration: HistoryConfigurationProtocol,
         contactsConfiguration: ContactsConfigurationProtocol,
         invoiceScanConfiguration: InvoiceScanConfigurationProtocol,
         receiveConfiguration: ReceiveAmountConfigurationProtocol,
         transactionDetailsConfiguration: TransactionDetailsConfigurationProtocol,
         transferConfiguration: TransferConfigurationProtocol,
         withdrawConfiguration: WithdrawConfigurationProtocol,
         transferConfirmationConfiguration: TransferConfirmationConfigurationProtocol,
         inputValidatorFactory: WalletInputValidatorFactoryProtocol,
         feeCalculationFactory: FeeCalculationFactoryProtocol,
         feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol,
         singleValueIdentifierFactory: SingleProviderIdentifierFactoryProtocol) {
        self.account = account
        self.networkOperationFactory = networkOperationFactory
        self.accountListConfiguration = accountListConfiguration
        self.accountDetailsConfiguration = accountDetailsConfiguration
        self.historyConfiguration = historyConfiguration
        self.contactsConfiguration = contactsConfiguration
        self.invoiceScanConfiguration = invoiceScanConfiguration
        self.receiveConfiguration = receiveConfiguration
        self.transactionDetailsConfiguration = transactionDetailsConfiguration
        self.transferConfiguration = transferConfiguration
        self.withdrawConfiguration = withdrawConfiguration
        self.transferConfirmationConfiguration = transferConfirmationConfiguration
        self.inputValidatorFactory = inputValidatorFactory
        self.feeCalculationFactory = feeCalculationFactory
        self.feeDisplaySettingsFactory = feeDisplaySettingsFactory
        self.singleValueIdentifierFactory = singleValueIdentifierFactory
    }
}
