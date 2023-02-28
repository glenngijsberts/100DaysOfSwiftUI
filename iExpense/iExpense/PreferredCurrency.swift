//
//  Currency.swift
//  iExpense
//
//  Created by Glenn Gijsberts on 24/12/2022.
//

import Foundation

class PreferredCurrency: ObservableObject {
  @Published var currency: String {
    didSet {
      let encoder = JSONEncoder()
      
      if let data = try? encoder.encode(currency) {
        UserDefaults.standard.set(data, forKey: "PreferredCurrency")
      }
    }
  }
  
  init() {
    if let preferredCurrency = UserDefaults.standard.data(forKey: "PreferredCurrency") {
      let decoder = JSONDecoder()
      
      if let decodedItems = try? decoder.decode(String.self, from: preferredCurrency) {
        currency = decodedItems
        
        return
      }
    }
    
    currency = "EUR"
  }
}
