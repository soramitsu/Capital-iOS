import Foundation


public struct ContactConstants {
    static let contactCellIdentifier: String = "co.jp.capital.contact.cell.identifier"
    static let contactCellHeight: CGFloat = 56
    static let scanCellIdentifier: String = "co.jp.capital.contact.scan.cell.identifier"
    static let scanCellHeight: CGFloat = 56
}


protocol ContactsViewModelFactoryProtocol {
    
    func createContactViewModel(from contact: SearchData,
                                delegate: ContactViewModelDelegate?) -> ContactViewModelProtocol
    func createScanViewModel(delegate: ScanCodeViewModelDelegate?) -> ScanCodeViewModelProtocol
    
}


final class ContactsViewModelFactory: ContactsViewModelFactoryProtocol {
    
    private let configuration: ContactsConfigurationProtocol
    private let avatarRadius: CGFloat
    
    init(configuration: ContactsConfigurationProtocol, avatarRadius: CGFloat) {
        self.configuration = configuration
        self.avatarRadius = avatarRadius
    }
    
    func createContactViewModel(from contact: SearchData,
                                delegate: ContactViewModelDelegate?) -> ContactViewModelProtocol {

        let image = UIImage.createAvatar(firstName: contact.firstName,
                                         lastName: contact.lastName,
                                         radius: avatarRadius,
                                         style: configuration.contactCellStyle.nameIcon)

        let viewModel = ContactViewModel(cellReuseIdentifier: ContactConstants.contactCellIdentifier,
                                         itemHeight: ContactConstants.contactCellHeight,
                                         contact: contact,
                                         image: image)
        
        viewModel.delegate = delegate
        viewModel.style = configuration.contactCellStyle
        
        return viewModel
    }
    
    func createScanViewModel(delegate: ScanCodeViewModelDelegate?) -> ScanCodeViewModelProtocol {
        
        let viewModel = ScanCodeViewModel(cellReuseIdentifier: ContactConstants.scanCellIdentifier,
                                          itemHeight: ContactConstants.scanCellHeight)
        viewModel.delegate = delegate
        viewModel.style = configuration.scanCodeCellStyle
        
        return viewModel
    }
    
}
