/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI


protocol ModalDatePickerViewFactoryProtocol {
    
    static func createView(with minDate: Date?,
                           maxDate: Date?,
                           delegate: ModalDatePickerViewDelegate?,
                           style: WalletStyleProtocol?,
                           locale: Locale) -> ControllerBackedProtocol?

}


final class ModalDatePickerViewFactory {
    
    static func createView(with minDate: Date?,
                           maxDate: Date?,
                           delegate: ModalDatePickerViewDelegate?,
                           style: WalletStyleProtocol?,
                           locale: Locale) -> ControllerBackedProtocol? {
        let optionalView = UINib(nibName: "ModalDatePickerView", bundle: Bundle(for: ModalDatePickerView.self))
            .instantiate(withOwner: nil, options: nil).first

        guard let picker = optionalView as? ModalDatePickerView else {
            return nil
        }

        picker.frame.size.width = UIScreen.main.bounds.size.width

        picker.pickerView.minimumDate = minDate
        picker.pickerView.maximumDate = maxDate
        picker.pickerView.locale = locale
        picker.delegate = delegate

        let configuration: ModalSheetPresentationConfiguration

        if let style = style {
            picker.backgroundView.fillColor = style.modalActionStyle.fill
            picker.backgroundView.cornerRadius = style.modalActionStyle.cornerRadius

            if let stroke = style.modalActionStyle.stroke {
                picker.backgroundView.strokeColor = stroke.color
                picker.backgroundView.strokeWidth = stroke.lineWidth
            }

            if let shadow = style.modalActionStyle.shadow {
                picker.backgroundView.shadowOpacity = shadow.opacity
                picker.backgroundView.shadowColor = shadow.color
                picker.backgroundView.shadowOffset = shadow.offset
                picker.backgroundView.shadowColor = shadow.color
            }

            picker.doneIcon = style.modalActionStyle.doneIcon
            picker.textColor = style.bodyTextColor
            picker.font = style.bodyRegularFont

            configuration = ModalSheetPresentationConfiguration(shadowOpacity: style.modalActionStyle.backdropOpacity)
        } else {
            configuration = ModalSheetPresentationConfiguration()
        }

        let modalPresentationFactory = ModalSheetPresentationFactory(configuration: configuration)

        let viewController = CustomPresentationController(view: picker,
                                                          modalPresentationFactory: modalPresentationFactory)
        return viewController
    }
}
