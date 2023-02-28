//
//  SectionView.swift
//  Friends
//
//  Created by Glenn Gijsberts on 10/02/2023.
//

import SwiftUI

struct SectionView: View {
    let content: String
    let header: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Section(content: {
                Text(content)
            }, header: {
                Text(header)
                    .foregroundColor(.accentColor)
                    .fontWeight(.semibold)
            })
        }
    }
}
