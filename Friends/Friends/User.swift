//
//  File.swift
//  Friends
//
//  Created by Glenn Gijsberts on 10/02/2023.
//

import Foundation

struct User: Codable, Identifiable {
    struct Friend: Codable {
        let id: UUID
        let name: String
    }
    
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}
