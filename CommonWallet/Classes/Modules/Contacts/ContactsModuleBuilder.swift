import Contacts
import SoraUI

enum ContactsModuleBuilderError: Error {
    case contactIsInvalidError
}


final class ContactsModuleBuilder {

    lazy var walletStyle: WalletStyleProtocol = WalletStyle()
    
    fileprivate lazy var cellStyle: ContactCellStyleProtocol = {
        return ContactCellStyle.createDefaultStyle(with: walletStyle)
    }()
    
    fileprivate lazy var scanStyle: ScanCodeCellStyleProtocol = {
        return ScanCodeCellStyle.createDefaultStyle(with: walletStyle)
    }()
    
    fileprivate lazy var viewStyle: ContactsViewStyleProtocol = {
        return ContactsViewStyle.createDefaultStyle(with: walletStyle)
    }()
    
    fileprivate lazy var sectionStyle: WalletTextStyleProtocol = {
        return WalletTextStyle(font: walletStyle.bodyRegularFont,
                               color: walletStyle.captionTextColor)
    }()

    fileprivate weak var contactsEmptyStateDelegate: EmptyStateDelegate?
    fileprivate var contactsEmptyStateDataSource: EmptyStateDataSource?

    fileprivate weak var searchEmptyStateDelegate: EmptyStateDelegate?
    fileprivate var searchEmptyStateDataSource: EmptyStateDataSource?

    fileprivate var searchPlaceholder: String = "Search"

    fileprivate var supportsLiveSearch: Bool = false
    
    func build() -> ContactsConfigurationProtocol {
        return ContactsConfiguration(contactCellStyle: cellStyle,
                                     scanCodeCellStyle: scanStyle,
                                     viewStyle: viewStyle,
                                     sectionStyle: sectionStyle,
                                     searchPlaceholder: searchPlaceholder,
                                     contactsEmptyStateDataSource: contactsEmptyStateDataSource,
                                     contactsEmptyStateDelegate: contactsEmptyStateDelegate,
                                     searchEmptyStateDataSource: searchEmptyStateDataSource,
                                     searchEmptyStateDelegate: searchEmptyStateDelegate,
                                     supportsLiveSearch: supportsLiveSearch)
    }
    
}


extension ContactsModuleBuilder: ContactsModuleBuilderProtocol {
    
    func with(contactCellStyle: ContactCellStyleProtocol) -> Self {
        cellStyle = contactCellStyle
        return self
    }
    
    func with(scanCellStyle: ScanCodeCellStyleProtocol) -> Self {
        scanStyle = scanCellStyle
        return self
    }
    
    func with(viewStyle: ContactsViewStyleProtocol) -> Self {
        self.viewStyle = viewStyle
        return self
    }
    
    func with(sectionHeaderStyle: WalletTextStyleProtocol) -> Self {
        self.sectionStyle = sectionHeaderStyle
        return self
    }

    func with(searchPlaceholder: String) -> Self {
        self.searchPlaceholder = searchPlaceholder
        return self
    }

    func with(contactsEmptyStateDataSource: EmptyStateDataSource) -> Self {
        self.contactsEmptyStateDataSource = contactsEmptyStateDataSource
        return self
    }

    func with(contactsEmptyStateDelegate: EmptyStateDelegate) -> Self {
        self.contactsEmptyStateDelegate = contactsEmptyStateDelegate
        return self
    }

    func with(searchEmptyStateDataSource: EmptyStateDataSource) -> Self {
        self.searchEmptyStateDataSource = searchEmptyStateDataSource
        return self
    }

    func with(searchEmptyStateDelegate: EmptyStateDelegate) -> Self {
        self.searchEmptyStateDelegate = searchEmptyStateDelegate
        return self
    }

    @discardableResult
    func with(supportsLiveSearch: Bool) -> Self {
        self.supportsLiveSearch = supportsLiveSearch
        return self
    }
}
