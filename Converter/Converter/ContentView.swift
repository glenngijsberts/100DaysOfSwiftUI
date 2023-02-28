//
//  ContentView.swift
//  Converter
//
//  Created by Glenn Gijsberts on 26/11/2022.
//

import SwiftUI

struct ContentView: View {
  private let options = ["seconds": 1.00, "minutes": 60.00, "hours": 3600.00, "days": 86400.00]
  
  @State private var inputOption = "seconds"
  @State private var outOption = "seconds"
  @State private var value = 0.00
  
  private var convertedValue: Double {
    let input = value * (options[inputOption] ?? 0.00) / (options[outOption] ?? 0.00)
  
    return input
  }
  
  private var sortedOptions: [String] {
    options.sorted(by: >).map { $0.key }
  }
  
  
  var body: some View {
    NavigationStack {
      Form {
        Section("Input") {
          Picker("Input", selection: $inputOption) {
            ForEach(sortedOptions, id: \.self) { option in
              Text(option.capitalized)
            }
          }.pickerStyle(.segmented)
        }
        
        
        Section("Output") {
          Picker("Output", selection: $outOption) {
            ForEach(sortedOptions, id: \.self) { option in
              Text(option.capitalized)
            }
          }.pickerStyle(.segmented)
        }
        
        Section("Value") {
          TextField("Enter the value you want to convert", value: $value, format: .number).keyboardType(.numberPad)
        }
        
        Section("Converted value") {
          Text(String(convertedValue.formatted()))
        }
        
      }
      
      .navigationTitle("Converter")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
