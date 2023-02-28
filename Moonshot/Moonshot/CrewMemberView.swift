//
//  CrewMemberView.swift
//  Moonshot
//
//  Created by Glenn Gijsberts on 31/12/2022.
//

import SwiftUI

struct CrewMemberView: View {
    let crewMember: CrewMember
    
    var body: some View {
        VStack {
            Image(crewMember.astronaut.id)
                .resizable()
                .frame(width: 104, height: 72)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .strokeBorder(.darkbackground, lineWidth: 1)
                )
            
            VStack(alignment: .center) {
                Text(crewMember.astronaut.name)
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text(crewMember.role)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.lightBackground)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
