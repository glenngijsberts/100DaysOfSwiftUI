//
//  PreferredCurrencyView.swift
//  iExpense
//
//  Created by Glenn Gijsberts on 25/12/2022.
//

import SwiftUI

struct PreferredCurrencyView: View {
  @Environment(\.dismiss) var dismiss
  
  @State private var query = ""
  
  @ObservedObject var preferredCurrency: PreferredCurrency
  
  let currencies = Locale.Currency.isoCurrencies
    .map { currency in
      currency.identifier
    }
  
  var filteredCurrencies: [String] {
    if (query.count < 1) {
      return currencies
    }
        
    return currencies.filter { item in
      item.contains(query)
    }
  }
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Search for currencies") {
          TextField("Search for currencies", text: $query)
        }
        
        Picker("Preferred currency", selection: $preferredCurrency.currency) {
          ForEach(filteredCurrencies, id: \.self) {
            Text($0)
          }
        }.pickerStyle(.inline)
      }
      .toolbar {
        Button("Close") {
          dismiss()
        }
      }
      .navigationTitle("Select currency")
    }
  }
}

struct PreferredCurrencyView_Previews: PreviewProvider {
  static var previews: some View {
    PreferredCurrencyView(preferredCurrency: PreferredCurrency())
  }
}
