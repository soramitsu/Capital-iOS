/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import CommonWallet

struct SidechainTransferHeaderFactory: OperationDefinitionHeaderModelFactoryProtocol {
    func createAssetTitle(assetId: String, receiverId: String?, locale: Locale)
        -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: "Token")
    }

    func createAmountTitle(assetId: String, receiverId: String?, locale: Locale)
        -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: "Amount")
    }

    func createReceiverTitle(assetId: String, receiverId: String?, locale: Locale)
        -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: "To")
    }

    func createFeeTitleForDescription(assetId: String,
                                      receiverId: String?,
                                      feeDescription: Fee,
                                      locale: Locale) -> MultilineTitleIconViewModelProtocol? {
        nil
    }

    func createDescriptionTitle(assetId: String, receiverId: String?, locale: Locale)
        -> MultilineTitleIconViewModelProtocol? {
        MultilineTitleIconViewModel(text: "Note", icon: UIImage(named: "icon-note"))
    }
}
