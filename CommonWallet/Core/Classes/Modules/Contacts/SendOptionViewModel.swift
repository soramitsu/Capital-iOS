/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public protocol SendOptionViewModelProtocol: WalletViewModelProtocol {
    
    var title: String { get }
    var icon: UIImage? { get }
    
}

public extension SendOptionViewModelProtocol {
    var cellReuseIdentifier: String { ContactConstants.optionCellIdentifier }
    var itemHeight: CGFloat { ContactConstants.optionCellHeight }
}


final class SendOptionViewModel: SendOptionViewModelProtocol {
    var title: String = ""
    var icon: UIImage?
    
    var command: WalletCommandProtocol?

    
    init(command: WalletCommandProtocol) {
        self.command = command
    }
}
