import Foundation


public typealias ScanCodeViewModelFactory = (ScanCodeViewModelDelegate?) -> ScanCodeViewModelProtocol


public protocol ScanCodeViewModelDelegate: class {
    
    func scanCode()
    
}


public protocol ScanCodeViewModelProtocol: WalletViewModelProtocol {
    
    var title: String { get }
    var icon: UIImage? { get }
    var style: ScanCodeCellStyleProtocol? { get }
    
}


final class ScanCodeViewModel: ScanCodeViewModelProtocol {
    
    var cellReuseIdentifier: String
    var itemHeight: CGFloat
    
    var title: String
    var icon: UIImage?
    var style: ScanCodeCellStyleProtocol?
    
    weak var delegate: ScanCodeViewModelDelegate?
    
    init(cellReuseIdentifier: String, itemHeight: CGFloat) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight

        self.title = "Scan QR code"
        self.icon = UIImage(named: "qr", in: Bundle(for: type(of: self)), compatibleWith: nil)
    }
    
    func didSelect() {
        delegate?.scanCode()
    }
    
}
