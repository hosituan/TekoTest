//
//  Requestable.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import Alamofire

protocol Requestable {
    associatedtype Response: Decodable
    var path: String { get }
    var httpBody: [String: Any]? { get }
    var queryParams: [String: Any]? { get }
    var httpMethod: HTTPMethod { get }
}

extension Requestable {
    var httpBody: [String: Any]? {
        get { return nil }
    }
    var queryParams: [String: Any]? {
        get { return nil }
    }
}

public enum Result<T, E> {
    case success(T)
    case failed(E)
    
    public var value: T? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
    
    public var error: E? {
        switch self {
        case .failed(let error):
            return error
        default:
            return nil
        }
    }
}
