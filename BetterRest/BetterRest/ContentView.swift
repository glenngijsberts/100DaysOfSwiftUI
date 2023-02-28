//
//  ContentView.swift
//  BetterRest
//
//  Created by Glenn Gijsberts on 06/12/2022.
//

import CoreML
import SwiftUI

struct SectionLabel: ViewModifier {
  let theme: Color
  
  init(_ theme: Color) {
    self.theme = theme
  }
  
  func body(content: Content) -> some View {
    content.foregroundColor(theme).fontWeight(.medium)
  }
}

extension View {
  func sectionLabel(_ theme: Color) -> some View {
    modifier(SectionLabel(theme))
  }
}

struct ContentView: View {
  @State private var sleepAmount = 8.0
  @State private var wakeUpTime = defaultWakeUpTime
  @State private var coffeeAmount = 1
  
  static private var defaultWakeUpTime: Date {
    var components = DateComponents()
    components.hour = 8
    components.minute = 0
    
    return Calendar.current.date(from: components) ?? Date.now
  }
  
  private var bedtime: String {
    let config = MLModelConfiguration()
    let model = try! SleepingCalculator(configuration: config)
    
    let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
    let hour = components.hour! * 60 * 60
    let minute = components.minute! * 60
    
    let prediction = try! model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
    
    let sleepTime = wakeUpTime - prediction.actualSleep
    
    return sleepTime.formatted(date: .omitted, time: .shortened)
  }
  
  private let theme = Color.brown
  
  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Wake up at").sectionLabel(theme)) {
          DatePicker("Select time", selection: $wakeUpTime, displayedComponents: .hourAndMinute).accentColor(theme)
        }
        
        Section(header: Text("Amount of hours").sectionLabel(theme))  {
          Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.5)
        }
        
        Section(header: Text("Cups of Coffee").sectionLabel(theme)) {
          Picker("Select coffee", selection: $coffeeAmount) {
            ForEach(1...5, id: \.self) {
              Text("\($0)")
            }
          }.pickerStyle(.segmented)
        }
        
        
        VStack(alignment: .center, spacing: 8) {
          Text("Your ideal bedtime is")
          
          Text(bedtime).font(.title).fontWeight(.semibold).foregroundColor(theme)
        }.frame(maxWidth: .infinity)
      }
      
      .navigationTitle("BetterRest")
      .toolbarColorScheme(.dark, for: .navigationBar)
      .toolbarBackground(theme, for: .navigationBar)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
