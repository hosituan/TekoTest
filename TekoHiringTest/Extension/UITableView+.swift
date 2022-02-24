//
//  UITableView+.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import UIKit
extension UITableView {
    func registerCells(_ cellIdentifiers: AnyClass...) {
        for classIdentifier in cellIdentifiers {
            self.register(classIdentifier, forCellReuseIdentifier: String(describing: classIdentifier))
        }
    }
}
