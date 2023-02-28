//
//  ContentView.swift
//  Animations
//
//  Created by Glenn Gijsberts on 15/12/2022.
//

import SwiftUI

extension Color {
  static func random() -> Color {
    return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
  }
}

struct CornerRotationModifier: ViewModifier {
  let amount: Double
  let anchor: UnitPoint
  
  func body(content: Content) -> some View {
    content
      .rotationEffect(.degrees(amount), anchor: anchor)
      .clipped()
  }
}

extension AnyTransition {
  static var pivot: AnyTransition {
    .modifier(active: CornerRotationModifier(amount: -90, anchor: .topLeading), identity: CornerRotationModifier(amount: 0, anchor: .topLeading))
  }
}

struct ContentView: View {
  @State private var dragAmount = CGSize.zero
  @State private var colors = [Color.random(), Color.random()]
  
  var body: some View {
    VStack {
      LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomLeading)
        .frame(width: 300, height: 200)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .offset(dragAmount)
        .gesture(
          DragGesture()
            .onChanged { position in
              dragAmount = position.translation
            }
            .onEnded { _ in
              withAnimation(.spring()) {
                dragAmount = .zero
                colors = [Color.random(), Color.random()]
              }
            }
        )
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
