//
//  SectionStack.swift
//  Mathematics
//
//  Created by Glenn Gijsberts on 22/12/2022.
//

import SwiftUI

struct SectionTitle: ViewModifier {
  func body(content: Content) -> some View {
    content.textCase(.none).foregroundColor(.green).fontWeight(.medium)
  }
}

extension Text {
  func sectionTitle() -> some View {
    modifier(SectionTitle())
  }
}

struct StepperLabel: ViewModifier {
  func body(content: Content) -> some View {
    content.labelStyle(.titleOnly).font(.title2).fontWeight(.bold)
  }
}

extension Label {
  func stepperLabel() -> some View {
    modifier(StepperLabel())
  }
}

struct StepperSection: View {
  var label: String
  @Binding var value: Int
  var range: ClosedRange<Int>
  
  
  var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text(label).sectionTitle()
      
      Stepper(value: $value, in: range, step: 1, label: {
        Label("\(value.formatted())", systemImage: "number.circle").stepperLabel()
      })
    }
  }
}

struct StepperSection_Previews: PreviewProvider {
  @State private var count = 2
  
    static var previews: some View {
      StepperSection(label: "Title", value: .constant(1), range: 1...5)
    }
}

