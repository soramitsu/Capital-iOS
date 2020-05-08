/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI
import SoraFoundation


final class WalletFormViewController: UIViewController, AdaptiveDesignable {
    private struct Constants {
        static let itemCellNibName: String = "WalletFormItemCell"
        static let itemCellIdentifier: String = "itemCellIdentifier"
        static let detailsCellNibName: String = "WalletFormDetailsCell"
        static let detailsCellIdentifier: String = "detailsCellIdentifier"
    }

    var presenter: WalletFormPresenterProtocol!

    var style: WalletStyleProtocol?

    var accessoryViewFactory: AccessoryViewFactoryProtocol.Type?
    var accessoryView: AccessoryViewProtocol?

    @IBOutlet private var tableView: UITableView!

    var localizableTitle: LocalizableResource<String>?

    private(set) var models: [WalletFormViewModelProtocol] = []
    private(set) var heights: [CGFloat] = []
    private var preferredWidth: CGFloat {
        return 375.0 * designScaleRatio.width
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()

        configureStyle()

        setupLocalization()

        presenter.setup()
    }

    private func reuseIdentifier(for layoutType: WalletFormLayoutType) -> String {
        switch layoutType {
        case .accessory:
            return Constants.itemCellIdentifier
        case .details:
            return Constants.detailsCellIdentifier
        }
    }

    private func nibName(for layoutType: WalletFormLayoutType) -> String {
        switch layoutType {
        case .accessory:
            return Constants.itemCellNibName
        case .details:
            return Constants.detailsCellNibName
        }
    }

    private func configureTableView() {
        let tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0,
                                                   width: view.bounds.width, height: 1.0))
        tableView.tableFooterView = tableFooterView

        let bundle = Bundle(for: WalletFormViewController.self)

        WalletFormLayoutType.allCases.forEach { (type) in
            tableView.register(UINib(nibName: nibName(for: type), bundle: bundle),
                               forCellReuseIdentifier: reuseIdentifier(for: type))
        }
    }

    private func adjustContentInsets() {
        var contentInset = tableView.contentInset
        contentInset.bottom = accessoryView?.contentView.frame.height ?? 0.0
        tableView.contentInset = contentInset
    }

    private func configureStyle() {
        if let style = style {
            view.backgroundColor = style.backgroundColor
            tableView.separatorColor = style.formCellStyle.separator
        }
    }

    private func setupLocalization() {
        if let localizableTitle = localizableTitle {
            let locale = localizationManager?.selectedLocale ?? Locale.current
            title = localizableTitle.value(for: locale)
        }
    }

    private func setupAccessoryViewIfNeeded() {
        guard accessoryView == nil, let style = style else {
            return
        }

        let optionalView = accessoryViewFactory?.createAccessoryView(from: .titleIconActionBar,
                                                                     style: style.accessoryStyle, target: self,
                                                                     completionSelector: #selector(performAction))

        if let contentView = optionalView?.contentView {
            contentView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(contentView)

            if #available(iOS 11.0, *) {
                contentView.bottomAnchor
                    .constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0.0).isActive = true
            } else {
                contentView.bottomAnchor
                    .constraint(equalTo: view.bottomAnchor, constant: 0.0).isActive = true
            }

            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: 0.0).isActive = true

            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                  constant: 0.0).isActive = true

            contentView.heightAnchor.constraint(equalToConstant: contentView.frame.size.height).isActive = true

            accessoryView = optionalView
        }
    }

    func clearAccessoryView() {
        accessoryView?.contentView.removeFromSuperview()
        accessoryView = nil
    }

    private func rebuildHeights(cellStyle: WalletFormCellStyleProtocol) {
        heights = models.map { (model) in
            switch model.layoutType {
            case .accessory:
                return WalletFormItemCell.calculateHeight(for: model,
                                                          style: cellStyle,
                                                          preferredWidth: preferredWidth)
            case .details:
                return WalletFormDetailsCell.calculateHeight(for: model,
                                                             style: cellStyle,
                                                             preferredWidth: preferredWidth)
            }
        }
    }

    @objc private func performAction() {
        presenter.performAction()
    }
}


extension WalletFormViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    //swiftlint:disable force_cast
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier(for: models[indexPath.row].layoutType),
                                                 for: indexPath) as! (UITableViewCell & WalletFormCellProtocol)

        if cell.style == nil, let currentStyle = style {
            cell.style = currentStyle.formCellStyle
        }

        cell.bind(viewModel: models[indexPath.row])

        return cell
    }
    //swiftlint:enable force_cast
}

extension WalletFormViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.row]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        if let command = models[indexPath.row].command {
            try? command.execute()
        }
    }
}

extension WalletFormViewController: WalletFormViewProtocol {
    func didReceive(viewModels: [WalletFormViewModelProtocol]) {
        if let cellStyle = style?.formCellStyle {
            self.models = viewModels
            rebuildHeights(cellStyle: cellStyle)
            tableView.reloadData()
        }
    }

    func didReceive(accessoryViewModel: AccessoryViewModelProtocol?) {
        if let viewModel = accessoryViewModel {
            setupAccessoryViewIfNeeded()
            accessoryView?.bind(viewModel: viewModel)
        } else {
            clearAccessoryView()
        }

        adjustContentInsets()
    }
}

extension WalletFormViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
        }
    }
}
