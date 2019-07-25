import Foundation


protocol TransactionCellProtocol {
    
    var style: TransactionDetailStyleProtocol? { get set }
    var isLast: Bool { get set }
    
    func bind(viewModel: TransactionViewModelProtocol)
    
}
