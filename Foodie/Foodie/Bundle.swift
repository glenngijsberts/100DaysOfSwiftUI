//
//  Bundle.swift
//  Foodie
//
//  Created by Glenn Gijsberts on 13/01/2023.
//

import Foundation

extension Bundle {
    func decode<Type: Codable>(_ file: String) -> Type {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate file")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load file")
        }
        
        let decoder = JSONDecoder()
        
        guard let decodedData = try? decoder.decode(Type.self, from: data) else {
            fatalError("Failed to decode")
        }
        
        return decodedData
    }
}
