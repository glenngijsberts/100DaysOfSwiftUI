//
//  AddExpenseView.swift
//  iExpense
//
//  Created by Glenn Gijsberts on 24/12/2022.
//

import SwiftUI

struct AddExpenseView: View {
  @Environment(\.dismiss) var dismiss
  
  @ObservedObject var expenses: Expenses
  @ObservedObject var preferredCurrency: PreferredCurrency
  
  @State private var name = ""
  @State private var type = types[0]
  @State private var amount = 0.0
  
  @State private var showAlert = false
  
  static let types = ["Personal", "Business"]
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $name)
        
        Picker("Type", selection: $type) {
          ForEach(AddExpenseView.types, id: \.self) {
            Text($0)
          }
        }
        
        TextField("Amount", value: $amount, format: .currency(code: preferredCurrency.currency)).keyboardType(.decimalPad)
      }
      .alert("Please enter a name", isPresented: $showAlert, actions: {}) {
        Text("You need to give your expense a label!")
      }
      .toolbar {
        Button("Save") {
          guard name.count > 0 else {
            showAlert.toggle()
            
            return
          }
          
          let expense = ExpenseItem(name: name, type: type, amount: amount)
          expenses.items.append(expense)
          
          dismiss()
        }
      }
      .navigationTitle("Add new expense")
    }
  }
}

struct AddExpenseView_Previews: PreviewProvider {
  static var previews: some View {
    AddExpenseView(expenses: Expenses(), preferredCurrency: PreferredCurrency())
  }
}
