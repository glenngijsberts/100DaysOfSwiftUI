//
//  CustomNavigationTitle.swift
//  Moonshot
//
//  Created by Glenn Gijsberts on 31/12/2022.
//

import SwiftUI

struct CustomNavigationTitle: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        ToolbarItem(placement: .principal) {
            VStack {
                Text(title).fontWeight(.bold)
                Text(subtitle)
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
        }
    }
}

struct CustomNavigationTitle_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationTitle()
    }
}
