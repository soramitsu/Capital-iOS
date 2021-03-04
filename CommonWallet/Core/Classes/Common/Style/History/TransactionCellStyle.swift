/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation

public protocol TransactionCellStyleProtocol {
    var backgroundColor: UIColor { get }
    var title: WalletTextStyleProtocol { get }
    var amount: WalletTextStyleProtocol { get }
    var statusStyleContainer: WalletTransactionStatusStyleContainerProtocol { get }
    var increaseAmountIcon: UIImage? { get }
    var decreaseAmountIcon: UIImage? { get }
    var separatorColor: UIColor { get }
}

public struct TransactionCellStyle: TransactionCellStyleProtocol {
    public let backgroundColor: UIColor
    public let title: WalletTextStyleProtocol
    public let amount: WalletTextStyleProtocol
    public let statusStyleContainer: WalletTransactionStatusStyleContainerProtocol
    public let increaseAmountIcon: UIImage?
    public let decreaseAmountIcon: UIImage?
    public let separatorColor: UIColor

    public init(backgroundColor: UIColor,
                title: WalletTextStyleProtocol,
                amount: WalletTextStyleProtocol,
                statusStyleContainer: WalletTransactionStatusStyleContainerProtocol,
                increaseAmountIcon: UIImage?,
                decreaseAmountIcon: UIImage?,
                separatorColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.title = title
        self.amount = amount
        self.statusStyleContainer = statusStyleContainer
        self.increaseAmountIcon = increaseAmountIcon
        self.decreaseAmountIcon = decreaseAmountIcon
        self.separatorColor = separatorColor
    }
}

extension TransactionCellStyle {
    static func createDefaultStyle(with style: WalletStyleProtocol) -> TransactionCellStyle {
        return TransactionCellStyle(backgroundColor: .white,
                                    title: WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor),
                                    amount: WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor),
                                    statusStyleContainer: style.statusStyleContainer,
                                    increaseAmountIcon: style.amountChangeStyle.increase,
                                    decreaseAmountIcon: style.amountChangeStyle.decrease,
                                    separatorColor: style.thinBorderColor)
    }
}
