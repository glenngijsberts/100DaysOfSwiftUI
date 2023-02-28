//
//  ContentView.swift
//  iExpense
//
//  Created by Glenn Gijsberts on 23/12/2022.
//

import SwiftUI

struct ExpensesView: View {
  @StateObject var expenses = Expenses()
  @StateObject var preferredCurrency = PreferredCurrency()
  
  @State private var showAddExpenseView = false
  @State private var showCurrencyView = false
  
  func handleRemove(id: UUID) {
    expenses.items.removeAll(where: { item in
      item.id == id
    })
  }
  
  var personalItems: [ExpenseItem] {
    expenses.items.filter {
      $0.type == "Personal"
    }
  }
  
  var businessItems: [ExpenseItem] {
    expenses.items.filter {
      $0.type == "Business"
    }
  }
  
  var body: some View {
    NavigationStack {
      List {
        if personalItems.count > 0 {
          ExpenseRowsView(preferredCurrency: preferredCurrency, title: "Personal", items: personalItems, handleRemove: handleRemove)
        }
        
        if businessItems.count > 0 {
          ExpenseRowsView(preferredCurrency: preferredCurrency, title: "Business", items: businessItems, handleRemove: handleRemove)
        }
      }
      .sheet(isPresented: $showAddExpenseView) {
        AddExpenseView(expenses: expenses, preferredCurrency: preferredCurrency)
      }
      .sheet(isPresented: $showCurrencyView) {
        PreferredCurrencyView(preferredCurrency: preferredCurrency)
      }
      .toolbar {
        Button {
          showCurrencyView.toggle()
        } label: {
          Image(systemName: "dollarsign.circle")
        }
        
        Button {
          showAddExpenseView.toggle()
        } label: {
          Image(systemName: "plus")
        }
      }
      .navigationTitle("Expenses")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExpensesView()
    }
}
