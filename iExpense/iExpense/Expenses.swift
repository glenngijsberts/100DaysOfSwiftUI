//
//  Expenses.swift
//  iExpense
//
//  Created by Glenn Gijsberts on 24/12/2022.
//

import Foundation

class Expenses: ObservableObject {
  @Published var items = [ExpenseItem]() {
    didSet {
      let encoder = JSONEncoder()
      
      if let data = try? encoder.encode(items) {
        UserDefaults.standard.set(data, forKey: "ExpenseItems")
      }
    }
  }
  
  init() {
    if let expenseItems = UserDefaults.standard.data(forKey: "ExpenseItems") {
      let decoder = JSONDecoder()
      
      if let decodedItems = try? decoder.decode([ExpenseItem].self, from: expenseItems) {
        items = decodedItems
        
        return
      }
    }
    
    items = []
  }
}
