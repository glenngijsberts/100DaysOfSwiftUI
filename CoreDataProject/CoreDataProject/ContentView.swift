//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Glenn Gijsberts on 04/02/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var showNewWizard = false
    
    private let houses = ["Gryffindor", "Hufflepuff", "Ravenclaw", "Slytherin"]
    
    @State private var houseFilter = "Gryffindor"
    
    @State private var sortDescriptors: [SortDescriptor<Wizard>] = [SortDescriptor(\.name, order: .reverse)]
    
    func selectHouse(house: String) {
        houseFilter = house
    }

    var body: some View {
        NavigationStack {
            VStack {
                FilteredList(filterKey: "house", filterValue: houseFilter, predicateType: .equals, sortDescriptors: sortDescriptors) { (wizard: Wizard) in
                    Text("\(wizard.wrappedName)")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Button(action: {
                        showNewWizard.toggle()
                    }, label: {
                        Label("New wizard", systemImage: "plus")
                    })
                })
                ToolbarItem(placement: .navigationBarLeading, content: {
                    Menu(content: {
                        ForEach(houses, id: \.self) { house in
                            Button("\(house)") {
                                selectHouse(house: house)
                            }
                        }
                    }, label: {
                        Label("Select house", systemImage: "house")
                    })
                })
            }
            .sheet(isPresented: $showNewWizard, content: {
                AddWizard()
            })
            .navigationTitle("Wizards")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
