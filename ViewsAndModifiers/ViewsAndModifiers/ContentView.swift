//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Glenn Gijsberts on 29/11/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      Text("Hello, world!")
          .padding()
          .background(.red)
          .padding()
          .background(.blue)
          .padding()
          .background(.green)
          .padding()
          .background(.yellow)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
