//
//  AddFoodSheet.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import SwiftUI

struct AddFoodSheet: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var foodItems: FoodItems
    
    @FocusState var isInputActive: Bool
    
    @State private var title = ""
    @State private var calories = ""
    @State private var category = ""
    
    @State private var showAlert = false
    @State private var alertText = ""
    
    let categories: [FoodCategory] = Bundle.main.decode("categories.json")
    
    func isValid(_ field: String) -> Bool {
        field.count > 0
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            FoodCategoryBlock(category: category, selectedCategory: $category)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("Fill in your details")
                        .fontWeight(.medium)
                    
                    TextField("Title", text: $title)
                        .focused($isInputActive)
                        .frame(height: 56)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
                        .background(.elevatedBackground)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    
                    TextField("Amount of calories", text: $calories)
                        .focused($isInputActive)
                        .frame(height: 56)
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 8))
                        .background(.elevatedBackground)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .keyboardType(.numberPad)
                    
                    Spacer()
                    
                    Button(action: {
                        guard isValid(title) else {
                            alertText = "Fill in a title!"
                            showAlert.toggle()
                            return
                        }
                        
                        guard isValid(calories) else {
                            alertText = "Fill in your calories!"
                            showAlert.toggle()
                            return
                        }
                        
                        guard isValid(category) else {
                            alertText = "Fill in a category!"
                            showAlert.toggle()
                            return
                        }
                        
                        foodItems.items.append(Food(title: title, calories: Int(calories) ?? 0, category: FoodCategory(title: category)))
                        
                        dismiss()
                    }) {
                      Text("Save")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                    }
                    .tint(.purple)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                }
                .padding(.top)
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(.primaryColor)
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Close") {
                        isInputActive.toggle()
                    }
                }
            }
            .alert("Some info is missing", isPresented: $showAlert) {
                Button {} label: {
                    Text("OK")
                        .tint(.primaryColor)
                }
            } message: {
                Text(alertText)
            }
            .frame(maxWidth: .infinity)
            .background(.darkBackground)
            .navigationTitle("Add food")
        }
    }
}

struct AddFoodSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodSheet(foodItems: FoodItems())
    }
}
