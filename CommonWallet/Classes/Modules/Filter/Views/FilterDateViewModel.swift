import Foundation


final class FilterDateViewModel: WalletViewModelProtocol {
    
    let cellReuseIdentifier: String = FilterConstants.dateCellIdentifier
    let itemHeight: CGFloat = 56
    
    private(set) var dateString: String?
    private(set) var title: String
    private var action: () -> Void
    
    init(title: String, dateString: String?, action: @escaping () -> Void) {
        self.title = title
        self.dateString = dateString
        self.action = action
    }
    
    func didSelect() {
        action()
    }
    
}
