//
//  MissionView.swift
//  Moonshot
//
//  Created by Glenn Gijsberts on 30/12/2022.
//

import SwiftUI

struct Title: View {
    let title: String
    
    init(_ title: String) {
        self.title = title
    }
    
    var body: some View {
        Text(title)
            .font(.title.bold())
    }
}

struct Subtitle: View {
    let subtitle: String
    
    init(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    var body: some View {
        Text(subtitle)
            .font(.title2.bold())
    }
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.vertical)
                    
                    VStack(alignment: .leading) {
                        Title("Mission Highlights")
                            .padding(.bottom)
                        
                        Text(mission.description)
                    }
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Subtitle("Crew Members")
                            .padding(.top)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(crew, id: \.role) { crewMember in
                                    NavigationLink {
                                        AstronautView(astronaut: crewMember.astronaut)
                                    } label: {
                                        HStack {
                                            CrewMemberView(crewMember: crewMember)
                                        }
                                    }
                                }
                            }
                            .padding()
                        }
                    }
                }
                .padding(.bottom)
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text(mission.displayName)
                        .fontWeight(.bold)
                    Text(mission.formattedLaunchDate)
                        .foregroundColor(.secondary)
                        .font(.caption)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkbackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
