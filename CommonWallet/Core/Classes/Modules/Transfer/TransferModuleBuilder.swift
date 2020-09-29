/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import SoraFoundation

final class TransferModuleBuilder {
    private struct Constants {
        static let iconTitleSpacing: CGFloat = 6
        static let titleControlSpacing: CGFloat = 8
        static let amountHorizontalSpacing: CGFloat = 0
    }

    private var operationDefinitionFactory: OperationDefinitionViewFactoryOverriding?

    private var accessoryViewFactory: AccessoryViewFactoryProtocol.Type?

    private var transferViewModelFactory: TransferViewModelFactoryOverriding?

    private lazy var settings: WalletTransactionSettingsProtocol =
        WalletTransactionSettings.defaultSettings

    private lazy var resultValidator: TransferValidating =
        TransferValidator(transactionSettings: settings)

    lazy var style: WalletStyleProtocol = WalletStyle()

    private var receiverPosition: TransferReceiverPosition = .accessoryBar

    private lazy var separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol
        = DefaultSeparatorsDistribution()

    private lazy var headerFactory: OperationDefinitionHeaderModelFactoryProtocol
        = TransferDefinitionHeaderModelFactory()

    private lazy var errorHandler: OperationDefinitionErrorHandling? = nil

    private lazy var changeHandler: OperationDefinitionChangeHandling = OperationDefinitionChangeHandler()

    private lazy var feeEditing: FeeEditing? = nil

    private var localizableTitle: LocalizableResource<String>?

    private lazy var headerContentInsets = UIEdgeInsets(top: 15.0, left: 0.0, bottom: 0.0, right: 0.0)

    private lazy var containingViewInsets = UIEdgeInsets(top: 15.0, left: 0.0, bottom: 15.0, right: 0.0)

    private lazy var errorContentInsets = UIEdgeInsets(top: 4.0, left: 0.0, bottom: 4.0, right: 0.0)

    private lazy var containingHeaderStyle: WalletContainingHeaderStyle = {
        let titleStyle = WalletTextStyle(font: style.bodyRegularFont, color: style.captionTextColor)
        return WalletContainingHeaderStyle(titleStyle: titleStyle,
                                           horizontalSpacing: Constants.iconTitleSpacing,
                                           contentInsets: headerContentInsets)
    }()

    private lazy var containingErrorStyle: WalletContainingErrorStyle = {
        return WalletContainingErrorStyle(inlineErrorStyle: style.inlineErrorStyle,
                                          horizontalSpacing: Constants.iconTitleSpacing,
                                          contentInsets: errorContentInsets)
    }()

    private lazy var containingSeparatorStyle: WalletStrokeStyleProtocol = {
        WalletStrokeStyle(color: style.thinBorderColor, lineWidth: 1.0)
    }()

    private lazy var selectedAssetDisplayStyle: SelectedAssetViewDisplayStyle = .singleTitle

    private lazy var feeDisplayStyle: FeeViewDisplayStyle = .singleTitle

    private lazy var accessoryViewType: WalletAccessoryViewType = .titleIconActionBar

    private lazy var generatingIconStyle: WalletNameIconStyleProtocol = style.nameIconStyle

