/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import UIKit


final class HistoryFilterSelectionCell: UITableViewCell, HistoryFilterViewCellProtocol {
    
    private(set) var selectionModel: HistoryFilterSelectionViewModel?
    private(set) var doneIcon: UIImage?
    
    func applyStyle(_ style: WalletStyleProtocol) {
        doneIcon = style.doneIcon
        selectionStyle = .none
        textLabel?.textColor = style.captionTextColor
        textLabel?.font = style.bodyRegularFont
        detailTextLabel?.textColor = .black
        detailTextLabel?.font = style.bodyRegularFont
    }
    
    var viewModel: WalletViewModelProtocol? {
        return selectionModel
    }
    
    func bind(viewModel: WalletViewModelProtocol) {
        if let viewModel = viewModel as? HistoryFilterSelectionViewModel {
            selectionModel = viewModel
            
            textLabel?.text = viewModel.title
            accessoryView = viewModel.selected ? UIImageView(image: doneIcon) : nil
        }
    }
    
}
