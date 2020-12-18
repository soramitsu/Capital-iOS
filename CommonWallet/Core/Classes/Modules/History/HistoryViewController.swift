/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI
import RobinHood
import SoraFoundation


private struct NavigationItemState {
    var title: String?
    var leftBarItem: UIBarButtonItem?
    var rightBarItem: UIBarButtonItem?
}

final class HistoryViewController: UIViewController {
    private struct Constants {
        static let sectionNibName = "SeparatedSectionView"
        static let headerHeight: CGFloat = 45.0
        static let sectionHeight: CGFloat = 44.0
        static let compactTitleLeft: CGFloat = 20.0
        static let multiplierToActivateNextLoading: CGFloat = 1.5
        static let draggableProgressStart: Double = 0.0
        static let draggableProgressFinal: Double = 1.0
        static let triggerProgressThreshold: Double = 0.8
        static let loadingViewMargin: CGFloat = 4.0
        static let bouncesThreshold: CGFloat = 1.0
    }

    var presenter: HistoryPresenterProtocol!
    var configuration: HistoryConfigurationProtocol?

    var headerType: HistoryHeaderType = .bar

    lazy var statusStyleProvider = HistoryStatusStyleProvider()
    
    @IBOutlet private var filterButton: UIButton!
    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var titleLeft: NSLayoutConstraint!
    @IBOutlet private var headerView: UIView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var panIndicatorView: RoundedView!
    @IBOutlet private var headerTop: NSLayoutConstraint!
    @IBOutlet private var headerHeight: NSLayoutConstraint!

    private var backgroundView: BaseHistoryBackgroundView!

    private var draggableState: DraggableState = .compact
    private var compactInsets: UIEdgeInsets = .zero {
        didSet {
            if compactInsets != oldValue {
                updateEmptyStateInsets()
            }
        }
    }

    private var fullInsets: UIEdgeInsets = .zero

    private var pageLoadingView: PageLoadingView!

    weak var delegate: DraggableDelegate?

    weak var reloadableDelegate: ReloadableDelegate?

    private var previousNavigationItemState: NavigationItemState?

    /**
     *  Property is used to avoid forcing layout updates in case layout system is not setup. Otherwise it may cause
     *  wrong calculations in UITableView.
     */
    private var didSetupLayout: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configureBackgroundViewIfNeeded()
        configureFilter()
        configureTableView()
        configureStyle()
        update(for: draggableState, progress: Constants.draggableProgressFinal, forcesLayoutUpdate: false)
        updateTableViewAfterTransition(to: draggableState, animated: false)
        applyContentInsets(for: draggableState)
        
        setupLocalization()

