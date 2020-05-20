/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

protocol TransferViewProtocol: OperationDefinitionViewProtocol, ControllerBackedProtocol,
LoadableViewProtocol, AlertPresentable {}

protocol TransferCoordinatorProtocol: CoordinatorProtocol, PickerPresentable {
    func confirm(with payload: ConfirmationPayload)
}

protocol TransferAssemblyProtocol: class {
    static func assembleView(with resolver: ResolverProtocol,
                             payload: TransferPayload) -> TransferViewProtocol?
}
