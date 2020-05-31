/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation

public protocol WalletFormViewModelBinderProtocol {
    func bind(viewModel: WalletNewFormDetailsViewModel, to view: WalletFormDetailsViewProtocol)
    func bind(viewModel: MultilineTitleIconViewModel, to view: WalletFormTitleIconViewProtocol)
    func bind(viewModel: WalletFormSingleHeaderModel, to view: WalletFormTitleIconViewProtocol)
    func bind(viewModel: WalletFormDetailsHeaderModel, to view: WalletFormTitleIconViewProtocol)
    func bind(viewModel: WalletFormSpentAmountModel, to view: WalletFormDetailsViewProtocol)
    func bind(viewModel: WalletFormTokenViewModel, to view: WalletFormTokenViewProtocol)
}

struct WalletFormViewModelBinder: WalletFormViewModelBinderProtocol {
    private struct Constants {
        static let separatorWidth: CGFloat = 1.0
        static let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 18.0,
                                                              left: 0.0,
                                                              bottom: 18.0,
                                                              right: 0.0)
        static let detailsHeaderInsets = UIEdgeInsets(top: 18.0,
                                                      left: 0.0,
                                                      bottom: 0.0,
                                                      right: 0.0)
        static let horizontalSpacing: CGFloat = 6.0
    }

    let style: WalletStyleProtocol

    init(style: WalletStyleProtocol) {
        self.style = style
    }

    func bind(viewModel: WalletNewFormDetailsViewModel, to view: WalletFormDetailsViewProtocol) {
        let separatorStyle = WalletStrokeStyle(color: style.formCellStyle.separator,
                                               lineWidth: Constants.separatorWidth)

        view.style = WalletFormDetailsViewStyle(title: style.formCellStyle.title,
                                                separatorStyle: separatorStyle,
                                                contentInsets: Constants.contentInsets,
                                                titleHorizontalSpacing: Constants.horizontalSpacing,
                                                detailsHorizontalSpacing: Constants.horizontalSpacing,
                                                details: style.formCellStyle.details)

        view.bind(viewModel: viewModel)
    }

    func bind(viewModel: MultilineTitleIconViewModel, to view: WalletFormTitleIconViewProtocol) {
        let separatorStyle = WalletStrokeStyle(color: style.formCellStyle.separator,
                                               lineWidth: Constants.separatorWidth)

        view.style = WalletFormTitleIconViewStyle(title: style.formCellStyle.details,
                                                  separatorStyle: separatorStyle,
                                                  contentInsets: Constants.contentInsets,
                                                  horizontalSpacing: Constants.horizontalSpacing)
        view.bind(viewModel: viewModel)
    }

    func bind(viewModel: WalletFormSingleHeaderModel, to view: WalletFormTitleIconViewProtocol) {
        let targetViewModel = MultilineTitleIconViewModel(text: viewModel.title,
                                                          icon: viewModel.icon)

        let separatorStyle = WalletStrokeStyle(color: style.formCellStyle.separator,
                                               lineWidth: Constants.separatorWidth)

        view.style = WalletFormTitleIconViewStyle(title: style.formCellStyle.title,
                                                  separatorStyle: separatorStyle,
                                                  contentInsets: Constants.contentInsets,
                                                  horizontalSpacing: Constants.horizontalSpacing)
        view.bind(viewModel: targetViewModel)
    }

    func bind(viewModel: WalletFormDetailsHeaderModel, to view: WalletFormTitleIconViewProtocol) {
        let targetViewModel = MultilineTitleIconViewModel(text: viewModel.title,
                                                          icon: viewModel.icon)

        let separatorStyle = WalletStrokeStyle(color: style.formCellStyle.separator,
                                               lineWidth: Constants.separatorWidth)

        view.style = WalletFormTitleIconViewStyle(title: style.formCellStyle.title,
                                                  separatorStyle: separatorStyle,
                                                  contentInsets: Constants.detailsHeaderInsets,
                                                  horizontalSpacing: Constants.horizontalSpacing)
        view.bind(viewModel: targetViewModel)
    }

    func bind(viewModel: WalletFormSpentAmountModel, to view: WalletFormDetailsViewProtocol) {
        let separatorStyle = WalletStrokeStyle(color: style.formCellStyle.separator,
                                               lineWidth: Constants.separatorWidth)

        view.style = WalletFormDetailsViewStyle(title: style.formCellStyle.title,
                                                separatorStyle: separatorStyle,
                                                contentInsets: Constants.contentInsets,
                                                titleHorizontalSpacing: Constants.horizontalSpacing,
                                                detailsHorizontalSpacing: 0,
                                                details: style.formCellStyle.details,
                                                detailsAlignment: .iconDetails)

        let targetViewModel = WalletNewFormDetailsViewModel(title: viewModel.title,
                                                            titleIcon: nil,
                                                            details: viewModel.amount,
                                                            detailsIcon: style.amountChangeStyle.decrease)
        view.bind(viewModel: targetViewModel)
    }

    func bind(viewModel: WalletFormTokenViewModel, to view: WalletFormTokenViewProtocol) {
        let separatorStyle = WalletStrokeStyle(color: style.formCellStyle.separator,
                                               lineWidth: Constants.separatorWidth)

        view.style = WalletFormTokenViewStyle(title: style.formCellStyle.details,
                                              subtitle: style.formCellStyle.details,
                                              contentInset: Constants.contentInsets,
                                              iconTitleSpacing: Constants.horizontalSpacing,
                                              separatorStyle: separatorStyle,
                                              displayStyle: .singleTitle)
        view.bind(viewModel: viewModel)
    }
}
