//
//  ContactsDataController.swift
//  Friends
//
//  Created by Glenn Gijsberts on 11/02/2023.
//

import Foundation
import CoreData

class ContactsDataController: ObservableObject {
    let container = NSPersistentContainer(name: "Contacts")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load: \(error.localizedDescription)")
                
                return
            }
        }
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
