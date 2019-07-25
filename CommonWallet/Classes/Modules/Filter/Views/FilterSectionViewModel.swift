import Foundation


final class FilterSectionViewModel: WalletViewModelProtocol {
    
    let cellReuseIdentifier: String = FilterConstants.headerIdentifier
    let itemHeight: CGFloat = 56
    private(set) var title: String
    
    init(title: String) {
        self.title = title
    }
    
    func didSelect() {}
    
}
