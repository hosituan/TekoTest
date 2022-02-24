//
//  GetProductRequest.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import Alamofire

struct GetProductRequest: Requestable {
    var path: String = "https://hiring-test.stag.tekoapis.net/api/products"
    
    var page: Int = 1
    var limit: Int = 10
    var httpMethod: HTTPMethod = .get
    
    typealias Response = [Product]

}
