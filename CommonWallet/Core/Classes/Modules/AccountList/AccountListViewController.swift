/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI

final class AccountListViewController: UIViewController, AdaptiveDesignable {
    var presenter: AccountListPresenterProtocol!

    var configuration: AccountListConfigurationProtocol?

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var backgroundImageView: UIImageView!

    private lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(actionReload), for: .valueChanged)
        return control
    }()

    private var viewModels: [WalletViewModelProtocol] = []
    private var collapsingRange: Range<Int> = 0..<0
    private var expanded: Bool = false
    private var didCompleteLoad: Bool = false

    private var collapsingRangeLength: Int {
        return collapsingRange.upperBound - collapsingRange.lowerBound
    }
    
    var observable = WalletViewModelObserverContainer<ContainableObserver>()

    weak var reloadableDelegate: ReloadableDelegate?

    var contentInsets: UIEdgeInsets = .zero

    lazy var preferredContentHeight: CGFloat = configuration?.minimumContentHeight ?? 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()

        presenter.setup()
        didCompleteLoad = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.viewDidAppear()
    }

    private func configure() {
        view.backgroundColor = .clear

        configueCollectionView()
        configureStyle()
    }

    private func configureStyle() {
        if let style = configuration?.viewStyle {
            refreshControl.tintColor = style.refreshIndicatorStyle
            backgroundImageView.image = style.backgroundImage
        }
    }

    private func configueCollectionView() {
        if #available(iOS 10.0, *) {
            collectionView.refreshControl = refreshControl
        } else {
            collectionView.addSubview(refreshControl)
        }

        configuration?.registeredCellsMetadata.forEach { (reuseIdentifier, metadata) in
            if let cellClass = metadata as? UICollectionViewCell.Type {
                self.collectionView.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
            }

            if let nib = metadata as? UINib {
                self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
            }
        }
    }

    private func updateCollectionViewInsets(animated: Bool) {
        let isRefreshing = refreshControl.isRefreshing

        if isRefreshing {
            refreshControl.endRefreshing()
        }

        let visibleContentHeight = collectionView.bounds.height - contentInsets.top - contentInsets.bottom
        let scrollable = preferredContentHeight > visibleContentHeight
        let scrolled = collectionView.contentOffset.y > -contentInsets.top

        collectionView.contentInset = contentInsets

        if animated, !scrollable, scrolled {
            collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x, y: -contentInsets.top),
                                            animated: true)
        }

        if isRefreshing {
            refreshControl.beginRefreshing()
        }
    }

    private func createContentHeight(from viewModels: [WalletViewModelProtocol],
                                     isExpanded: Bool,
                                     collapsingRange: Range<Int>) -> CGFloat {
        var height: CGFloat = 0.0

        for (index, model) in viewModels.enumerated() {
            if isExpanded || !collapsingRange.contains(index) {
                height += model.itemHeight
            }
        }

        let minimumContentHeight = configuration?.minimumContentHeight ?? 0.0

        return max(height, minimumContentHeight)
    }

    private func adjustedRow(for index: Int) -> Int {
        var row = index

        if !expanded && row >= collapsingRange.lowerBound {
            row += collapsingRangeLength
        }

        return row
    }

    // MARK: Actions

    @objc func actionReload() {
        presenter.reload()

        reloadableDelegate?.didInitiateReload(on: self)
    }
}

extension AccountListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let totalCount = viewModels.count
        return expanded ? totalCount : totalCount - collapsingRangeLength
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = adjustedRow(for: indexPath.row)
        let viewModel = viewModels[row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellReuseIdentifier,
                                                      for: indexPath)

        //swiftlint:disable:next force_cast
        let walletCell = cell as! WalletViewProtocol
        walletCell.bind(viewModel: viewModel)

        return cell
    }
}

extension AccountListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        let row = adjustedRow(for: indexPath.row)
        try? viewModels[row].command?.execute()
    }
}

extension AccountListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let row = adjustedRow(for: indexPath.row)
        let itemHeight = viewModels[row].itemHeight
        return CGSize(width: collectionView.bounds.width, height: itemHeight)
    }
}

extension AccountListViewController: AccountListViewProtocol {
    func didLoad(viewModels: [WalletViewModelProtocol], collapsingRange: Range<Int>) {
        observable.observers.forEach {
            $0.observer?.willChangePreferredContentHeight()
        }

        if didCompleteLoad {
            collectionView.performBatchUpdates({
                self.viewModels = viewModels
                self.collapsingRange = collapsingRange
                collectionView.reloadSections([0])
            }, completion: nil)
        } else {
            self.viewModels = viewModels
        }

        preferredContentHeight = createContentHeight(from: viewModels,
                                                     isExpanded: expanded,
                                                     collapsingRange: collapsingRange)

        observable.observers.forEach {
            $0.observer?.didChangePreferredContentHeight(to: preferredContentHeight)
        }
    }

    func didCompleteReload() {
        refreshControl.endRefreshing()
    }

    func set(expanded: Bool, animated: Bool) {
        observable.observers.forEach {
            $0.observer?.willChangePreferredContentHeight()
        }

        collectionView.performBatchUpdates({
            if self.expanded == expanded {
                return
            }

            self.expanded = expanded

            guard self.collapsingRangeLength > 0 else {
                return
            }

            if animated {
                let indexPaths = self.collapsingRange.map { IndexPath(row: $0, section: 0) }

                if expanded {
                    self.collectionView.insertItems(at: indexPaths)
                } else {
                    self.collectionView.deleteItems(at: indexPaths)
                }
            } else {
                self.collectionView.reloadSections([0])
            }
        }, completion: nil)

        preferredContentHeight = createContentHeight(from: viewModels,
                                                     isExpanded: expanded,
                                                     collapsingRange: collapsingRange)

        observable.observers.forEach {
            $0.observer?.didChangePreferredContentHeight(to: preferredContentHeight)
        }
    }
}

extension AccountListViewController: Containable {
    var contentView: UIView {
        return view
    }

    func setContentInsets(_ contentInsets: UIEdgeInsets, animated: Bool) {
        self.contentInsets = contentInsets
        updateCollectionViewInsets(animated: true)
    }
}

extension AccountListViewController: Reloadable {
    func reload() {
        presenter.reload()
    }
}
