import Foundation

public typealias ShowMoreViewModelFactory = (ShowMoreViewModelDelegate?) throws -> WalletViewModelProtocol

@objc protocol ShowMoreViewModelObserver: class {
    @objc optional func didChangeExpanded(oldValue: Bool)
}

protocol ShowMoreViewModelProtocol: WalletViewModelProtocol {
    var collapsedTitle: String { get }
    var expandedTitle: String { get }
    var expanded: Bool { get }
    var style: WalletTextStyleProtocol { get }

    var observable: WalletViewModelObserverContainer<ShowMoreViewModelObserver> { get }
}

public protocol ShowMoreViewModelDelegate: class {
    func shouldToggleExpansion(from value: Bool, for viewModel: WalletViewModelProtocol) -> Bool
}

final class ShowMoreViewModel: ShowMoreViewModelProtocol {
    var cellReuseIdentifier: String
    var itemHeight: CGFloat
    var collapsedTitle: String = "Show more"
    var expandedTitle: String = "Show less"

    var observable = WalletViewModelObserverContainer<ShowMoreViewModelObserver>()

    var expanded: Bool = false {
        didSet {
            if expanded != oldValue {
                observable.observers.forEach { $0.observer?.didChangeExpanded?(oldValue: oldValue) }
            }
        }
    }

    var style: WalletTextStyleProtocol

    weak var delegate: ShowMoreViewModelDelegate?

    init(cellReuseIdentifier: String, itemHeight: CGFloat, style: WalletTextStyleProtocol) {
        self.cellReuseIdentifier = cellReuseIdentifier
        self.itemHeight = itemHeight
        self.style = style
    }

    func didSelect() {
        if let delegate = delegate {
            if delegate.shouldToggleExpansion(from: expanded, for: self) {
                expanded = !expanded
            }
        } else {
            expanded = !expanded
        }
    }
}
