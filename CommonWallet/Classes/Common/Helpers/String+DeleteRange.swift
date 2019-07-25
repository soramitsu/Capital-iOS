import Foundation


extension String {
    
    func deleteCharactersIn(range: NSRange) -> String {
        let mutableSelf = NSMutableString(string: self)
        mutableSelf.deleteCharacters(in: range)
        return String(mutableSelf)
    }
    
}
