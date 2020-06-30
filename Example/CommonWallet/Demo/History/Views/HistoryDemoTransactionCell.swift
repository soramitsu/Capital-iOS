/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import CommonWallet

final class HistoryDemoTransactionCell: UITableViewCell {
    private struct Constants {
        static let leadingEmptyImage: CGFloat = 20.0
        static let leadingNonEmptyImage: CGFloat = 10.0
        static let titleFont = UIFont(name: "sora-rc004-0417", size: 14)!
        static let titleColor = UIColor(red: 0.125, green: 0.125, blue: 0.125, alpha: 1)
        static let commentFont = UIFont(name: "sora-rc004-0417-SemiBold", size: 10)!
        static let commentColor = UIColor(red: 0.631, green: 0.631, blue: 0.627, alpha: 1)
    }
    
    private var horizontalStack: UIStackView!
    private var iconView: UIImageView!
    private var icon: UIImage? {
        didSet {
            if let item = icon {
                iconView.image = item
                if iconView.superview == nil {
                    horizontalStack.insertArrangedSubview(iconView, at: 0)
                }
            } else {
                iconView.image = nil
                if iconView.superview != nil {
                    horizontalStack.removeArrangedSubview(iconView)
                }
            }
        }
    }
    private var leftStackView: UIStackView!
    private var titleLabel: UILabel!
    private var purposeLabel: UILabel!
    private var rightStackView: UIStackView!
    private var amountLabel: UILabel!
    private var dateLabel: UILabel!
    
    private(set) var privateViewModel: HistoryDemoTransactionItemViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        privateViewModel = nil
    }
    
    private func configureUI() {
        horizontalStack = UIStackView()
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 10
        horizontalStack.axis = .horizontal
        addSubview(horizontalStack)
        
        iconView = UIImageView()
        iconView.contentMode = .scaleAspectFit
        
        leftStackView = UIStackView()
        leftStackView.axis = .vertical
        leftStackView.distribution = .equalSpacing
        leftStackView.spacing = 2
        horizontalStack.addArrangedSubview(leftStackView)
        
        titleLabel = UILabel()
        titleLabel.font = Constants.titleFont
        titleLabel.textColor = Constants.titleColor
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.addArrangedSubview(titleLabel)
        
        purposeLabel = UILabel()
        purposeLabel.font = Constants.commentFont
        purposeLabel.textColor = Constants.commentColor
        purposeLabel.translatesAutoresizingMaskIntoConstraints = false
        leftStackView.addArrangedSubview(purposeLabel)
        
        rightStackView = UIStackView()
        rightStackView.axis = .vertical
        rightStackView.alignment = .trailing
        rightStackView.distribution = .equalSpacing
        rightStackView.spacing = 2
        horizontalStack.addArrangedSubview(rightStackView)
        
        amountLabel = UILabel()
        amountLabel.font = Constants.titleFont
        amountLabel.textColor = Constants.titleColor
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.addArrangedSubview(amountLabel)
        
        dateLabel = UILabel()
        dateLabel.font = Constants.commentFont
        dateLabel.textColor = Constants.commentColor
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        rightStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupConstraints() {
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        horizontalStack.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        horizontalStack.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    }
    
    private func updateContent() {
        icon = privateViewModel?.icon
        titleLabel.text = privateViewModel?.title
        purposeLabel.text = privateViewModel?.purpose
        amountLabel.text = privateViewModel?.amount
        dateLabel.text = privateViewModel?.date
    }
}

extension HistoryDemoTransactionCell: WalletViewProtocol {
    
    var viewModel: WalletViewModelProtocol? {
        return privateViewModel
    }
    

    func bind(viewModel: WalletViewModelProtocol) {
        defer {
            updateContent()
        }
        guard let item = viewModel as? HistoryDemoTransactionItemViewModel else {
            self.privateViewModel = nil
            return
        }
        self.privateViewModel = item
    }
    
}