        presenter.setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.reloadCache()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        didSetupLayout = true
    }

    private func configureBackgroundViewIfNeeded() {
        backgroundView = configuration?.viewFactoryOverriding?
            .createBackgroundView() ?? HistoryBackgroundView()

        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundView, at: 0)

        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

        if let height = configuration?.backgroundHeight {
            backgroundView.heightAnchor.constraint(equalToConstant: height).isActive = true
        } else {
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        }
    }

    private func configureStyle() {
        if let viewStyle = configuration?.viewStyle {
            backgroundView.apply(style: viewStyle)

            titleLabel.textColor = viewStyle.titleStyle.color
            titleLabel.font = viewStyle.titleStyle.font

            if let filterIcon = viewStyle.filterIcon {
                filterButton.setImage(filterIcon, for: .normal)
            }

            if let closeIcon = viewStyle.closeIcon {
                closeButton.setImage(closeIcon, for: .normal)
            }

            panIndicatorView.fillColor = viewStyle.panIndicatorStyle
        }

        if let cellStyle = configuration?.cellStyle {
            tableView.separatorColor = cellStyle.separatorColor
        }
    }

    private func setupLocalization() {
        if let localizableTitle = configuration?.localizableTitle {
            let locale = localizationManager?.selectedLocale ?? Locale.current
            titleLabel.text = localizableTitle.value(for: locale)
        } else {
            titleLabel.text = L10n.History.title
        }
    }

    private func configureFilter() {
        if let configuration = configuration {
            filterButton.isHidden = !configuration.supportsFilter
        }
    }

    private func configureTableView() {
        configuration?.registeredCellsMetadata.forEach { (reuseIdentifier, metadata) in
            if let cellClass = metadata as? UITableViewCell.Type {
                tableView.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
            }

            if let nib = metadata as? UINib {
                tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
            }
        }

        pageLoadingView = PageLoadingView()
        pageLoadingView.verticalMargin = Constants.loadingViewMargin
        let size = pageLoadingView.intrinsicContentSize
        pageLoadingView.frame = CGRect(origin: .zero, size: size)

        tableView.tableFooterView = pageLoadingView
    }

    fileprivate func update(for draggableState: DraggableState, progress: Double, forcesLayoutUpdate: Bool) {
        updateContent(for: draggableState, progress: progress, forcesLayoutUpdate: forcesLayoutUpdate)
        updateHeaderHeight(for: draggableState, progress: progress, forcesLayoutUpdate: forcesLayoutUpdate)
    }

    fileprivate func updateContent(for draggableState: DraggableState, progress: Double, forcesLayoutUpdate: Bool) {
        switch headerType {
        case .bar:
            updateBarTypeContent(for: draggableState, progress: progress, forcesLayoutUpdate: forcesLayoutUpdate)
        case .hidden:
            updateHiddenTypeContent(for: draggableState, progress: progress, forcesLayoutUpdate: forcesLayoutUpdate)
        }
    }

    fileprivate func updateBarTypeContent(for draggableState: DraggableState,
                                          progress: Double,
                                          forcesLayoutUpdate: Bool) {
        let titleFullPosition = headerView.bounds.midX - titleLabel.intrinsicContentSize.width / 2.0
        let titleCompactPosition = Constants.compactTitleLeft

        switch draggableState {
        case .compact:
            let adjustedProgress = min(progress / (1.0 - Constants.triggerProgressThreshold), 1.0)

            backgroundView.applyFullscreen(progress: CGFloat(adjustedProgress))
            closeButton.alpha = CGFloat(1.0 - adjustedProgress)
            panIndicatorView.alpha = CGFloat(adjustedProgress)

            let titleProgress = CGFloat(1.0 - adjustedProgress) * (titleFullPosition - titleCompactPosition)
            titleLeft.constant = titleCompactPosition + titleProgress

            if progress > 0.0 {
                tableView.isScrollEnabled = false
            }

        case .full:
            let adjustedProgress = max(progress - Constants.triggerProgressThreshold, 0.0)
                / (1.0 - Constants.triggerProgressThreshold)

            backgroundView.applyFullscreen(progress: CGFloat(1.0 - adjustedProgress))
            closeButton.alpha = CGFloat(adjustedProgress)
            panIndicatorView.alpha = CGFloat(1.0 - adjustedProgress)

            let titleProgress = CGFloat(adjustedProgress) * (titleFullPosition - titleCompactPosition)
            titleLeft.constant = titleCompactPosition + titleProgress
        }

        if forcesLayoutUpdate {
            view.layoutIfNeeded()
        }
    }

    fileprivate func updateHiddenTypeContent(for draggableState: DraggableState,
                                             progress: Double,
                                             forcesLayoutUpdate: Bool) {
        switch draggableState {
        case .compact:
            let adjustedProgress = min(progress / (1.0 - Constants.triggerProgressThreshold), 1.0)

            backgroundView.applyFullscreen(progress: CGFloat(adjustedProgress))
            closeButton.alpha = 0.0
            headerView.alpha = CGFloat(adjustedProgress)
            panIndicatorView.alpha = CGFloat(adjustedProgress)

            if progress > 0.0 {
                tableView.isScrollEnabled = false
            }
        case .full:
            let adjustedProgress = max(progress - Constants.triggerProgressThreshold, 0.0)
                / (1.0 - Constants.triggerProgressThreshold)

            backgroundView.applyFullscreen(progress: CGFloat(1.0 - adjustedProgress))
            closeButton.alpha = 0.0
            headerView.alpha = CGFloat(1.0 - adjustedProgress)
            panIndicatorView.alpha = CGFloat(1.0 - adjustedProgress)
        }

        if forcesLayoutUpdate {
            view.layoutIfNeeded()
        }
    }

    fileprivate func updateTableViewAfterTransition(to state: DraggableState, animated: Bool) {
        switch state {
        case .compact:
            tableView.setContentOffset(.zero, animated: animated)
            tableView.showsVerticalScrollIndicator = false
        case .full:
            tableView.isScrollEnabled = true
        }
    }

    private func updateHeaderHeight(for draggableState: DraggableState, progress: Double, forcesLayoutUpdate: Bool) {
        switch headerType {
        case .bar:
            updateBarTypeHeaderHeight(for: draggableState,
                                      progress: progress,
                                      forcesLayoutUpdate: forcesLayoutUpdate)
        case .hidden:
            updateHiddenTypeHeaderHeight(for: draggableState,
                                         progress: progress,
                                         forcesLayoutUpdate: forcesLayoutUpdate)
        }
    }

    private func updateBarTypeHeaderHeight(for draggableState: DraggableState,
                                           progress: Double,
                                           forcesLayoutUpdate: Bool) {
        let cornerRadius = configuration?.viewStyle.cornerRadius ?? 0.0

        switch draggableState {
        case .compact:
            let adjustedProgress = min(progress / (1.0 - Constants.triggerProgressThreshold), 1.0)

            headerTop.constant = CGFloat(1.0 - adjustedProgress) * (fullInsets.top - cornerRadius) + cornerRadius
        case .full:
            let adjustedProgress = max(progress - Constants.triggerProgressThreshold, 0.0)
                / (1.0 - Constants.triggerProgressThreshold)

            headerTop.constant = CGFloat(adjustedProgress) * (fullInsets.top - cornerRadius) + cornerRadius
        }

        if forcesLayoutUpdate {
            view.layoutIfNeeded()
        }
    }

    private func updateHiddenTypeHeaderHeight(for draggableState: DraggableState,
                                              progress: Double,
                                              forcesLayoutUpdate: Bool) {
        let cornerRadius = configuration?.viewStyle.cornerRadius ?? 0.0

        switch draggableState {
        case .compact:
            let adjustedProgress = min(progress / (1.0 - Constants.triggerProgressThreshold), 1.0)

            headerTop.constant = CGFloat(1.0 - adjustedProgress) * (fullInsets.top - cornerRadius) + cornerRadius
            headerHeight.constant = Constants.headerHeight * CGFloat(adjustedProgress) +
                fullInsets.top * CGFloat(1.0 - adjustedProgress)
        case .full:
            let adjustedProgress = max(progress - Constants.triggerProgressThreshold, 0.0)
                / (1.0 - Constants.triggerProgressThreshold)

            headerTop.constant = CGFloat(1.0 - adjustedProgress) * (fullInsets.top - cornerRadius) + cornerRadius
            headerHeight.constant = Constants.headerHeight * CGFloat(1.0 - adjustedProgress) +
                fullInsets.top * CGFloat(adjustedProgress)
        }

        if forcesLayoutUpdate {
            view.layoutIfNeeded()
        }
    }

    private func setupNavigationItemTitle(_ item: UINavigationItem) {
        if let localizableTitle = configuration?.localizableTitle {
            let locale = localizationManager?.selectedLocale ?? Locale.current
            item.title = localizableTitle.value(for: locale)
        } else {
            item.title = L10n.History.title
        }
    }

    private func updateHiddenTypeNavigationItem(for state: DraggableState, animated: Bool) {
        guard
            let navigationItem = delegate?.presentationNavigationItem,
            let configuration = configuration else {
            return
        }

        switch state {
        case .compact:
            if let state = previousNavigationItemState {
                navigationItem.title = state.title
                navigationItem.leftBarButtonItem = state.leftBarItem
                navigationItem.rightBarButtonItem = state.rightBarItem

                previousNavigationItemState = nil
            }
        case .full:
            if previousNavigationItemState == nil {
                previousNavigationItemState = NavigationItemState(title: navigationItem.title,
                                                                  leftBarItem: navigationItem.leftBarButtonItem,
                                                                  rightBarItem: navigationItem.rightBarButtonItem)

                setupNavigationItemTitle(navigationItem)

                let closeBarItem = UIBarButtonItem(image: configuration.viewStyle.closeIcon,
                                                   style: .plain,
                                                   target: self,
                                                   action: #selector(actionsClose))
                navigationItem.setLeftBarButton(closeBarItem, animated: true)

                if configuration.supportsFilter {
                    let filterItem = UIBarButtonItem(image: configuration.viewStyle.filterIcon,
                                                     style: .plain,
                                                     target: self,
                                                     action: #selector(showFilter))
                    navigationItem.setRightBarButton(filterItem, animated: true)
                }
            }

        }
    }

    fileprivate func applyContentInsets(for draggableState: DraggableState) {
        switch draggableState {
        case .compact:
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: compactInsets.bottom, right: 0.0)
        default:
            tableView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: fullInsets.bottom, right: 0.0)
        }
    }

    
    // MARK: Actions

    @IBAction private func actionsClose() {
        if draggableState == .full {
            delegate?.wantsTransit(to: .compact, animating: true)
        }
    }
    
    @IBAction private func showFilter() {
        presenter.showFilter()
    }
    
}

