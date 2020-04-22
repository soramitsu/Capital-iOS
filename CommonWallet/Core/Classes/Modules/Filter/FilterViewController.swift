/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraFoundation


struct FilterConstants {
    static let selectableCellIdentifier: String = "jp.co.soramitsu.capital.SelectionCellIdentifier"
    static let dateCellIdentifier: String = "jp.co.soramitsu.capital.DateCellIdentifier"
    static let headerIdentifier = "jp.co.soramitsu.capital.SectionHeaderCellIdentifier"
    static let cellHeight: CGFloat = 54
}


final class FilterViewController: UIViewController {
    
    var presenter: FilterPresenterProtocol!
    
    @IBOutlet private var tableView: UITableView!
    
    private var filter: FilterViewModel = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var style: WalletStyleProtocol? {
        didSet {
            applyStyle()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItems()
        setupTable()
        setupLocalization()
        applyStyle()

        presenter.setup()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        presenter.apply()
    }
    
    private func setupTable() {
        let tableFooterFrame = CGRect(origin: .zero, size: CGSize(width: tableView.bounds.size.width, height: 1.0))
        tableView.tableFooterView = UIView(frame: tableFooterFrame)

        tableView.register(FilterSelectionCell.self, forCellReuseIdentifier: FilterConstants.selectableCellIdentifier)
        tableView.register(FilterDateCell.self, forCellReuseIdentifier: FilterConstants.dateCellIdentifier)
        tableView.register(FilterSectionHeaderCell.self, forCellReuseIdentifier: FilterConstants.headerIdentifier)
    }

    private func setupNavigationItems() {
        let resetButton = UIBarButtonItem(title: L10n.Filter.reset,
                                          style: .plain,
                                          target: self,
                                          action: #selector(resetFilter))

        if let regularFont = style?.bodyRegularFont {
            resetButton.setTitleTextAttributes([.font: regularFont],
                                               for: .normal)
            resetButton.setTitleTextAttributes([.font: regularFont],
                                               for: .highlighted)
        }

        resetButton.tintColor = style?.accentColor

        navigationItem.rightBarButtonItem = resetButton
    }

    private func setupLocalization() {
        navigationItem.title = L10n.Filter.title
        navigationItem.rightBarButtonItem?.title = L10n.Filter.reset
    }
    
    private func applyStyle() {
        if let style = style {
            view.backgroundColor = style.backgroundColor
        }
    }
    
    
    // MARK: Actions
    
    @objc private func resetFilter() {
        presenter.reset()
    }
    
}


extension FilterViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = filter[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellReuseIdentifier)!

        //swiftlint:disable:next force_cast
        let filterCell = cell as! FilterViewCellProtocol
        if let style = style {
            filterCell.applyStyle(style)
        }
        filterCell.bind(viewModel: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return filter[indexPath.row].itemHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)

        try? filter[indexPath.row].command?.execute()
    }
    
}


extension FilterViewController: FilterViewProtocol {
    
    func set(filter: FilterViewModel) {
        self.filter = filter
    }
    
}

extension FilterViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
        }
    }
}
