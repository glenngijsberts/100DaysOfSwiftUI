//
//  ExpenseRowView.swift
//  iExpense
//
//  Created by Glenn Gijsberts on 25/12/2022.
//

import SwiftUI

struct ExpenseRowsView: View {
  @ObservedObject var preferredCurrency: PreferredCurrency
  
  var title: String
  var items: [ExpenseItem]
  var handleRemove: (_ id: UUID) -> Void
  
  var body: some View {
    Section(title) {
      ForEach(items) { item in
        HStack {
          VStack(alignment: .leading) {
            Text(item.name).font(.headline)
            Text(item.type)
          }
          
          Spacer()
          
          Text(item.amount, format: .currency(code: preferredCurrency.currency)).foregroundColor(item.amount > 25.0 ? .red : .green)
        }
      }.onDelete {
        let item = items[$0.first!]
        
        handleRemove(item.id)
      }
    }
  }
}
