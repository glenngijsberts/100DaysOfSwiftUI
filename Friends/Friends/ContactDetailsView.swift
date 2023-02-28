//
//  ContactDetailsView.swift
//  Friends
//
//  Created by Glenn Gijsberts on 10/02/2023.
//

import SwiftUI

struct ContactDetailsView: View {
    let user: CachedUser
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                SectionView(content: user.wrappedEmail, header: "Email address")
                SectionView(content: user.wrappedCompany, header: "Company")
                SectionView(content: user.wrappedAbout, header: "About \(user.wrappedName)")
                
                Text("Tags")
                    .foregroundColor(.accentColor)
                    .fontWeight(.semibold)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.wrappedTags, id: \.self) {
                            TagView(tag: $0)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .padding(15)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .navigationTitle(user.wrappedName)
    }
}
