//
//  FoodCategory.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import Foundation
import SwiftUI

struct FoodCategory: Codable, Hashable {
    let title: String
    
    var value: String {
        title.lowercased()
    }
    
    var categoryColor: Color {
        var color: Color
        
        switch value {
        case "breakfast":
            color = Color.green
        case "lunch":
            color = Color.purple
        case "dinner":
            color = Color.teal
        case "snack":
            color = Color.pink
        default:
            color = Color.orange
        }
        
        return color
    }
    
    var icon: String {
        var emoji: String
        
        switch value {
        case "breakfast":
            emoji = "🍳"
        case "lunch":
            emoji = "🌯"
        case "dinner":
            emoji = "🍝"
        case "snack":
            emoji = "🍿"
        default:
            emoji = "🍔"
        }
        
        return emoji
    }
}