extension HistoryViewController: HistoryViewProtocol {
    
    func reloadContent() {
        tableView.reloadData()
        updateEmptyState(animated: true)
    }

    func handle(changes: [HistoryViewModelChange]) {
        if changes.count > 0 {
            tableView.beginUpdates()

            changes.forEach { self.applySection(change: $0) }

            tableView.endUpdates()

            updateEmptyState(animated: true)
        }
    }

    private func applySection(change: HistoryViewModelChange) {
        switch change {
        case .insert(let index, _):
            tableView.insertSections([index], with: .fade)
        case .update(let sectionIndex, let itemChange, _):
            applyRow(change: itemChange, for: sectionIndex)
        case .delete(let index, _):
            tableView.deleteSections([index], with: .fade)
        }
    }

    private func applyRow(change: ListDifference<WalletViewModelProtocol>, for sectionIndex: Int) {
        switch change {
        case .insert(let index, _):
            tableView.insertRows(at: [IndexPath(row: index, section: sectionIndex)], with: .fade)
        case .update(let index, _, _):
            tableView.reloadRows(at: [IndexPath(row: index, section: sectionIndex)], with: .fade)
        case .delete(let index, _):
            tableView.deleteRows(at: [IndexPath(row: index, section: sectionIndex)], with: .fade)
        }
    }
}

