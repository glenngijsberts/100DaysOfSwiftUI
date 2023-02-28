//
//  FoodItems.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import Foundation

// Make the class Observable so we can use it
// In our views
class FoodItems: ObservableObject {
    // Items
    @Published var items = [Food]() {
        // When items are being changed
        didSet {
            // Create encoder
            let encoder = JSONEncoder()
            
            // When encoding is correctly done
            if let data = try? encoder.encode(items) {
                // Save to storage
                UserDefaults.standard.set(data, forKey: "FoodItems")
            }
        }
    }
    
    init() {
        if let foodItems = UserDefaults.standard.data(forKey: "FoodItems") {
            let decoder = JSONDecoder()
            
            if let decodedItems = try? decoder.decode([Food].self, from: foodItems) {
                items = decodedItems
                
                return
            }
        }
        
        items = []
    }
}
