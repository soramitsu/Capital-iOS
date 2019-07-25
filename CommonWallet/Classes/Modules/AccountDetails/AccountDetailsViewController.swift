import UIKit


final class AccountDetailsViewController: ContainerViewController {
    private struct Constants {
        static let additionalTopInset: CGFloat = 10.0
    }

    override var presentationNavigationItem: UINavigationItem? {
        return navigationController != nil ? navigationItem : nil
    }

    var presenter: AccountDetailsPresenterProtocol!

    var style: WalletStyleProtocol?

    override var inheritedInsets: UIEdgeInsets {
        var inset = super.inheritedInsets

        inset.top += Constants.additionalTopInset

        return inset
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()

        presenter.setup()
    }

    private func configure() {
        view.backgroundColor = style?.backgroundColor
    }
}

extension AccountDetailsViewController: AccountDetailsViewProtocol {}
