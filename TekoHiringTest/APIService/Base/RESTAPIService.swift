//
//  RESTAPIService.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import Alamofire

class RESTAPIService {
    func getColors(completionHandler: @escaping ([Color]?, Error?) -> Void) {
        let request = GetColorRequest()
        AF.sendRequest(request) { response in
            completionHandler(response.value, response.error)
        }
    }
    
    func getProduct(page: Int, limit: Int, completionHandler: @escaping ([Product]?, Error?) -> Void) {
        let request = GetProductRequest(page: page, limit: limit)
        AF.sendRequest(request) { response in
            completionHandler(response.value, response.error)
        }
    }
}
