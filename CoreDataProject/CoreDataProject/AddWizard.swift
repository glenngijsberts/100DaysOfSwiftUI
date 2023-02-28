//
//  AddWizard.swift
//  CoreDataProject
//
//  Created by Glenn Gijsberts on 04/02/2023.
//

import SwiftUI

struct AddWizard: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    
    @State private var name = ""
    @State private var house = "Gryffindor"
    private var houses = ["Gryffindor", "Hufflepuff", "Ravenclaw", "Slytherin"]
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            Picker("House", selection: $house, content: {
                ForEach(houses, id: \.self) {
                    Text($0)
                }
            })
            Button("Save Wizard", action: {
                let wizard = Wizard(context: moc)
                
                wizard.name = name
                wizard.house = house
                
                try! moc.save()
                
                dismiss()
            }).disabled(name == "")
        }
    }
}
