/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


final class TransactionDescriptionCell: UITableViewCell, TransactionCellProtocol {
    
    var isLast: Bool = true
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!
    @IBOutlet private var heightConstraint: NSLayoutConstraint!
    
    private(set) var viewModel: TransactionViewModelProtocol?
    
    var style: TransactionDetailStyleProtocol? {
        didSet {
            applyStyle()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
    }
    
    func bind(viewModel: TransactionViewModelProtocol) {
        guard let model = viewModel as? TransactionDescriptionViewModelProtocol else {
            return
        }
        self.viewModel = model
        
        titleLabel.text = model.title
        
        detailLabel.text = model.description
    }
    
    private func applyStyle() {
        if let style = style {
            titleLabel.textColor = style.title.color
            titleLabel.font = style.title.font
            
            detailLabel.textColor = style.detail.color
            detailLabel.font = style.detail.font
        }
    }
    
}
