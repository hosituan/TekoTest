//
//  DataManager.swift
//  TekoHiringTest
//
//  Created by Ho Si Tuan on 24/02/2022.
//

import Foundation

class DataManager {
    static let shared = DataManager()
    let apiService = RESTAPIService()
    var colors = [Color]()
    private init() {
        fetchColor()
    }
    
    func fetchColor() {
        apiService.getColors { colors, error in
            if let colors = colors {
                self.colors = colors
                self.saveColor()
            }
        }
    }
    
    func getColor(id: Int?) -> String? {
        guard let id = id else { return nil }
        return UserDefaults.standard.string(forKey: "\(id)")
    }
    
    
    func getColorIndex(id: Int) -> Int {
        return colors.firstIndex {
            $0.id == id
        } ?? 0
    }
    
    func saveColor() {
        for color in self.colors {
            guard let id = color.id, let name = color.name else { return }
            UserDefaults.standard.set(name, forKey: "\(id)")
        }
    }
}
