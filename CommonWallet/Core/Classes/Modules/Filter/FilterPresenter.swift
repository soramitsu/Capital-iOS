/**
* Copyright Soramitsu Co., Ltd. All Rights Reserved.
* SPDX-License-Identifier: GPL-3.0
*/

import Foundation
import SoraFoundation


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
    private var typeFilters: [WalletTransactionTypeFilter]
    private var selectedTypeFilter: WalletTransactionTypeFilter?
    private var filteringInstance: Filterable
    private var filter: WalletHistoryRequest?
    private var dateSelection: DateSelection?

    private var finalFilter: WalletHistoryRequest {
        var filter = WalletHistoryRequest()
        filter.assets = selectedAssets.map { $0.identifier }
        filter.fromDate = fromDate
        filter.toDate = toDate
        filter.type = selectedTypeFilter?.backendName
        return filter
    }
    
    private lazy var dateFormatter: LocalizableResource<DateFormatter> =
        DateFormatter.filterDateFormatter.localizableResource()

    init(view: FilterViewProtocol,
         coordinator: FilterCoordinatorProtocol,
         assets: [WalletAsset],
         typeFilters: [WalletTransactionTypeFilter],
         filteringInstance: Filterable,
         filter: WalletHistoryRequest?) {
        self.view = view
        self.coordinator = coordinator
        self.assets = assets
        self.typeFilters = typeFilters
        self.filteringInstance = filteringInstance
        self.filter = filter
        selectedAssets = selectedAssets.union(assets)
    }
    
    private func selectDate(for dateCase: DateSelection) {
        dateSelection = dateCase

        let locale = localizationManager?.selectedLocale ?? Locale.current

        switch dateCase {
        case .fromDate:
            coordinator.presentDatePicker(for: nil,
                                          maxDate: toDate,
                                          delegate: self,
                                          locale: locale)
        case .toDate:
            coordinator.presentDatePicker(for: fromDate,
                                          maxDate: Date(),
                                          delegate: self,
                                          locale: locale)
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
        if index >= 0, index < typeFilters.count {
            selectedTypeFilter = typeFilters[index]
            reload()
        }
    }
    
    private func string(for date: Date?) -> String? {
        guard let date = date else {
            return nil
        }

        let locale = localizationManager?.selectedLocale ?? Locale.current

        return dateFormatter.value(for: locale).string(from: date)
    }
    
    private func reload() {
        var filterViewModel: FilterViewModel = []

        let locale = localizationManager?.selectedLocale ?? Locale.current

        if assets.count > 1 {

            filterViewModel.append(FilterSectionViewModel(title: L10n.Filter.assets))
            filterViewModel.append(contentsOf:
                zip(0..<assets.count, assets).map { FilterSelectionViewModel(title: $1.name.value(for: locale),
                                                                             selected: selectedAssets.contains($1),
                                                                             index: $0,
                                                                             action: { [weak self] (index) in
                                                                                self?.selectAsset(with: index)
                })
            })
        }
        
        filterViewModel.append(FilterSectionViewModel(title: L10n.Filter.dateRange))
        filterViewModel.append(FilterDateViewModel(title: L10n.Filter.from,
                                                   dateString: string(for: fromDate),
                                                   action: { [weak self] in
                                                    self?.selectDate(for: .fromDate)
        }))
        filterViewModel.append(FilterDateViewModel(title: L10n.Filter.to,
                                                   dateString: string(for: toDate),
                                                   action: { [weak self] in
            self?.selectDate(for: .toDate)
        }))
        
        filterViewModel.append(FilterSectionViewModel(title: L10n.Filter.type))
        filterViewModel.append(contentsOf:
            zip(0..<typeFilters.count, typeFilters).map {
                let selected = selectedTypeFilter != nil ? selectedTypeFilter! == $1 : false
                return FilterSelectionViewModel(title: $1.displayName.value(for: locale),
                                                selected: selected,
                                                index: $0,
                                                action: { [weak self] (index) in
                                                    self?.selectType(with: index)
                })
        })
        
        view?.set(filter: filterViewModel)
    }
    
}


extension FilterPresenter: FilterPresenterProtocol {
    
    func setup() {
        if let filter = filter {
            if let filterAssets = filter.assets {
                selectedAssets = Set(assets.filter { (asset) -> Bool in
                    return filterAssets.contains(asset.identifier)
                })
            }

            fromDate = filter.fromDate
            toDate = filter.toDate
            selectedTypeFilter = typeFilters.first(where: { $0.backendName == filter.type })
                ?? typeFilters.first
        } else {
            selectedTypeFilter = typeFilters.first
        }
        
        reload()
    }
    
    func reset() {
        filter = nil
        fromDate = nil
        toDate = nil
        selectedAssets = Set(assets.map { $0 })
        selectedTypeFilter = typeFilters.first
        reload()
    }

    func apply() {
        filteringInstance.set(filter: finalFilter)
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

extension FilterPresenter: Localizable {
    func applyLocalization() {
        if view?.isSetup == true {
            reload()
        }
    }
}
