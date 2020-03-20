/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraUI

protocol SelectedAssetViewDelegate: class {
    func selectedAssetViewDidChange(_ view: SelectedAssetView)
}

final class SelectedAssetView: UIView {
    @IBOutlet private(set) var borderedView: BorderedContainerView!
    @IBOutlet private(set) var titleControl: ActionTitleControl!

    var activated: Bool {
        titleControl.isActivated
    }

    var accessoryIcon: UIImage? {
        didSet {
            applyStyle()
        }
    }

    weak var delegate: SelectedAssetViewDelegate?

    private(set) var viewModel: AssetSelectionViewModelProtocol?

    func setActivation(_ value: Bool, animated: Bool) {
        if value {
            titleControl.activate(animated: animated)
        } else {
            titleControl.deactivate(animated: animated)
        }
    }

    func bind(viewModel: AssetSelectionViewModelProtocol) {
        self.viewModel?.observable.remove(observer: self)

        self.viewModel = viewModel
        viewModel.observable.add(observer: self)

        titleControl.titleLabel.text = viewModel.title
        titleControl.isUserInteractionEnabled = viewModel.canSelect

        applyStyle()

        titleControl.invalidateLayout()
    }

    private func applyStyle() {
        if let viewModel = viewModel {
            titleControl.imageView.image = viewModel.canSelect ? accessoryIcon : nil
        } else {
            titleControl.imageView.image = accessoryIcon
        }
    }

    @IBAction private func actionDidToggleActivation() {
        delegate?.selectedAssetViewDidChange(self)
    }
}

extension SelectedAssetView: AssetSelectionViewModelObserver {
    func assetSelectionDidChangeTitle() {
        titleControl.titleLabel.text = viewModel?.title
        titleControl.invalidateLayout()
    }

    func assetSelectionDidChangeSymbol() {}

    func assetSelectionDidChangeState() {
        guard let isSelecting = viewModel?.isSelecting else {
            return
        }

        if isSelecting {
            titleControl.activate(animated: true)
        } else {
            titleControl.deactivate(animated: true)
        }
    }
}
