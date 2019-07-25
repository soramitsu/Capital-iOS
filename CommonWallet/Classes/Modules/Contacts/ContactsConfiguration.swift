import Foundation
import SoraUI

protocol ContactsConfigurationProtocol {
    var contactCellStyle: ContactCellStyleProtocol { get }
    var scanCodeCellStyle: ScanCodeCellStyleProtocol { get }
    var viewStyle: ContactsViewStyleProtocol { get }
    var sectionStyle: WalletTextStyleProtocol { get }
    var searchPlaceholder: String { get }
    var contactsEmptyStateDataSource: EmptyStateDataSource? { get }
    var contactsEmptyStateDelegate: EmptyStateDelegate? { get }
    var searchEmptyStateDataSource: EmptyStateDataSource? { get }
    var searchEmptyStateDelegate: EmptyStateDelegate? { get }
    var supportsLiveSearch: Bool { get }
}


struct ContactsConfiguration: ContactsConfigurationProtocol {
    var contactCellStyle: ContactCellStyleProtocol
    var scanCodeCellStyle: ScanCodeCellStyleProtocol
    var viewStyle: ContactsViewStyleProtocol
    var sectionStyle: WalletTextStyleProtocol
    var searchPlaceholder: String
    var contactsEmptyStateDataSource: EmptyStateDataSource?
    weak var contactsEmptyStateDelegate: EmptyStateDelegate?
    var searchEmptyStateDataSource: EmptyStateDataSource?
    weak var searchEmptyStateDelegate: EmptyStateDelegate?
    var supportsLiveSearch: Bool
}
