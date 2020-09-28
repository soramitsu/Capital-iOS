/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI

protocol ModalPickerViewDelegate: class {
    func modalPickerViewDidCancel(_ view: ModalPickerView)
    func modalPickerView(_ view: ModalPickerView, didSelectRowAt index: Int, in context: AnyObject?)
}

final class ModalPickerView: UIView, ModalViewProtocol {
    @IBOutlet private(set) var backgroundView: RoundedView!
    @IBOutlet private var doneButton: UIButton!
    @IBOutlet private var pickerView: UIPickerView!

    weak var delegate: ModalPickerViewDelegate?
    weak var presenter: ModalPresenterProtocol?
    var context: AnyObject?

    private var isPickerInitialized: Bool = false

    var titles: [String] = []

    var initialSelectedIndex: Int = 0

    var font: UIFont?

    var textColor: UIColor?

    var doneIcon: UIImage? {
        get {
            return doneButton.image(for: .normal)
        }

        set {
            doneButton.setImage(newValue, for: .normal)
        }
    }

    func reload() {
        pickerView.reloadAllComponents()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        if !isPickerInitialized {
            isPickerInitialized = false

            if initialSelectedIndex < pickerView.numberOfRows(inComponent: 0) {
                pickerView.selectRow(initialSelectedIndex, inComponent: 0, animated: false)
            }
        }

    }

    // MARK: Action

    @IBAction private func actionDone() {
        delegate?.modalPickerView(self, didSelectRowAt: pickerView.selectedRow(inComponent: 0), in: context)
        presenter?.hide(view: self, animated: true)
    }
}

extension ModalPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return titles.count
    }
}

extension ModalPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                    forComponent component: Int, reusing view: UIView?) -> UIView {
        let titleLabel = view as? UILabel ?? UILabel()
        titleLabel.textAlignment = .center

        if let textColor = textColor {
            titleLabel.textColor = textColor
        }

        if let font = font {
            titleLabel.font = font
        }

        titleLabel.text = titles[row]

        return titleLabel
    }
}

extension ModalPickerView: ModalPresenterDelegate {
    func presenterShouldHide(_ presenter: ModalPresenterProtocol) -> Bool {
        delegate?.modalPickerViewDidCancel(self)
        return true
    }
}
