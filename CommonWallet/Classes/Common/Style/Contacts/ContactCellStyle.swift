import Foundation


public protocol ContactCellStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var nameIcon: WalletNameIconStyleProtocol { get }
    var separatorColor: UIColor { get }
    var accessoryIcon: UIImage? { get }
}


public struct ContactCellStyle: ContactCellStyleProtocol {
    public var title: WalletTextStyleProtocol
    public var nameIcon: WalletNameIconStyleProtocol
    public var separatorColor: UIColor
    public var accessoryIcon: UIImage?
    
    public init(title: WalletTextStyleProtocol,
                nameIcon: WalletNameIconStyleProtocol,
                separatorColor: UIColor,
                accessoryIcon: UIImage?) {
        self.title = title
        self.nameIcon = nameIcon
        self.separatorColor = separatorColor
        self.accessoryIcon = accessoryIcon
    }

}


extension ContactCellStyle {

    static func createDefaultStyle(with style: WalletStyleProtocol) -> ContactCellStyle {
        let title = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)
        let accessoryIcon = UIImage(named: "accessoryListIcon",
                                    in: Bundle(for: WalletStyle.self),
                                    compatibleWith: nil)
        return ContactCellStyle(title: title,
                                nameIcon: style.nameIconStyle,
                                separatorColor: style.thinBorderColor,
                                accessoryIcon: accessoryIcon)
    }

}
