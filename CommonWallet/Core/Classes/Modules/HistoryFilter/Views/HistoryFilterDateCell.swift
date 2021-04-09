/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


final class HistoryFilterDateCell: UITableViewCell {
    
    private var dateModel: HistoryFilterDateViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HistoryFilterDateCell: HistoryFilterViewCellProtocol {
    
    var viewModel: WalletViewModelProtocol? {
        return dateModel
    }
    
    func bind(viewModel: WalletViewModelProtocol) {
        if let viewModel = viewModel as? HistoryFilterDateViewModel {
            dateModel = viewModel
            
            textLabel?.text = viewModel.title
            detailTextLabel?.text = viewModel.dateString
        }
    }
    
    func applyStyle(_ style: WalletStyleProtocol) {
        selectionStyle = .none
        textLabel?.textColor = style.captionTextColor
        textLabel?.font = style.bodyRegularFont
        detailTextLabel?.textColor = .black
        detailTextLabel?.font = style.bodyRegularFont
    }
    
}
