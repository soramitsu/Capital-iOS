/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


protocol TransactionCellProtocol {
    
    var style: TransactionDetailStyleProtocol? { get set }
    var isLast: Bool { get set }
    
    func bind(viewModel: TransactionViewModelProtocol)
    
}
