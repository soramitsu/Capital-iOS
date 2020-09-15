/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraUI

protocol ModalPickerViewFactoryProtocol {
    static func createView(with titles: [String], initialIndex: Int,
                           delegate: ModalPickerViewDelegate?, style: WalletStyleProtocol?) -> ControllerBackedProtocol?
}

final class ModalPickerViewFactory {
    static func createView(with titles: [String], initialIndex: Int,
                           delegate: ModalPickerViewDelegate?,
                           style: WalletStyleProtocol?) -> ControllerBackedProtocol? {
        let optionalView = UINib(nibName: "ModalPickerView", bundle: Bundle(for: ModalPickerView.self))
            .instantiate(withOwner: nil, options: nil).first

        guard let pickerView = optionalView as? ModalPickerView else {
            return nil
        }

        pickerView.frame.size.width = UIScreen.main.bounds.size.width

        pickerView.titles = titles
        pickerView.initialSelectedIndex = initialIndex
        pickerView.delegate = delegate

        let configuration: ModalSheetPresentationConfiguration

        if let style = style {
            pickerView.backgroundView.fillColor = style.modalActionStyle.fill
            pickerView.backgroundView.cornerRadius = style.modalActionStyle.cornerRadius

            if let stroke = style.modalActionStyle.stroke {
                pickerView.backgroundView.strokeColor = stroke.color
                pickerView.backgroundView.strokeWidth = stroke.lineWidth
            }

            if let shadow = style.modalActionStyle.shadow {
                pickerView.backgroundView.shadowOpacity = shadow.opacity
                pickerView.backgroundView.shadowColor = shadow.color
                pickerView.backgroundView.shadowOffset = shadow.offset
                pickerView.backgroundView.shadowColor = shadow.color
            }

            pickerView.doneIcon = style.modalActionStyle.doneIcon
            pickerView.textColor = style.bodyTextColor
            pickerView.font = style.bodyRegularFont

            configuration = ModalSheetPresentationConfiguration(shadowOpacity: style.modalActionStyle.backdropOpacity)
        } else {
            configuration = ModalSheetPresentationConfiguration()
        }

        let modalPresentationFactory = ModalSheetPresentationFactory(configuration: configuration)

        let viewController = CustomPresentationController(view: pickerView,
                                                          modalPresentationFactory: modalPresentationFactory)
        return viewController
    }
}
