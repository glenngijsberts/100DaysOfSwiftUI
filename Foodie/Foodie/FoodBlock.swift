//
//  FoodBlock.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import SwiftUI

struct FoodBlock: View {
    let food: Food
    
    var body: some View {
        VStack {
            Text(food.category.icon)
                .font(.largeTitle)
                .padding(.bottom, 4)
            
            Text(food.title)
                .foregroundColor(.white)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
        .padding(32)
        .background(food.category.categoryColor)
        .cornerRadius(12)
    }
}
