//
//  ContentView.swift
//  Moonshot
//
//  Created by Glenn Gijsberts on 25/12/2022.
//

import SwiftUI

struct MainView: View {
    @State private var showAsList = false
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationStack {
            Group {
                if showAsList {
                    List(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack {
                                HStack(spacing: 20) {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 48, height: 48)
                                    
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color.lightBackground)
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                            ForEach(missions) { mission in
                                NavigationLink {
                                    MissionView(mission: mission, astronauts: astronauts)
                                } label: {
                                    VStack {
                                        MissionCard(mission: mission)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkbackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAsList.toggle()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .foregroundColor(.foregroundColor)
                }
            }
        }
        .accentColor(.foregroundColor)
    }
}

struct MainView_previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
