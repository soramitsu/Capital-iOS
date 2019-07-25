import Foundation


public protocol ScanCodeCellStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var separatorColor: UIColor { get }
    var scanIcon: UIImage? { get }
    var accessoryIcon: UIImage? { get }
}


public struct ScanCodeCellStyle: ScanCodeCellStyleProtocol {
    public var title: WalletTextStyleProtocol
    public var separatorColor: UIColor
    public var scanIcon: UIImage?
    public var accessoryIcon: UIImage?
    
    public init(title: WalletTextStyleProtocol,
                separatorColor: UIColor,
                scanIcon: UIImage?,
                accessoryIcon: UIImage?) {
        self.title = title
        self.separatorColor = separatorColor
        self.scanIcon = scanIcon
        self.accessoryIcon = accessoryIcon
    }
}


extension ScanCodeCellStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> ScanCodeCellStyle {
        let bundle = Bundle(for: WalletStyle.self)

        let title = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)
        let scanIcon = UIImage(named: "qr", in: bundle, compatibleWith: nil)
        let accessoryIcon = UIImage(named: "accessoryListIcon", in: bundle, compatibleWith: nil)

        return ScanCodeCellStyle(title: title,
                                 separatorColor: .accentColor,
                                 scanIcon: scanIcon,
                                 accessoryIcon: accessoryIcon)
    }
}
