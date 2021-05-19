/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI
import SoraFoundation


final class ContactsViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var headerView: UIView!
    @IBOutlet private var searchField: UITextField!
    @IBOutlet private var searchFieldBackgroundView: RoundedView!
    @IBOutlet private var searchBorderView: BorderedContainerView!
    @IBOutlet private var contentView: UIView!

    private lazy var searchActivityIndicatory: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.color = configuration?.viewStyle.searchIndicatorStyle
        return activityIndicator
    }()

    var presenter: ContactsPresenterProtocol!
    var configuration: ContactsConfigurationProtocol?
    var style: WalletStyleProtocol?
        
    private var contactsViewModel: ContactListViewModelProtocol = ContactListViewModel() {
        didSet {
            tableView.reloadData()
        }
    }

    private var barViewModel: WalletBarActionViewModelProtocol?

    private var configurationDelegate: EmptyStateDelegate? {
        switch contactsViewModel.state {
        case .full:
            return configuration?.contactsEmptyStateDelegate
        case .search:
            return configuration?.searchEmptyStateDelegate
        }
    }

    private var configurationDataSource: EmptyStateDataSource? {
        switch contactsViewModel.state {
        case .full:
            return configuration?.contactsEmptyStateDataSource
        case .search:
            return configuration?.searchEmptyStateDataSource
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupLocalization()
        applyStyle()
        
        presenter.setup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        searchField.resignFirstResponder()
    }
    
    private func setupTableView() {
        guard let configuration = configuration else {
            return
        }

        if !configuration.sectionStyle.displaysSeparatorForLastCell {
            tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 1.0))
        }

        configuration.registeredCellMetadata?.forEach { (reuseIdentifier, metadata) in
            if let cellClass = metadata as? UITableViewCell.Type {
                tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
            }

            if let nib = metadata as? UINib {
                tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
            }
        }
    }

    private func setupLocalization() {
        title = L10n.Contacts.moduleTitle

        let locale = localizationManager?.selectedLocale ?? Locale.current

        if let placeholder = configuration?.searchPlaceholder.value(for: locale) {

            if let style = configuration?.viewStyle {
                let attributes: [NSAttributedString.Key: Any] = [
                    NSAttributedString.Key.foregroundColor: style.searchPlaceholderStyle.color,
                    NSAttributedString.Key.font: style.searchPlaceholderStyle.font
                ]
                let attributedString = NSAttributedString(string: placeholder,
                                                          attributes: attributes)
                searchField.attributedPlaceholder = attributedString
            } else {
                searchField.placeholder = placeholder
            }
        }
    }
    
    private func applyStyle() {
        if let style = configuration?.viewStyle {
            view.backgroundColor = style.backgroundColor
            headerView.backgroundColor = style.searchHeaderBackgroundColor
            searchFieldBackgroundView.fillColor = style.searchFieldStyle.fill

            if let searchStroke = style.searchFieldStyle.stroke {
                searchFieldBackgroundView.strokeColor = searchStroke.color
                searchFieldBackgroundView.strokeWidth = searchStroke.lineWidth
            }

            if let cornerRadius = style.searchFieldStyle.cornerRadius {
                searchFieldBackgroundView.cornerRadius = cornerRadius
            }

            searchField.font = style.searchTextStyle.font
            searchField.textColor = style.searchTextStyle.color
            searchBorderView.strokeColor = style.searchSeparatorColor
            tableView.separatorColor = style.tableSeparatorColor
        }

        if let caretColor = style?.caretColor {
            searchField.tintColor = caretColor
        }
    }

    // MARK: Action

    @objc private func actionRightBarButtonItem() {
        try? barViewModel?.command.execute()
    }
}


extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactsViewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsViewModel.numberOfItems(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = contactsViewModel[indexPath]!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellReuseIdentifier,
                                                 for: indexPath)
        
        // swiftlint:disable:next force_cast
        let contactCell = cell as! WalletViewProtocol

        if var stylableCell = cell as? ContactsCellStylable, stylableCell.style == nil {
            stylableCell.style = configuration?.cellStyle
        }

        contactCell.bind(viewModel: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = contactsViewModel[indexPath]!
        
        return viewModel.itemHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        try? contactsViewModel[indexPath]?.command?.execute()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let title = contactsViewModel.title(for: section) else {
            return nil
        }
        
        guard let header = UINib(nibName: "ContactSectionHeader", bundle: Bundle(for: type(of: self)))
            .instantiate(withOwner: nil, options: nil).first as? ContactSectionHeader else {
            return nil
        }

        header.style = configuration?.sectionStyle
        header.backgroundColor = configuration?.viewStyle.backgroundColor
        header.set(title: title)
        
        return header
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard section < tableView.numberOfSections - 1 else {
            return nil
        }

        let separatorWidth = configuration?.viewStyle.actionsSeparator.lineWidth ?? 0.0

        guard separatorWidth > 0.0 else {
            return nil
        }

        let footerView = UINib(nibName: "SeparatorSectionView", bundle: Bundle(for: type(of: self)))
            .instantiate(withOwner: nil, options: nil).first as? SeparatorSectionView
        footerView?.style = configuration?.viewStyle.actionsSeparator

        return footerView
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard section < tableView.numberOfSections - 1 else {
            return 0.0
        }

        return configuration?.viewStyle.actionsSeparator.lineWidth ?? 0.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard contactsViewModel.title(for: section) != nil else {
            return 0
        }
        
        return configuration?.sectionStyle.height ?? 0.0
    }
    
}


extension ContactsViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        guard configuration?.supportsLiveSearch == true, let text = textField.text as NSString? else  {
            return true
        }

        let newString = text.replacingCharacters(in: range, with: string)
        presenter.search(newString)
        
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        presenter.search("")

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        guard configuration?.supportsLiveSearch != true, let text = textField.text else  {
            return false
        }

        presenter.search(text)

        return false
    }
}


extension ContactsViewController: ContactsViewProtocol {

    func set(listViewModel: ContactListViewModelProtocol) {
        contactsViewModel = listViewModel
        reloadEmptyState(animated: false)
    }

    func set(barViewModel: WalletBarActionViewModelProtocol) {
        self.barViewModel = barViewModel

        let barButtonItem: UIBarButtonItem

        switch barViewModel.displayType {
        case .icon(let image):
            barButtonItem = UIBarButtonItem(image: image,
                                            style: .plain,
                                            target: self,
                                            action: #selector(actionRightBarButtonItem))
        case .title(let title):
            barButtonItem = UIBarButtonItem(title: title,
                                            style: .plain,
                                            target: self,
                                            action: #selector(actionRightBarButtonItem))
        }

        navigationItem.rightBarButtonItem = barButtonItem
    }

    func didStartSearch() {
        searchField.rightViewMode = .always
        searchField.rightView = searchActivityIndicatory
        searchActivityIndicatory.startAnimating()
    }

    func didStopSearch() {
        searchActivityIndicatory.stopAnimating()
        searchField.rightView = nil
    }

}

extension ContactsViewController: WalletDesignableBar {
    var shadowType: WalletBarShadowType {
        return .empty
    }
}

extension ContactsViewController: EmptyStateDelegate {
    var shouldDisplayEmptyState: Bool {
        guard contactsViewModel.isEmpty, contactsViewModel.shouldDisplayEmptyState else {
            return false
        }

        let hasDataSource = (configurationDataSource != nil)
        return configurationDelegate?.shouldDisplayEmptyState ?? hasDataSource
    }
}

extension ContactsViewController: EmptyStateDataSource {
    var viewForEmptyState: UIView? {
        return nil
    }

    var contentViewForEmptyState: UIView {
        return contentView
    }

    var imageForEmptyState: UIImage? {
        return configurationDataSource?.imageForEmptyState
    }

    var titleForEmptyState: String? {
        return configurationDataSource?.titleForEmptyState
    }

    var titleColorForEmptyState: UIColor? {
        return configurationDataSource?.titleColorForEmptyState
    }

    var titleFontForEmptyState: UIFont? {
        return configurationDataSource?.titleFontForEmptyState
    }

    var verticalSpacingForEmptyState: CGFloat? {
        return configurationDataSource?.verticalSpacingForEmptyState
    }

    var trimStrategyForEmptyState: EmptyStateView.TrimStrategy {
        return configurationDataSource?.trimStrategyForEmptyState ?? .none
    }
}

extension ContactsViewController: EmptyStateViewOwnerProtocol {
    var emptyStateDelegate: EmptyStateDelegate {
        return self
    }

    var emptyStateDataSource: EmptyStateDataSource {
        return self
    }

    var displayInsetsForEmptyState: UIEdgeInsets {
        return .zero
    }
}

extension ContactsViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
            reloadEmptyState(animated: false)

            view.setNeedsLayout()
        }
    }
}
