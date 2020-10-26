/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraFoundation

public protocol CommonWalletBuilderProtocol: class {
    static func builder(with account: WalletAccountSettingsProtocol,
                        networkOperationFactory: WalletNetworkOperationFactoryProtocol)
        -> CommonWalletBuilderProtocol

    var accountListModuleBuilder: AccountListModuleBuilderProtocol { get }
    var accountDetailsModuleBuilder: AccountDetailsModuleBuilderProtocol { get }
    var historyModuleBuilder: HistoryModuleBuilderProtocol { get }
    var invoiceScanModuleBuilder: InvoiceScanModuleBuilderProtocol { get }
    var contactsModuleBuilder: ContactsModuleBuilderProtocol { get }
    var receiveModuleBuilder: ReceiveAmountModuleBuilderProtocol { get }
    var transactionDetailsModuleBuilder: TransactionDetailsModuleBuilderProtocol { get }
    var transferModuleBuilder: TransferModuleBuilderProtocol { get }
    var withdrawModuleBuilder: WithdrawModuleBuilderProtocol { get }
    var transferConfirmationBuilder: TransferConfirmationModuleBuilderProtocol { get }
    var styleBuilder: WalletStyleBuilderProtocol { get }

    @discardableResult
    func with(networkOperationFactory: WalletNetworkOperationFactoryProtocol) -> Self

    @discardableResult
    func with(feeCalculationFactory: FeeCalculationFactoryProtocol) -> Self

    @discardableResult
    func with(feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol) -> Self

    @discardableResult
    func with(amountFormatterFactory: NumberFormatterFactoryProtocol) -> Self

    @discardableResult
    func with(statusDateFormatter: LocalizableResource<DateFormatter>) -> Self

    @discardableResult
    func with(transferDescriptionLimit: UInt8) -> Self

    @discardableResult
    func with(logger: WalletLoggerProtocol) -> Self
    
    @discardableResult
    func with(transactionTypeList: [WalletTransactionType]) -> Self

    @discardableResult
    func with(commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol) -> Self

    @discardableResult
    func with(inputValidatorFactory: WalletInputValidatorFactoryProtocol) -> Self

    @discardableResult
    func with(qrCoderFactory: WalletQRCoderFactoryProtocol) -> Self
    
    @discardableResult
    func with(language: WalletLanguage) -> Self

    @discardableResult
    func with(singleProviderIdentifierFactory: SingleProviderIdentifierFactoryProtocol) -> Self
    
    func build() throws -> CommonWalletContextProtocol
}

public enum CommonWalletBuilderError: Error {
    case moduleCreationFailed
}

public final class CommonWalletBuilder {
    fileprivate var privateAccountModuleBuilder: AccountListModuleBuilder
    fileprivate var privateAccountDetailsModuleBuilder: AccountDetailsModuleBuilder
    fileprivate var privateHistoryModuleBuilder: HistoryModuleBuilder
    fileprivate var privateContactsModuleBuilder: ContactsModuleBuilder
    fileprivate var privateInvoiceScanModuleBuilder: InvoiceScanModuleBuilder
    fileprivate var privateReceiveModuleBuilder: ReceiveAmountModuleBuilder
    fileprivate var privateTransactionDetailsModuleBuilder: TransactionDetailsModuleBuilder
    fileprivate var privateTransferModuleBuilder: TransferModuleBuilder
    fileprivate var privateWithdrawModuleBuilder: WithdrawModuleBuilder
    fileprivate var privateTransferConfirmationBuilder: TransferConfirmationModuleBuilder
    fileprivate var privateStyleBuilder: WalletStyleBuilder
    fileprivate var account: WalletAccountSettingsProtocol
    fileprivate var networkOperationFactory: WalletNetworkOperationFactoryProtocol
    fileprivate lazy var feeCalculationFactory: FeeCalculationFactoryProtocol = FeeCalculationFactory()
    fileprivate lazy var feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol = FeeDisplaySettingsFactory()
    fileprivate lazy var singleProviderIdentifierFactory: SingleProviderIdentifierFactoryProtocol =
        SingleProviderIdentifierFactory()
    fileprivate var logger: WalletLoggerProtocol?
    fileprivate var amountFormatterFactory: NumberFormatterFactoryProtocol?
    fileprivate var statusDateFormatter: LocalizableResource<DateFormatter>?
    fileprivate var transferDescriptionLimit: UInt8 = 64
    fileprivate var transactionTypeList: [WalletTransactionType]?
    fileprivate var commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol?
    fileprivate var inputValidatorFactory: WalletInputValidatorFactoryProtocol?
    fileprivate var qrCoderFactory: WalletQRCoderFactoryProtocol?
    fileprivate var language: WalletLanguage = .english