    private lazy var selectedAssetStyle: WalletContainingAssetStyle = {
        let textStyle = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)
        let subtitleStyle = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)

        return WalletContainingAssetStyle(containingHeaderStyle: containingHeaderStyle,
                                          titleStyle: textStyle,
                                          subtitleStyle: subtitleStyle,
                                          detailsStyle: textStyle,
                                          switchIcon: style.downArrowIcon,
                                          contentInsets: containingViewInsets,
                                          titleHorizontalSpacing: Constants.iconTitleSpacing,
                                          detailsHorizontalSpacing: Constants.titleControlSpacing,
                                          displayStyle: selectedAssetDisplayStyle,
                                          separatorStyle: containingSeparatorStyle,
                                          containingErrorStyle: containingErrorStyle)
    }()

    private lazy var receiverStyle: WalletContainingReceiverStyle = {
        let textStyle = WalletTextStyle(font: style.bodyRegularFont, color: style.bodyTextColor)

        return WalletContainingReceiverStyle(containingHeaderStyle: containingHeaderStyle,
                                             textStyle: textStyle,
                                             horizontalSpacing: Constants.iconTitleSpacing,
                                             contentInsets: containingViewInsets,
                                             separatorStyle: containingSeparatorStyle,
                                             containingErrorStyle: containingErrorStyle)
    }()

    private lazy var amountStyle: WalletContainingAmountStyle = {
        let assetStyle = WalletTextStyle(font: style.header1Font, color: style.bodyTextColor)
        let inputStyle = WalletTextStyle(font: style.header1Font, color: style.bodyTextColor)

        return WalletContainingAmountStyle(containingHeaderStyle: containingHeaderStyle,
                                           assetStyle: assetStyle,
                                           inputStyle: inputStyle,
                                           keyboardIndicatorMode: .never,
                                           keyboardIcon: style.keyboardIcon,
                                           caretColor: style.caretColor,
                                           horizontalSpacing: Constants.amountHorizontalSpacing,
                                           contentInsets: containingViewInsets,
                                           separatorStyle: containingSeparatorStyle,
                                           containingErrorStyle: containingErrorStyle)
    }()

    private lazy var feeStyle: WalletContainingFeeStyle = {
        let titleStyle = WalletTextStyle(font: style.bodyRegularFont, color: style.captionTextColor)

        return WalletContainingFeeStyle(containingHeaderStyle: containingHeaderStyle,
                                        titleStyle: titleStyle,
                                        amountStyle: titleStyle,
                                        activityTintColor: style.captionTextColor,
                                        displayStyle: feeDisplayStyle,
                                        horizontalSpacing: Constants.iconTitleSpacing,
                                        contentInsets: containingViewInsets,
                                        separatorStyle: containingSeparatorStyle,
                                        containingErrorStyle: containingErrorStyle)
    }()

    private lazy var descriptionStyle: WalletContainingDescriptionStyle = {
        let placeholderStyle = WalletTextStyle(font: style.bodyRegularFont,
                                               color: style.bodyTextColor.withAlphaComponent(0.22))

        let inputStyle = WalletTextStyle(font: style.bodyRegularFont,
                                         color: style.bodyTextColor)

        return WalletContainingDescriptionStyle(containingHeaderStyle: containingHeaderStyle,
                                                inputStyle: inputStyle,
                                                placeholderStyle: placeholderStyle,
                                                keyboardIndicatorMode: .never,
                                                keyboardIcon: style.keyboardIcon,
                                                caretColor: style.caretColor,
                                                contentInsets: containingViewInsets,
                                                separatorStyle: containingSeparatorStyle,
                                                containingErrorStyle: containingErrorStyle)
    }()

    func build() -> TransferConfigurationProtocol {
        let style = OperationDefinitionViewStyle(assetStyle: selectedAssetStyle,
                                                 receiverStyle: receiverStyle,
                                                 amountStyle: amountStyle,
                                                 feeStyle: feeStyle,
                                                 descriptionStyle: descriptionStyle)

        return TransferConfiguration(resultValidator: resultValidator,
                                     receiverPosition: receiverPosition,
                                     headerFactory: headerFactory,
                                     separatorsDistribution: separatorsDistribution,
                                     settings: settings,
                                     changeHandler: changeHandler,
                                     style: style,
                                     generatingIconStyle: generatingIconStyle,
                                     accessoryViewType: accessoryViewType,
                                     localizableTitle: localizableTitle,
                                     transferViewModelFactory: transferViewModelFactory,
                                     errorHandler: errorHandler,
                                     feeEditing: feeEditing,
                                     accessoryViewFactory: accessoryViewFactory,
                                     operationDefinitionFactory: operationDefinitionFactory)
    }
}

