import Foundation

public struct ActionsCellStyle {
    public var sendText: WalletTextStyle
    public var receiveText: WalletTextStyle

    public init(sendText: WalletTextStyle, receiveText: WalletTextStyle) {
        self.sendText = sendText
        self.receiveText = receiveText
    }
}

extension ActionsCellStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> ActionsCellStyle {
        return ActionsCellStyle(sendText: WalletTextStyle(font: style.bodyBoldFont, color: .accentColor),
                                receiveText: WalletTextStyle(font: style.bodyBoldFont, color: .secondaryColor))
    }
}
