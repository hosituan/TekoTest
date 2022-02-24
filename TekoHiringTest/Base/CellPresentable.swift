//
//  CellPresentable.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 22/02/2022.
//

import Foundation
import UIKit

protocol CellPresentable {
    var index: IndexPath { get set }
    var cellIdentifier: String { get set }
    var cellHeight: CGFloat { get set }
}

protocol CellCofigurable {
    func setup(model: CellPresentable)
}
