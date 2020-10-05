/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol OperationDefinitionViewFactoryOverriding {
    func createHeaderViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionHeaderView?
    func createErrorViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionErrorView?
    func createAssetView() -> BaseSelectedAssetView?
    func createReceiverView() -> BaseReceiverView?
    func createAmountView() -> BaseAmountInputView?
    func createFeeView() -> BaseFeeView?
    func createDescriptionView() -> BaseDescriptionInputView?
}

public extension OperationDefinitionViewFactoryOverriding {
    func createHeaderViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionHeaderView? {
        nil
    }

    func createErrorViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionErrorView? {
        nil
    }

    func createAssetView() -> BaseSelectedAssetView? {
        nil
    }

    func createReceiverView() -> BaseReceiverView? {
        nil
    }

    func createAmountView() -> BaseAmountInputView? {
        nil
    }

    func createFeeView() -> BaseFeeView? {
        nil
    }

    func createDescriptionView() -> BaseDescriptionInputView? {
        nil
    }
}

struct OperationDefinitionViewFactoryWrapper: OperationDefinitionViewFactoryProtocol {
    let overriding: OperationDefinitionViewFactoryOverriding
    let factory: OperationDefinitionViewFactoryProtocol

    func createHeaderViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionHeaderView {
        overriding.createHeaderViewForItem(type: type) ?? factory.createHeaderViewForItem(type: type)
    }

    func createErrorViewForItem(type: OperationDefinitionType) -> BaseOperationDefinitionErrorView {
        overriding.createErrorViewForItem(type: type) ?? factory.createErrorViewForItem(type: type)
    }

    func createAssetView() -> BaseSelectedAssetView {
        overriding.createAssetView() ?? factory.createAssetView()
    }

    func createReceiverView() -> BaseReceiverView {
        overriding.createReceiverView() ?? factory.createReceiverView()
    }

    func createAmountView() -> BaseAmountInputView {
        overriding.createAmountView() ?? factory.createAmountView()
    }

    func createFeeView() -> BaseFeeView {
        overriding.createFeeView() ?? factory.createFeeView()
    }

    func createDescriptionView() -> BaseDescriptionInputView {
        overriding.createDescriptionView() ?? factory.createDescriptionView()
    }
}
