//
//  Food.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import Foundation

struct Food: Identifiable, Codable {
    var id = UUID()
    let title: String
    let calories: Int
    let category: FoodCategory
}
