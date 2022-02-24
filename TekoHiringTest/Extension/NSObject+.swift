//
//  NSObject.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation

protocol ClassName {
    static var className: String { get }
}
extension NSObject: ClassName {
    static var className: String {
        return String(describing: self)
    }
}
