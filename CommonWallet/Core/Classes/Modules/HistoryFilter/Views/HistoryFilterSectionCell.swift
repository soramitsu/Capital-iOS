/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


final class HistoryFilterSectionHeaderCell: UITableViewCell {

    private var headerModel: HistoryFilterSectionViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    private func setup() {
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        selectionStyle = .none
        isUserInteractionEnabled = false
    }
    
}


extension HistoryFilterSectionHeaderCell: HistoryFilterViewCellProtocol {
    
    var viewModel: WalletViewModelProtocol? {
        return headerModel
    }
    
    func bind(viewModel: WalletViewModelProtocol) {
        if let viewModel = viewModel as? HistoryFilterSectionViewModel {
            headerModel = viewModel
            
            textLabel?.text = viewModel.title
        }
    }
    
    func applyStyle(_ style: WalletStyleProtocol) {
        backgroundColor = style.backgroundColor
        textLabel?.textColor = style.captionTextColor
        textLabel?.font = style.bodyRegularFont
    }
    
}