extension HistoryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleDraggableOnScroll(scrollView: scrollView)
        handleNextPageOnScroll(scrollView: scrollView)
    }

    private func handleDraggableOnScroll(scrollView: UIScrollView) {
        if scrollView.isTracking, scrollView.contentOffset.y < Constants.bouncesThreshold {
            scrollView.bounces = false
            scrollView.showsVerticalScrollIndicator = false
        } else {
            scrollView.bounces = true
            scrollView.showsVerticalScrollIndicator = true
        }
    }

    private func handleNextPageOnScroll(scrollView: UIScrollView) {
        var threshold = scrollView.contentSize.height
        threshold -= scrollView.bounds.height * Constants.multiplierToActivateNextLoading

        if scrollView.contentOffset.y > threshold {
            if presenter.loadNext() {
                pageLoadingView.start()
            } else {
                pageLoadingView.stop()
            }
        }
    }
    
}


extension HistoryViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sectionModel(at: section).items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionViewModel = presenter.sectionModel(at: indexPath.section)
        let itemViewModel = sectionViewModel.items[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: itemViewModel.cellReuseIdentifier,
                                                 for: indexPath)

        if
            let defaultCell = cell as? TransactionTableViewCell,
            let defaultViewModel = itemViewModel as? TransactionItemViewModelProtocol {
            if defaultCell.style == nil {
                defaultCell.style = configuration?.cellStyle
            }

            if defaultCell.statusStyleProvider == nil {
                defaultCell.statusStyleProvider = statusStyleProvider
            }

            defaultCell.bind(viewModel: defaultViewModel)
        } else if let customCell = cell as? WalletViewProtocol {
            customCell.bind(viewModel: itemViewModel)
        }

        return cell
    }
    // swiftlint:enable force_cast
}


extension HistoryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cellNib = UINib(nibName: Constants.sectionNibName, bundle: Bundle(for: type(of: self)))
        
        guard let headerView = cellNib.instantiate(withOwner: self, options: nil).first as? SeparatedSectionView else {
            return nil
        }

        headerView.frame = CGRect(x: 0.0, y: 0.0, width: tableView.frame.size.width, height: Constants.sectionHeight)

        headerView.style = configuration?.headerStyle

        headerView.bind(title: presenter.sectionModel(at: section).title)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let items = presenter.sectionModel(at: indexPath.section).items
        return items[indexPath.row].itemHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.sectionHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let items = presenter.sectionModel(at: indexPath.section).items
        try? items[indexPath.row].command?.execute()
    }
    
}


