/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


final class TransactionDetailCell: UITableViewCell, TransactionCellProtocol {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!
    @IBOutlet private var iconView: UIImageView!
    @IBOutlet private var separator: UIView!
    
    private(set) var viewModel: TransactionViewModelProtocol?
    
    var style: TransactionDetailStyleProtocol? {
        didSet {
            applyStyle()
        }
    }
    
    var isLast: Bool = false {
        didSet {
            separator.isHidden = isLast
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
    }
    
    func bind(viewModel: TransactionViewModelProtocol) {
        guard let model = viewModel as? TransactionDetailViewModelProtocol else {
            return
        }
        self.viewModel = model
        
        titleLabel.text = model.title
        
        detailLabel.text = model.detail
        detailLabel.isHidden = model.detail == nil
        
        iconView.image = model.icon
        iconView.isHidden = model.icon == nil
    }
    
    private func applyStyle() {
        if let style = style {
            titleLabel.textColor = style.title.color
            titleLabel.font = style.title.font
            
            detailLabel.textColor = style.detail.color
            detailLabel.font = style.detail.font
            
            separator.backgroundColor = style.separatorColor
        }
    }
    
}
