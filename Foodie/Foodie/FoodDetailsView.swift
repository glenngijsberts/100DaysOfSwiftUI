//
//  FoodDetailsView.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import SwiftUI

struct FoodDetailsView: View {
    let food: Food
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @ObservedObject var foodItems: FoodItems
    
    var body: some View {
        VStack {
            
        VStack {
            Text(food.category.icon)
                .font(.system(size: 120))
                .padding(.bottom)
            Text(food.title)
                .font(.headline)
            Text("Amount of calories is \(food.calories)")
        }
    }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(food.category.categoryColor)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    foodItems.items.removeAll(where: { item in
                        item.id == food.id
                    })
                    
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Remove")
                        .foregroundColor(.white)
                }
            }
        }
    }
}
