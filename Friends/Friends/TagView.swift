//
//  TagView.swift
//  Friends
//
//  Created by Glenn Gijsberts on 10/02/2023.
//

import SwiftUI

struct TagView: View {
    let tag: String
    
    var body: some View {
        VStack {
            Text(tag)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .background(Color.accentColor)
        .cornerRadius(50)
    }
}
