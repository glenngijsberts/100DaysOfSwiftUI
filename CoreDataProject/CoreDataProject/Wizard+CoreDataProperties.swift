//
//  Wizard+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Glenn Gijsberts on 04/02/2023.
//
//

import Foundation
import CoreData


extension Wizard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wizard> {
        return NSFetchRequest<Wizard>(entityName: "Wizard")
    }

    @NSManaged public var name: String?
    @NSManaged public var house: String?
    
    var wrappedName: String {
        name ?? "Unknown"
    }

    var wrappedHouse: String {
        house ?? "Unknown"
    }

}

extension Wizard : Identifiable {

}
