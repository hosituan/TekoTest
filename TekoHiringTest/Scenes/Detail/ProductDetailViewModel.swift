//
//  ProductDetailViewModel.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import RxRelay

class ProductDetailViewModel: BaseViewModel {
    
    var product: Product
    var index: IndexPath
    
    init(index: IndexPath, product: Product) {
        self.index = index
        self.product = product
    }
    
    func updateProduct() {
        
    }
}
