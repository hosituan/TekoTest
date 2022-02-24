//
//  HomeViewModel.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    var products = [Product]()
    var limit = 10
    
    func getProduct(withProcessing: Bool = true) {
        if withProcessing {
            self.isFetching.onNext(true)
        }
        apiService?.getProduct(page: self.page, limit: 10) { [weak self] products, error in
            self?.isFetching.onNext(false)
            guard let self = self else { return }
            if let products = products {
                if self.page == 1 {
                    self.products = products
                } else {
                    self.products.append(contentsOf: products)
                }
                self.page += 1
                self.isLoadMore = self.limit <= products.count
                self.buildModels()
            } else {
                self.errorMessage.onNext(error?.localizedDescription ?? "Something went wrong. Please try again later!")
            }
        }
    }
    
    func buildModels() {
        buildingModels = []
        for product in products {
            let model = ProductRowViewModel(product: product, index: nextIndex(section: 0))
            buildingModels.append(model)
        }
        self.models.accept(buildingModels)
    }
    
    func productAt(indexPath: IndexPath) -> Product? {
        guard indexPath.row < products.count else { return nil }
        return products[indexPath.row]
    }
    
    func updateProduct(at index: IndexPath, to product: Product) {
        var models = models.value.filter {
            $0.index != index
        }
        products[index.row] = product
        let newRowModel = ProductRowViewModel(product: product, index: index)
        models.append(newRowModel)
        self.models.accept(models)
    }
}
