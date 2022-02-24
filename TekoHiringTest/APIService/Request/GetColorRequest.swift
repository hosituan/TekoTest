//
//  GetColorRequest.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import Alamofire

struct GetColorRequest: Requestable {
    var path: String = "https://hiring-test.stag.tekoapis.net/api/colors"
    
    var httpMethod: HTTPMethod = .get
    
    typealias Response = [Color]

}
