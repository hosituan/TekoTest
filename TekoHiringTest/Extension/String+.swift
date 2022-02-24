//
//  String+.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 23/02/2022.
//

import Foundation
extension String {
    
    func trimmed() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
