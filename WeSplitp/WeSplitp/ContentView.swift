//
//  ContentView.swift
//  WeSplit
//
//  Created by Glenn Gijsberts on 25/11/2022.
//

import SwiftUI

struct FormInputLabel: ViewModifier {
  func body(content: Content) -> some View {
    content
      .foregroundColor(.green)
  }
}

struct TipLabel: ViewModifier {
  let percentage: Int
  
  func body(content: Content) -> some View {
    content
      .foregroundColor(percentage == 0 ? .red : .green)
  }
}

extension View {
  func formInputLabel() -> some View {
    modifier(FormInputLabel())
  }
  
  func tipLabel(_ percentage: Int) -> some View {
    modifier(TipLabel(percentage: percentage))
  }
}

struct ContentView: View {
  let percentages = [0, 5, 10, 15, 20]
  
  @State private var amount = 0.0
  @State private var numberOfPeople = 2
  @State private var percentage = 0
  
  let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "EUR")
  
  var totalPrice: Double {
    let tip = Double(percentage)
    let tipValue = amount / 100 * tip
    let total = amount + tipValue
    
    return total
  }
  
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let totalPerPerson = totalPrice / peopleCount
    
    return totalPerPerson
  }
  
  @FocusState private var amountIsFocused: Bool
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Costs") {
          TextField("Amount", value: $amount, format: currency)
            .keyboardType(.decimalPad)
            .focused($amountIsFocused)
            .formInputLabel()
          
          Picker("Number of people", selection: $numberOfPeople) {
            ForEach (2..<100) { people in
              Text("\(people) people")
            }
          }.formInputLabel()
        }
        
        Section("Tip") {
          Picker("Percentage", selection: $percentage) {
            ForEach(Range(0...100), id: \.self) { percentage in
              Text(percentage, format: .percent)
            }
          }.formInputLabel()
        }
        
        Section("Total price") {
          Text(totalPrice, format: currency)
            .tipLabel(percentage)
        }
        
        Section("Total for each person") {
          Text(totalPerPerson, format: currency)
            .tipLabel(percentage)
        }
      }
      .navigationTitle("WeSplit")
      .toolbar {
        ToolbarItemGroup(placement: .keyboard) {
          Spacer()
          
          Button("Done") {
            amountIsFocused = false
          }
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
