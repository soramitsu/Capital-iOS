import Foundation

protocol TransactionStatusDesignable {
    func fetchColor(for status: AssetTransactionStatus, incoming: Bool, style: TransactionCellStyleProtocol) -> UIColor
    func fetchIcon(for status: AssetTransactionStatus, incoming: Bool, style: TransactionCellStyleProtocol) -> UIImage?
}
