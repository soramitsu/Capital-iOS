/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import CommonWallet

struct SidechainTransferTitleFactory: OperationDefinitionTitleModelFactoryProtocol {
    func createAssetTitle(assetId: String, receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: "Token")
    }

    func createAmountTitle(assetId: String, receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: "Amount")
    }

    func createReceiverTitle(assetId: String, receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: "To")
    }

    func createFeeTitleForDescription(assetId: String,
                                      receiverId: String?,
                                      feeDescription: FeeDescription) -> MultilineTitleIconViewModelProtocol? {
        nil
    }

    func createDescriptionTitle(assetId: String, receiverId: String?) -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: "Note", icon: UIImage(named: "icon-note"))
    }
}
