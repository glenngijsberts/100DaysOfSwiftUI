//
//  ContentView.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import SwiftUI

struct FoodView: View {
    @State private var showAddFoodSheet = false
    @StateObject var foodItems = FoodItems()
    
    var hasItems: Bool {
        foodItems.items.count > 0
    }
    
    var addButton: some View {
        Button {
            showAddFoodSheet.toggle()
        } label: {
            Text("Add food")
                .foregroundColor(.primaryColor)
        }
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    if !hasItems {
                        Button {
                            showAddFoodSheet.toggle()
                        } label: {
                            VStack(spacing: 10) {
                                Text("Start adding your first meal!")
                                
                                addButton
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity)
                        .background(.elevatedBackground)
                        .cornerRadius(12)
                        .padding()
                    }
                    
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: geo.size.width / 2 - 32 ))]) {
                        ForEach(foodItems.items) { item in
                            NavigationLink {
                                FoodDetailsView(food: item, foodItems: foodItems)
                            } label: {
                                FoodBlock(food: item)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .toolbar {
                    if hasItems {
                        addButton
                    }
                }
                .sheet(isPresented: $showAddFoodSheet) {
                    AddFoodSheet(foodItems: foodItems)
                }
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .navigationTitle("MyFoodie")
            }
        }
        .tint(.white)
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
    }
}