extension HistoryViewController: Draggable {

    var draggableView: UIView {
        return view
    }

    var scrollPanRecognizer: UIPanGestureRecognizer? {
        return tableView.panGestureRecognizer
    }

    func canDrag(from state: DraggableState) -> Bool {
        switch state {
        case .compact:
            return true
        case .full:
            return !(tableView.contentOffset.y > 0.0)
        }
    }

    func set(dragableState: DraggableState, animated: Bool) {
        let oldState = dragableState
        self.draggableState = dragableState

        if animated {
            animate(progress: Constants.draggableProgressFinal,
                    from: oldState,
                    to: dragableState,
                    finalFrame: draggableView.frame)
        } else {
            update(for: dragableState, progress: Constants.draggableProgressFinal, forcesLayoutUpdate: didSetupLayout)
        }

        updateTableViewAfterTransition(to: dragableState, animated: animated)

        if case .hidden = headerType {
            updateHiddenTypeNavigationItem(for: dragableState, animated: animated)
        }
    }

    func set(contentInsets: UIEdgeInsets, for state: DraggableState) {
        switch state {
        case .compact:
            compactInsets = contentInsets
        case .full:
            fullInsets = contentInsets
        }

        if draggableState == state {
            applyContentInsets(for: draggableState)
            update(for: draggableState, progress: Constants.draggableProgressFinal, forcesLayoutUpdate: didSetupLayout)
        }
    }

    func animate(progress: Double, from oldState: DraggableState, to newState: DraggableState, finalFrame: CGRect) {
        UIView.beginAnimations(nil, context: nil)

        draggableView.frame = finalFrame
        updateHeaderHeight(for: newState, progress: progress, forcesLayoutUpdate: didSetupLayout)
        updateContent(for: newState, progress: progress, forcesLayoutUpdate: didSetupLayout)

        UIView.commitAnimations()
    }
}


extension HistoryViewController: EmptyStateDelegate {

    var shouldDisplayEmptyState: Bool {
        guard presenter.numberOfSections() == 0 else {
            return false
        }

        let hasDataSource = configuration?.emptyStateDataSource != nil
        return configuration?.emptyStateDelegate?.shouldDisplayEmptyState ?? hasDataSource
    }

}


extension HistoryViewController: EmptyStateDataSource {

    var viewForEmptyState: UIView? {
        return nil
    }

    var contentViewForEmptyState: UIView {
        return contentView
    }

    var imageForEmptyState: UIImage? {
        return configuration?.emptyStateDataSource?.imageForEmptyState
    }

    var titleForEmptyState: String? {
        return configuration?.emptyStateDataSource?.titleForEmptyState
    }

    var titleColorForEmptyState: UIColor? {
        return configuration?.emptyStateDataSource?.titleColorForEmptyState
    }

    var titleFontForEmptyState: UIFont? {
        return configuration?.emptyStateDataSource?.titleFontForEmptyState
    }

    var verticalSpacingForEmptyState: CGFloat? {
        return configuration?.emptyStateDataSource?.verticalSpacingForEmptyState
    }

    var trimStrategyForEmptyState: EmptyStateView.TrimStrategy {
        return configuration?.emptyStateDataSource?.trimStrategyForEmptyState ?? .none
    }
    
}


extension HistoryViewController: EmptyStateViewOwnerProtocol {

    var emptyStateDelegate: EmptyStateDelegate {
        return self
    }

    var emptyStateDataSource: EmptyStateDataSource {
        return self
    }

    var displayInsetsForEmptyState: UIEdgeInsets {
        var insets = UIEdgeInsets.zero
        insets.bottom = compactInsets.bottom
        return insets
    }

}


extension HistoryViewController: Reloadable {

    func reload() {
        presenter.reload()
    }

}

extension HistoryViewController: Localizable {
    func applyLocalization() {
        if isViewLoaded {
            setupLocalization()
            reloadEmptyState(animated: false)

            if draggableState == .full, let navigationItem = delegate?.presentationNavigationItem {
                setupNavigationItemTitle(navigationItem)
            }

            view.setNeedsLayout()
        }
    }
}
