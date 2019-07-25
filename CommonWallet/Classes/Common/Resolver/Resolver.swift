import Foundation


protocol ResolverProtocol: class {
    var account: WalletAccountSettingsProtocol { get }
    var networkResolver: WalletNetworkResolverProtocol { get }
    var style: WalletStyleProtocol { get }
    var accountListConfiguration: AccountListConfigurationProtocol { get }
    var historyConfiguration: HistoryConfigurationProtocol { get }
    var contactsConfiguration: ContactsConfigurationProtocol { get }
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol { get }
    var navigation: NavigationProtocol! { get }
    var logger: WalletLoggerProtocol? { get }
    var amountFormatter: NumberFormatter { get }
    var historyDateFormatter: DateFormatter { get }
    var statusDateFormatter: DateFormatter { get }
    var transferDescriptionLimit: UInt8 { get }
    var transferAmountLimit: Decimal { get }
    var transactionTypeList: [WalletTransactionType]? { get }
}

final class Resolver: ResolverProtocol {
    var account: WalletAccountSettingsProtocol
    var networkResolver: WalletNetworkResolverProtocol
    var accountListConfiguration: AccountListConfigurationProtocol
    var historyConfiguration: HistoryConfigurationProtocol
    var contactsConfiguration: ContactsConfigurationProtocol
    var invoiceScanConfiguration: InvoiceScanConfigurationProtocol
    var navigation: NavigationProtocol!

    lazy var style: WalletStyleProtocol = WalletStyle()
    lazy var amountFormatter: NumberFormatter = NumberFormatter()
    lazy var historyDateFormatter: DateFormatter = DateFormatter.historyDateFormatter
    lazy var statusDateFormatter: DateFormatter = DateFormatter.statusDateFormatter
    var transferDescriptionLimit: UInt8 = 64
    var transferAmountLimit: Decimal = 1e+7
    var logger: WalletLoggerProtocol?
    var transactionTypeList: [WalletTransactionType]?

    init(account: WalletAccountSettingsProtocol,
         networkResolver: WalletNetworkResolverProtocol,
         accountListConfiguration: AccountListConfigurationProtocol,
         historyConfiguration: HistoryConfigurationProtocol,
         contactsConfiguration: ContactsConfigurationProtocol,
         invoiceScanConfiguration: InvoiceScanConfigurationProtocol) {
        self.account = account
        self.networkResolver = networkResolver
        self.accountListConfiguration = accountListConfiguration
        self.historyConfiguration = historyConfiguration
        self.contactsConfiguration = contactsConfiguration
        self.invoiceScanConfiguration = invoiceScanConfiguration
    }
}
