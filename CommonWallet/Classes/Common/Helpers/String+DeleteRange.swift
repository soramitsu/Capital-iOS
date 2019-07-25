/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


extension String {
    
    func deleteCharactersIn(range: NSRange) -> String {
        let mutableSelf = NSMutableString(string: self)
        mutableSelf.deleteCharacters(in: range)
        return String(mutableSelf)
    }
    
}
