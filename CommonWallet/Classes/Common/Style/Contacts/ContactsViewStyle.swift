import Foundation


public protocol ContactsViewStyleProtocol {
    var backgroundColor: UIColor { get }
    var searchHeaderBackgroundColor: UIColor { get }
    var searchTextStyle: WalletTextStyleProtocol { get }
    var searchIndicatorStyle: UIColor { get }
    var searchFieldColor: UIColor { get }
    var closeIcon: UIImage? { get }
    var searchIcon: UIImage? { get }
}


public struct ContactsViewStyle: ContactsViewStyleProtocol {
    public var backgroundColor: UIColor
    public var searchHeaderBackgroundColor: UIColor
    public var searchTextStyle: WalletTextStyleProtocol
    public var searchFieldColor: UIColor
    public var searchIndicatorStyle: UIColor
    public var closeIcon: UIImage?
    public var searchIcon: UIImage?

    public init(backgroundColor: UIColor,
                searchHeaderBackgroundColor: UIColor,
                searchTextStyle: WalletTextStyleProtocol,
                searchFieldColor: UIColor,
                searchIndicatorStyle: UIColor,
                closeIcon: UIImage?,
                searchIcon: UIImage?) {
        self.backgroundColor = backgroundColor
        self.searchTextStyle = searchTextStyle
        self.searchHeaderBackgroundColor = searchHeaderBackgroundColor
        self.searchFieldColor = searchFieldColor
        self.searchIndicatorStyle = searchIndicatorStyle
        self.closeIcon = closeIcon
        self.searchIcon = searchIcon
    }

}


extension ContactsViewStyle {

    static func createDefaultStyle(with style: WalletStyleProtocol) -> ContactsViewStyle {
        let searchTextStyle = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)
        let searchIcon = UIImage(named: "iconSearch", in: Bundle(for: WalletStyle.self), compatibleWith: nil)
        return ContactsViewStyle(backgroundColor: style.backgroundColor,
                                 searchHeaderBackgroundColor: style.navigationBarStyle.barColor,
                                 searchTextStyle: searchTextStyle,
                                 searchFieldColor: .search,
                                 searchIndicatorStyle: .greyText,
                                 closeIcon: style.closeIcon,
                                 searchIcon: searchIcon)
    }

}
