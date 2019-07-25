import Foundation


extension String {
    
    func calculateSize(with boundingSize: CGSize, font: UIFont) -> CGSize {
        let boundingBox = self.boundingRect(with: boundingSize,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font],
                                            context: nil)
        
        return boundingBox.size
    }

}
