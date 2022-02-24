//
//  BaseViewModel.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class BaseViewModel {
    let bag = DisposeBag()
    let errorMessage = PublishSubject<String>()
    let success = PublishSubject<Bool>()
    let isFetching = PublishSubject<Bool>()
    let models = BehaviorRelay<[CellPresentable]>(value: [])
    var buildingModels = [CellPresentable]()
    let apiService: RESTAPIService?
    
    lazy var page: Int = 1
    lazy var isLoadMore: Bool = true
    
    init(apiService: RESTAPIService? = RESTAPIService()) {
        self.apiService = apiService
    }
    
    func modelAt(at index: IndexPath) -> CellPresentable? {
        return models.value.filter {
            $0.index == index
        }.first
    }
    
    func cellHeight(at index: IndexPath) -> CGFloat {
        return modelAt(at: index)?.cellHeight ?? UITableView.automaticDimension
    }
    
    func numberOfRow(in section: Int) -> Int {
        let models = models.value.filter {
            $0.index.section == section
        }
        return models.count
    }
    
    func numberOfSections() -> Int {
        if let maxViewModelSection = models.value.max(by: { $0.index.section < $1.index.section }) {
            return maxViewModelSection.index.section + 1
        }
        return 0
    }
    
    func nextIndex(section: Int) -> IndexPath {
        let models = buildingModels.filter {
            $0.index.section == section
        }
        return IndexPath(row: models.count, section: section)
    }
}
