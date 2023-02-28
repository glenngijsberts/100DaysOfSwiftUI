//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Glenn Gijsberts on 04/02/2023.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