extension TransferModuleBuilder: TransferModuleBuilderProtocol {

    func with(receiverPosition: TransferReceiverPosition) -> Self {
        self.receiverPosition = receiverPosition
        return self
    }

    func with(headerFactory: OperationDefinitionHeaderModelFactoryProtocol) -> Self {
        self.headerFactory = headerFactory
        return self
    }

    func with(separatorsDistribution: OperationDefinitionSeparatorsDistributionProtocol) -> Self {
        self.separatorsDistribution = separatorsDistribution
        return self
    }

    func with(headerContentInsets: UIEdgeInsets) -> Self {
        self.headerContentInsets = headerContentInsets
        return self
    }

    func with(containingViewInsets: UIEdgeInsets) -> Self {
        self.containingViewInsets = containingViewInsets
        return self
    }

    func with(errorContentInsets: UIEdgeInsets) -> Self {
        self.errorContentInsets = errorContentInsets
        return self
    }

    func with(containingHeaderStyle: WalletContainingHeaderStyle) -> Self {
        self.containingHeaderStyle = containingHeaderStyle
        return self
    }

    func with(containingErrorStyle: WalletContainingErrorStyle) -> Self {
        self.containingErrorStyle = containingErrorStyle
        return self
    }

    func with(selectedAssetDisplayStyle: SelectedAssetViewDisplayStyle) -> Self {
        self.selectedAssetDisplayStyle = selectedAssetDisplayStyle
        return self
    }

    func with(feeDisplayStyle: FeeViewDisplayStyle) -> Self {
        self.feeDisplayStyle = feeDisplayStyle
        return self
    }

    func with(selectedAssetStyle: WalletContainingAssetStyle) -> Self {
        self.selectedAssetStyle = selectedAssetStyle
        return self
    }

    func with(receiverStyle: WalletContainingReceiverStyle) -> Self {
        self.receiverStyle = receiverStyle
        return self
    }

    func with(generatingIconStyle: WalletNameIconStyleProtocol) -> Self {
        self.generatingIconStyle = generatingIconStyle
        return self
    }

    func with(amountStyle: WalletContainingAmountStyle) -> Self {
        self.amountStyle = amountStyle
        return self
    }

    func with(feeStyle: WalletContainingFeeStyle) -> Self {
        self.feeStyle = feeStyle
        return self
    }

    func with(descriptionStyle: WalletContainingDescriptionStyle) -> Self {
        self.descriptionStyle = descriptionStyle
        return self
    }

    func with(accessoryViewType: WalletAccessoryViewType) -> Self {
        self.accessoryViewType = accessoryViewType
        return self
    }

    func with(localizableTitle: LocalizableResource<String>) -> Self {
        self.localizableTitle = localizableTitle
        return self
    }

    func with(transferViewModelFactory: TransferViewModelFactoryOverriding) -> Self {
        self.transferViewModelFactory = transferViewModelFactory
        return self
    }

    func with(resultValidator: TransferValidating) -> Self {
        self.resultValidator = resultValidator
        return self
    }

    func with(settings: WalletTransactionSettingsProtocol) -> Self {
        self.settings = settings
        return self
    }

    func with(errorHandler: OperationDefinitionErrorHandling) -> Self {
        self.errorHandler = errorHandler
        return self
    }

    func with(changeHandler: OperationDefinitionChangeHandling) -> Self {
        self.changeHandler = changeHandler
        return self
    }

    func with(feeEditing: FeeEditing) -> Self {
        self.feeEditing = feeEditing
        return self
    }

    func with(accessoryViewFactory: AccessoryViewFactoryProtocol.Type) -> Self {
        self.accessoryViewFactory = accessoryViewFactory
        return self
    }

    func with(operationDefinitionFactory: OperationDefinitionViewFactoryOverriding) -> Self {
        self.operationDefinitionFactory = operationDefinitionFactory
        return self
    }
}
