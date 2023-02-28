//
//  CustomButton.swift
//  Mathematics
//
//  Created by Glenn Gijsberts on 22/12/2022.
//

import SwiftUI

struct CustomButtonStyle: ViewModifier {
  func body(content: Content) -> some View {
    content
      .tint(.green)
      .buttonStyle(.bordered)
      .controlSize(.large)
  }
}

extension Button {
  func customButton() -> some View {
    modifier(CustomButtonStyle())
  }
}

struct CustomButtonLabel: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.headline)
      .frame(maxWidth: .infinity)
  }
}

extension Text {
  func customButtonLabel() -> some View {
    modifier(CustomButtonLabel())
  }
}

struct CustomButton: View {
  var action: () -> Void
  var label: String
  
  init(_ label: String, action: @escaping () -> Void) {
    self.label = label
    self.action = action
  }
  
  var body: some View {
    Button(action: action) {
      Text(label).customButtonLabel()
    }.customButton()
  }
}
