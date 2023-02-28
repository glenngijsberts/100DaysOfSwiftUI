//
//  Title.swift
//  Mathematics
//
//  Created by Glenn Gijsberts on 22/12/2022.
//

import SwiftUI

struct Title: View {
  var title: String
  
  init(_ title: String) {
    self.title = title
  }
  
    var body: some View {
        Text(title).font(.largeTitle).fontWeight(.black)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title("Learn Tables")
    }
}