    init(account: WalletAccountSettingsProtocol, networkOperationFactory: WalletNetworkOperationFactoryProtocol) {
        self.account = account
        self.networkOperationFactory = networkOperationFactory
        privateAccountModuleBuilder = AccountListModuleBuilder()
        privateAccountDetailsModuleBuilder = AccountDetailsModuleBuilder()
        privateHistoryModuleBuilder = HistoryModuleBuilder()
        privateContactsModuleBuilder = ContactsModuleBuilder()
        privateInvoiceScanModuleBuilder = InvoiceScanModuleBuilder()
        privateReceiveModuleBuilder = ReceiveAmountModuleBuilder()
        privateTransactionDetailsModuleBuilder = TransactionDetailsModuleBuilder()
        privateTransferModuleBuilder = TransferModuleBuilder()
        privateWithdrawModuleBuilder = WithdrawModuleBuilder()
        privateTransferConfirmationBuilder = TransferConfirmationModuleBuilder()
        privateStyleBuilder = WalletStyleBuilder()
    }
}

extension CommonWalletBuilder: CommonWalletBuilderProtocol {
    public var accountListModuleBuilder: AccountListModuleBuilderProtocol {
        return privateAccountModuleBuilder
    }

    public var accountDetailsModuleBuilder: AccountDetailsModuleBuilderProtocol {
        return privateAccountDetailsModuleBuilder
    }

    public var historyModuleBuilder: HistoryModuleBuilderProtocol {
        return privateHistoryModuleBuilder
    }
    
    public var contactsModuleBuilder: ContactsModuleBuilderProtocol {
        return privateContactsModuleBuilder
    }

    public var invoiceScanModuleBuilder: InvoiceScanModuleBuilderProtocol {
        return privateInvoiceScanModuleBuilder
    }

    public var receiveModuleBuilder: ReceiveAmountModuleBuilderProtocol {
        return privateReceiveModuleBuilder
    }

    public var transactionDetailsModuleBuilder: TransactionDetailsModuleBuilderProtocol {
        return privateTransactionDetailsModuleBuilder
    }

    public var transferModuleBuilder: TransferModuleBuilderProtocol {
        return privateTransferModuleBuilder
    }

    public var withdrawModuleBuilder: WithdrawModuleBuilderProtocol {
        return privateWithdrawModuleBuilder
    }

    public var transferConfirmationBuilder: TransferConfirmationModuleBuilderProtocol {
        return privateTransferConfirmationBuilder
    }

    public var styleBuilder: WalletStyleBuilderProtocol {
        return privateStyleBuilder
    }

    public static func builder(with account: WalletAccountSettingsProtocol,
                               networkOperationFactory: WalletNetworkOperationFactoryProtocol)
        -> CommonWalletBuilderProtocol {
        return CommonWalletBuilder(account: account, networkOperationFactory: networkOperationFactory)
    }

    public func with(networkOperationFactory: WalletNetworkOperationFactoryProtocol) -> Self {
        self.networkOperationFactory = networkOperationFactory

        return self
    }

    public func with(feeCalculationFactory: FeeCalculationFactoryProtocol) -> Self {
        self.feeCalculationFactory = feeCalculationFactory

        return self
    }

    public func with(feeDisplaySettingsFactory: FeeDisplaySettingsFactoryProtocol) -> Self {
        self.feeDisplaySettingsFactory = feeDisplaySettingsFactory

        return self
    }

    public func with(amountFormatterFactory: NumberFormatterFactoryProtocol) -> Self {
        self.amountFormatterFactory = amountFormatterFactory

        return self
    }

    public func with(statusDateFormatter: LocalizableResource<DateFormatter>) -> Self {
        self.statusDateFormatter = statusDateFormatter

        return self
    }

    public func with(logger: WalletLoggerProtocol) -> Self {
        self.logger = logger
        return self
    }

    public func with(transferDescriptionLimit: UInt8) -> Self {
        self.transferDescriptionLimit = transferDescriptionLimit
        return self
    }
    
    public func with(transactionTypeList: [WalletTransactionType]) -> Self {
        self.transactionTypeList = transactionTypeList
        return self
    }

