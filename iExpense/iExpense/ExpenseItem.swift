//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Glenn Gijsberts on 24/12/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
  var id = UUID()
  let name: String
  let type: String
  let amount: Double
}
