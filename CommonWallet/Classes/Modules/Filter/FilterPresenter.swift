/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation


private enum DateSelection: Int {
    
    case fromDate = 0
    case toDate = 1
    
}


final class FilterPresenter {
    weak var view: FilterViewProtocol?
    var coordinator: FilterCoordinatorProtocol
    
    var fromDate: Date?
    var toDate: Date?
    
    private let assets: [WalletAsset]
    private var selectedAssets: Set<WalletAsset> = []
    private var transactionTypes: [WalletTransactionType]?
    private var selectedType: WalletTransactionType?
    private var filteringInstance: Filterable
    private var filter: WalletHistoryRequest?
    private var dateSelection: DateSelection?

    private var finalFilter: WalletHistoryRequest {
        var filter = WalletHistoryRequest()
        filter.assets = selectedAssets.map { $0.identifier }
        filter.fromDate = fromDate
        filter.toDate = toDate
        filter.type = selectedType?.backendName
        return filter
    }
    
    private lazy var dateFormatter: DateFormatter = DateFormatter.filterDateFormatter

    init(view: FilterViewProtocol,
         coordinator: FilterCoordinatorProtocol,
         assets: [WalletAsset],
         transactionTypes: [WalletTransactionType]?,
         filteringInstance: Filterable,
         filter: WalletHistoryRequest?) {
        self.view = view
        self.coordinator = coordinator
        self.assets = assets
        self.transactionTypes = transactionTypes
        self.filteringInstance = filteringInstance
        self.filter = filter
        selectedAssets = selectedAssets.union(assets)
    }
    
    private func selectDate(for dateCase: DateSelection) {
        dateSelection = dateCase
        switch dateCase {
        case .fromDate:
            coordinator.presentDatePicker(for: nil, maxDate: toDate, delegate: self)
        case .toDate:
            coordinator.presentDatePicker(for: fromDate, maxDate: Date(), delegate: self)
        }
    }
    
    private func selectAsset(with index: Int) {
        guard assets.indices.contains(index)  else {
            return
        }
        
        let asset = assets[index]
        
        if selectedAssets.contains(asset) {
            guard selectedAssets.count > 1 else {
                return
            }

            selectedAssets.remove(asset)
        } else {
            selectedAssets.insert(asset)
        }
        
        reload()
    }
    
    private func selectType(with index: Int) {
        guard
            let transactionTypeList = transactionTypes,
            transactionTypeList.indices.contains(index) else {
                return
        }
        
        selectedType = transactionTypeList[index]
        reload()
    }
    
    private func string(for date: Date?) -> String? {
        guard let date = date else {
            return nil
        }
        
        return dateFormatter.string(from: date)
    }
    
    private func reload() {
        var filterViewModel: FilterViewModel = []

        if assets.count > 1 {
            filterViewModel.append(FilterSectionViewModel(title: "Assets"))
            filterViewModel.append(contentsOf:
                zip(0..<assets.count, assets).map { FilterSelectionViewModel(title: $1.details,
                                                                             selected: selectedAssets.contains($1),
                                                                             index: $0,
                                                                             action: { [weak self] (index) in
                                                                                self?.selectAsset(with: index)
                })
            })
        }
        
        filterViewModel.append(FilterSectionViewModel(title: "Date range"))
        filterViewModel.append(FilterDateViewModel(title: "From",
                                                   dateString: string(for: fromDate),
                                                   action: { [weak self] in
                                                    self?.selectDate(for: .fromDate)
        }))
        filterViewModel.append(FilterDateViewModel(title: "To",
                                                   dateString: string(for: toDate),
                                                   action: { [weak self] in
            self?.selectDate(for: .toDate)
        }))
        
        if let transactionTypeList = transactionTypes {
            filterViewModel.append(FilterSectionViewModel(title: "Type"))
            filterViewModel.append(contentsOf:
                zip(0..<transactionTypeList.count, transactionTypeList).map {
                    let selected = selectedType != nil ? selectedType! == $1 : false
                    return FilterSelectionViewModel(title: $1.displayName,
                                                    selected: selected,
                                                    index: $0,
                                                    action: { [weak self] (index) in
                                                        self?.selectType(with: index)
                    })
            })
        }
        
        view?.set(filter: filterViewModel)
    }
    
}


extension FilterPresenter: FilterPresenterProtocol {
    
    func setup() {
        if let filter = filter {
            if let filterAssets = filter.assets {
                let selectedIds = filterAssets.map { $0.identifier() }
                selectedAssets = Set(assets.filter { (asset) -> Bool in
                    return selectedIds.contains(asset.identifier.identifier())
                })
            }
            fromDate = filter.fromDate
            toDate = filter.toDate
            selectedType = transactionTypes?.filter({ (type) -> Bool in
                return type.backendName == filter.type
            }).first ?? transactionTypes?.first
        } else {
            selectedType = transactionTypes?.first
        }
        
        reload()
    }
    
    func reset() {
        filter = nil
        fromDate = nil
        toDate = nil
        selectedAssets = Set(assets.map { $0 })
        selectedType = transactionTypes?.first
        reload()
    }
    
    func dismiss() {
        filteringInstance.set(filter: finalFilter)
        coordinator.dismiss()
    }
    
}


extension FilterPresenter: ModalDatePickerViewDelegate {
    
    func modalDatePickerViewDidCancel(_ view: ModalDatePickerView) {
        dateSelection = nil
    }
    
    func modalDatePickerView(_ view: ModalDatePickerView, didSelect date: Date) {
        if let dateCase = dateSelection {
            switch dateCase {
            case .fromDate: fromDate = date
            case .toDate: toDate = date
            }

            reload()
        }
    }
    
}
