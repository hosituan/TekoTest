//
//  AlamofireSesson+.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import Alamofire

extension Session {
    func sendRequest<T: Requestable>(_ request: T, completionHandler: @escaping (Result<T.Response, Error>) -> Void) {
        AF.request(request.path, method: request.httpMethod, parameters: request.httpBody)
            .responseDecodable(of: T.Response.self) { response in
                switch response.result {
                case .success(let data):
                    completionHandler(.success(data))
                case .failure(let error):
                    completionHandler(.failed(error))
                }
            }
    }
}

