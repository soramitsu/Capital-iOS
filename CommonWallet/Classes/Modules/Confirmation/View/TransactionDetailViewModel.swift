import Foundation


protocol TransactionViewModelProtocol {}


protocol TransactionDetailViewModelProtocol: TransactionViewModelProtocol {
    var title: String { get }
    var detail: String? { get }
    var icon: UIImage? { get }
}


struct TransactionDetailViewModel: TransactionDetailViewModelProtocol {
    
    var title: String
    var detail: String?
    var icon: UIImage?
        
}


protocol TransactionDescriptionViewModelProtocol: TransactionViewModelProtocol {
    
    var title: String { get }
    var description: String { get }
    
}


struct TransactionDescriptionViewModel: TransactionDescriptionViewModelProtocol {
    
    var title: String
    var description: String
    
}
