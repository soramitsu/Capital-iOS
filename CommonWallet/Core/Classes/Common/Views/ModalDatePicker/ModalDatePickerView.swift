/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import UIKit
import SoraUI


protocol ModalDatePickerViewDelegate: class {
    
    func modalDatePickerViewDidCancel(_ view: ModalDatePickerView)
    func modalDatePickerView(_ view: ModalDatePickerView, didSelect date: Date)
    
}


final class ModalDatePickerView: UIView, ModalViewProtocol {
    
    @IBOutlet private(set) var backgroundView: RoundedView!
    @IBOutlet private var doneButton: UIButton!
    @IBOutlet private(set) var pickerView: UIDatePicker!

    weak var delegate: ModalDatePickerViewDelegate?
    weak var presenter: ModalPresenterProtocol?
    var context: AnyObject?

    private var isPickerInitialized: Bool = false

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

    
    // MARK: Action

    @IBAction private func actionDone() {
        delegate?.modalDatePickerView(self, didSelect: pickerView.date)
        presenter?.hide(view: self, animated: true)
    }
}


extension ModalDatePickerView: ModalPresenterDelegate {
    
    func presenterShouldHide(_ presenter: ModalPresenterProtocol) -> Bool {
        delegate?.modalDatePickerViewDidCancel(self)
        return true
    }
    
}
