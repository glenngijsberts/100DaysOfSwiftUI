//
//  FoodTypeBlock.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import SwiftUI

struct FoodCategoryBlock: View {
    let category: FoodCategory
    
    @Binding var selectedCategory: String
    
    var body: some View {
            Button {
                selectedCategory = category.value
            } label: {
                VStack {
                    Text(category.icon)
                        .font(.largeTitle)
                        .padding(.bottom, 4)
                    
                    Text(category.title)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .frame(width: 140, height: 140)
                .background(category.value == selectedCategory ? category.categoryColor : .elevatedBackground)
                .cornerRadius(12)
            }
    }
}
