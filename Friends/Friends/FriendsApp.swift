//
//  FriendsApp.swift
//  Friends
//
//  Created by Glenn Gijsberts on 10/02/2023.
//

import SwiftUI

@main
struct FriendsApp: App {
    @StateObject private var contactsDataController = ContactsDataController()
    
    var body: some Scene {
        WindowGroup {
            ContactsView()
                .environment(\.managedObjectContext, contactsDataController.container.viewContext)
        }
    }
}
