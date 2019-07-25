import Foundation
import IrohaCommunication

struct HashPagination {
    var pageHash: String?
    var count: UInt32
}

extension HashPagination {
    var irPagination: IRPagination? {

        if let pageHash = pageHash {
            guard let hashData = NSData(hexString: pageHash) else {
                return nil
            }

            return try? IRPaginationFactory.pagination(count, firstItemHash: hashData as Data)
        } else {
            return try? IRPaginationFactory.pagination(count, firstItemHash: nil)
        }
    }
}
