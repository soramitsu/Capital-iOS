/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI


final class ContactsViewController: UIViewController {
    
    private struct Constants {
        static let headerHeight: CGFloat = 55.0
    }
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var headerView: UIView!
    @IBOutlet private var searchField: UITextField!
    @IBOutlet private var searchFieldBackgroundView: RoundedView!
    @IBOutlet private var searchBorderView: BorderedContainerView!

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
        
        setupDismiss()
        setupSearchField()
        setupTableView()
        applyStyle()
        
        presenter.setup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        searchField.resignFirstResponder()
    }
    
    private func setupDismiss() {
        let dismissItem = UIBarButtonItem(image: configuration?.viewStyle.closeIcon,
                                          style: .plain,
                                          target: self,
                                          action: #selector(close))
        self.navigationItem.leftBarButtonItem = dismissItem
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: view.bounds.width, height: 1.0))

        let bundle = Bundle(for: type(of: self))
        var nib = UINib(nibName: "ContactCell", bundle: bundle)
        
        tableView.register(nib, forCellReuseIdentifier: ContactConstants.contactCellIdentifier)

        nib = UINib(nibName: "ScanCodeCell", bundle: bundle)
        
        tableView.register(nib, forCellReuseIdentifier: ContactConstants.scanCellIdentifier)
    }

    private func setupSearchField() {
        searchField.placeholder = configuration?.searchPlaceholder
    }
    
    private func applyStyle() {
        if let style = configuration?.viewStyle {
            view.backgroundColor = style.backgroundColor
            headerView.backgroundColor = style.searchHeaderBackgroundColor
            searchFieldBackgroundView.fillColor = style.searchFieldColor
            searchField.font = style.searchTextStyle.font
            searchField.textColor = style.searchTextStyle.color
        }

        if let style = configuration?.contactCellStyle {
            searchBorderView.strokeColor = style.separatorColor
            tableView.separatorColor = style.separatorColor
        }

        if let caretColor = style?.caretColor {
            searchField.tintColor = caretColor
        }
    }
    
    @objc private func close() {
        presenter.dismiss()
    }

}


extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactsViewModel.sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsViewModel.itemsCount(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = contactsViewModel[indexPath]!
        
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellReuseIdentifier,
                                                 for: indexPath)
        
        //swiftlint:disable:next force_cast
        let contactCell = cell as! WalletViewProtocol
        contactCell.bind(viewModel: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let viewModel = contactsViewModel[indexPath]!
        
        return viewModel.itemHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contactsViewModel[indexPath]!.didSelect()
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard contactsViewModel.title(for: section) != nil else {
            return 0
        }
        
        return Constants.headerHeight
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

    func set(viewModel: ContactListViewModelProtocol) {
        contactsViewModel = viewModel
        reloadEmptyState(animated: false)
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
        return view
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
        let topInset: CGFloat = contactsViewModel.actions.reduce(0.0) { (result, action) -> CGFloat in
            return result + action.itemHeight
        }

        return UIEdgeInsets(top: 2.0 * topInset + Constants.headerHeight,
                            left: 0.0, bottom: 0.0, right: 0.0)
    }
}

