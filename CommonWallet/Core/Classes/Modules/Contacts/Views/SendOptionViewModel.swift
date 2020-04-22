/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


public typealias SendOptionViewModelFactory = (WalletCommandProtocol) -> SendOptionViewModelProtocol


public protocol SendOptionViewModelProtocol: WalletViewModelProtocol {
    
    var title: String { get }
    var icon: UIImage? { get }
    var style: SendOptionCellStyleProtocol? { get }
    
}


final class SendOptionViewModel: SendOptionViewModelProtocol {
    var cellReuseIdentifier: String
    var itemHeight: CGFloat
    
    var title: String = ""
    var icon: UIImage?
    var style: SendOptionCellStyleProtocol?
    
    var command: WalletCommandProtocol?

    
    init(cellReuseIdentifier: String, itemHeight: CGFloat, command: WalletCommandProtocol) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.command = command
    }
    
}
