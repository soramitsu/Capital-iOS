/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/


import Foundation
import RobinHood

extension TransferPresenter {
    func handleResponse(with optionalBalances: [BalanceData]?) {
        if let balances = optionalBalances {
            self.balances = balances
        }

        guard selectedBalance != nil else {
                if confirmationState != nil {
                    confirmationState = nil

                    if !attempHandleError(TransferPresenterError.missingAsset) {
                        logger?.error("Can't handle asset missing error")
                    }
                }

            return
        }

        handleChangeForEvent(.balance)

        if let currentState = confirmationState {
            confirmationState = currentState.union(.requestedAmount)
            completeConfirmation()
        }
    }

    func handleResponse(with error: Error) {
        if confirmationState != nil {
            confirmationState = nil

            view?.didStopLoading()

            if attempHandleError(error) {
                return
            }

            if attempHandleError(TransferPresenterError.missingBalances) {
                return
            }

            logger?.error("Can't handle asset missing error")
        }
    }

    func setupBalanceDataProvider() {
        let changesBlock = { [weak self] (changes: [DataProviderChange<[BalanceData]>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let items), .update(let items):
                    self?.handleResponse(with: items)
                default:
                    break
                }
            } else {
                self?.handleResponse(with: nil)
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.handleResponse(with: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        balanceDataProvider.addObserver(self,
                                        deliverOn: .main,
                                        executing: changesBlock,
                                        failing: failBlock,
                                        options: options)
    }

    func handleTransfer(metadata: TransferMetaData?) {
        if metadata != nil {
            self.metadata = metadata
        }

        handleChangeForEvent(.metadata)

        if let currentState = confirmationState {
            confirmationState = currentState.union(.requestedFee)
            completeConfirmation()
        }
    }

    func handleTransferMetadata(error: Error) {
        if confirmationState != nil {
            view?.didStopLoading()

            confirmationState = nil
        }

        if attempHandleError(error) {
            return
        }

        if attempHandleError(TransferPresenterError.missingMetadata) {
            return
        }

        logger?.error("Can't handle transfer metadata error \(error)")
    }

    func updateMetadataProvider(for asset: WalletAsset) throws {
        let metaDataProvider = try dataProviderFactory
            .createTransferMetadataProvider(for: asset.identifier,
                                            receiver: payload.receiveInfo.accountId)
        self.metadataProvider = metaDataProvider

        setupMetadata(provider: metaDataProvider)
    }

    func setupMetadata(provider: SingleValueProvider<TransferMetaData>) {
        let changesBlock = { [weak self] (changes: [DataProviderChange<TransferMetaData>]) -> Void in
            if let change = changes.first {
                switch change {
                case .insert(let item), .update(let item):
                    self?.handleTransfer(metadata: item)
                default:
                    break
                }
            } else {
                self?.handleTransfer(metadata: nil)
            }
        }

        let failBlock: (Error) -> Void = { [weak self] (error: Error) in
            self?.handleTransferMetadata(error: error)
        }

        let options = DataProviderObserverOptions(alwaysNotifyOnRefresh: true)
        provider.addObserver(self,
                             deliverOn: .main,
                             executing: changesBlock,
                             failing: failBlock,
                             options: options)
    }

    func prepareTransferInfo() throws -> TransferInfo {
        let inputAmount = amountInputViewModel.decimalAmount ?? 0

        guard let metadata = metadata else {
            throw TransferPresenterError.missingMetadata
        }

        guard let balances = balances else {
            throw TransferPresenterError.missingBalances
        }

        let calculator = try feeCalculationFactory
            .createTransferFeeStrategyForDescriptions(metadata.feeDescriptions,
                                                      assetId: selectedAsset.identifier,
                                                      precision: selectedAsset.precision)

        let result = try calculator.calculate(for: inputAmount)

        let details = descriptionInputViewModel?.text ?? ""

        let info = TransferInfo(source: accountId,
                                destination: payload.receiveInfo.accountId,
                                amount: AmountDecimal(value: result.sending),
                                asset: selectedAsset.identifier,
                                details: details,
                                fees: result.fees,
                                context: payload.context)

        return try resultValidator.validate(info: info,
                                            balances: balances,
                                            metadata: metadata)
    }

    func completeConfirmation() {
        guard confirmationState == .completed else {
            return
        }

        confirmationState = nil

        view?.didStopLoading()

        do {
            let transferInfo = try prepareTransferInfo()

            let composedPayload = ConfirmationPayload(transferInfo: transferInfo,
                                                      receiverName: payload.receiverName)

            coordinator.confirm(with: composedPayload)
        } catch {
            if !attempHandleError(error) {
                logger?.error("Can't handle confirmation error \(error)")
            }
        }
    }
}