    public func with(commandDecoratorFactory: WalletCommandDecoratorFactoryProtocol) -> Self {
        self.commandDecoratorFactory = commandDecoratorFactory
        return self
    }

    public func with(inputValidatorFactory: WalletInputValidatorFactoryProtocol) -> Self {
        self.inputValidatorFactory = inputValidatorFactory
        return self
    }

    public func with(qrCoderFactory: WalletQRCoderFactoryProtocol) -> Self {
        self.qrCoderFactory = qrCoderFactory
        return self
    }
    
    public func with(language: WalletLanguage) -> Self {
        self.language = language
        return self
    }

    public func with(singleProviderIdentifierFactory: SingleProviderIdentifierFactoryProtocol) -> Self {
        self.singleProviderIdentifierFactory = singleProviderIdentifierFactory
        return self
    }

    public func build() throws -> CommonWalletContextProtocol {
        let resolver = try createResolver()

        resolver.commandDecoratorFactory = commandDecoratorFactory

        resolver.logger = logger

        if let amountFormatterFactory = amountFormatterFactory {
            resolver.amountFormatterFactory = amountFormatterFactory
        }

        if let statusDateFormatter = statusDateFormatter {
            resolver.statusDateFormatter = statusDateFormatter
        }

        if let transactionTypeList = transactionTypeList {
            resolver.transactionTypeList = transactionTypeList

            WalletTransactionType.required.forEach { type in
                if !resolver.transactionTypeList.contains(where: { $0.backendName == type.backendName }) {
                    resolver.transactionTypeList.insert(type, at: 0)
                }
            }

        } else {
            resolver.transactionTypeList = WalletTransactionType.required
        }

        if let qrCoderFactory = qrCoderFactory {
            resolver.qrCoderFactory = qrCoderFactory
        }

        let allLanguages: [String] = WalletLanguage.allCases.map { $0.rawValue }
        resolver.localizationManager = LocalizationManager(localization: language.rawValue,
                                                           availableLocalizations: allLanguages)
        L10n.sharedLanguage = language

        return resolver
    }

    // MARK: Private

    private func createResolver() throws -> Resolver {
        let style = privateStyleBuilder.build()

        privateAccountModuleBuilder.walletStyle = style
        let accountListConfiguration = try privateAccountModuleBuilder.build()

        let accountDetailsConfiguration = try privateAccountDetailsModuleBuilder.build()

        privateHistoryModuleBuilder.walletStyle = style
        let historyConfiguration = privateHistoryModuleBuilder.build()

        privateContactsModuleBuilder.walletStyle = style
        let contactsConfiguration = privateContactsModuleBuilder.build()

        privateInvoiceScanModuleBuilder.walletStyle = style
        let invoiceScanConfiguration = privateInvoiceScanModuleBuilder.build()

        privateReceiveModuleBuilder.walletStyle = style
        let receiveConfiguration = privateReceiveModuleBuilder.build()

        let transactionDetailsConfiguration = privateTransactionDetailsModuleBuilder.build()

        privateTransferModuleBuilder.style = style
        let transferConfiguration = privateTransferModuleBuilder.build()

        privateWithdrawModuleBuilder.style = style
        let withdrawConfiguration = privateWithdrawModuleBuilder.build()

        let transferConfirmationConfiguration = privateTransferConfirmationBuilder.build()

        let decorator = WalletInputValidatorFactoryDecorator(descriptionMaxLength: transferDescriptionLimit)
        decorator.underlyingFactory = inputValidatorFactory

        let resolver = Resolver(account: account,
                                networkOperationFactory: networkOperationFactory,
                                accountListConfiguration: accountListConfiguration,
                                accountDetailsConfiguration: accountDetailsConfiguration,
                                historyConfiguration: historyConfiguration,
                                contactsConfiguration: contactsConfiguration,
                                invoiceScanConfiguration: invoiceScanConfiguration,
                                receiveConfiguration: receiveConfiguration,
                                transactionDetailsConfiguration: transactionDetailsConfiguration,
                                transferConfiguration: transferConfiguration,
                                withdrawConfiguration: withdrawConfiguration,
                                transferConfirmationConfiguration: transferConfirmationConfiguration,
                                inputValidatorFactory: decorator,
                                feeCalculationFactory: feeCalculationFactory,
                                feeDisplaySettingsFactory: feeDisplaySettingsFactory,
                                singleValueIdentifierFactory: singleProviderIdentifierFactory)

        resolver.style = style

        return resolver
    }
}
