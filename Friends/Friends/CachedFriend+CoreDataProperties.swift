//
//  CachedFriend+CoreDataProperties.swift
//  Friends
//
//  Created by Glenn Gijsberts on 11/02/2023.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?
    
    public var wrappedName: String {
        name ?? "John Doe"
    }
}

extension CachedFriend : Identifiable {

}
