//
//  RowView.swift
//  Friends
//
//  Created by Glenn Gijsberts on 10/02/2023.
//

import SwiftUI

struct RowView: View {
    let user: CachedUser
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Circle()
                .fill(user.isActive ? .green : .red)
                .frame(width: 8, height: 8)
            
            
            VStack(alignment: .leading) {
                Text(user.wrappedName)
                Text(user.wrappedEmail)
                    .foregroundColor(.secondary)
            }
        }
    }
}
