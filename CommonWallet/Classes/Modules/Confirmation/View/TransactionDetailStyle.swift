import Foundation


public protocol TransactionDetailStyleProtocol {
    var title: WalletTextStyleProtocol { get }
    var detail: WalletTextStyleProtocol { get }
    var separatorColor: UIColor { get }
}


public struct TransactionDetailStyle: TransactionDetailStyleProtocol {
    public var title: WalletTextStyleProtocol
    public var detail: WalletTextStyleProtocol
    public var separatorColor: UIColor
    
    public init(title: WalletTextStyleProtocol, detail: WalletTextStyleProtocol, separatorColor: UIColor) {
        self.title = title
        self.detail = detail
        self.separatorColor = separatorColor
    }
}


extension TransactionDetailStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> TransactionDetailStyle {
        return TransactionDetailStyle(title: WalletTextStyle(font: style.bodyRegularFont,
                                                             color: style.captionTextColor),
                                      detail: WalletTextStyle(font: style.bodyRegularFont,
                                                              color: style.bodyTextColor),
                                      separatorColor: style.thinBorderColor)
    }
}
