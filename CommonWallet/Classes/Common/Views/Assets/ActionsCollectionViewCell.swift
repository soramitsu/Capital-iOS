import Foundation
import SoraUI

final class ActionsCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var sendButton: RoundedButton!
    @IBOutlet private var receiveButton: RoundedButton!
    @IBOutlet private var separatorView: UIView!

    private(set) var actionsViewModel: ActionsViewModelProtocol?

    override func prepareForReuse() {
        super.prepareForReuse()

        actionsViewModel = nil
    }

    @IBAction private func actionSend() {
        if let actionsViewModel = actionsViewModel {
            actionsViewModel.delegate?.didRequestSend(for: actionsViewModel)
        }
    }

    @IBAction private func actionReceive() {
        if let actionsViewModel = actionsViewModel {
            actionsViewModel.delegate?.didRequestReceive(for: actionsViewModel)
        }
    }
}

extension ActionsCollectionViewCell: WalletViewProtocol {
    var viewModel: WalletViewModelProtocol? {
        return actionsViewModel
    }

    func bind(viewModel: WalletViewModelProtocol) {
        if let actionsViewModel = viewModel as? ActionsViewModelProtocol {
            self.actionsViewModel = actionsViewModel

            sendButton.imageWithTitleView?.title = actionsViewModel.sendTitle
            receiveButton.imageWithTitleView?.title = actionsViewModel.receiveTitle
            sendButton.imageWithTitleView?.titleColor = actionsViewModel.style.sendText.color
            sendButton.imageWithTitleView?.titleFont = actionsViewModel.style.sendText.font
            receiveButton.imageWithTitleView?.titleColor = actionsViewModel.style.receiveText.color
            receiveButton.imageWithTitleView?.titleFont = actionsViewModel.style.receiveText.font

            sendButton.invalidateLayout()
            receiveButton.invalidateLayout()
        }
    }
}
