//
//  Bundle-Decodable.swift
//  Moonshot
//
//  Created by Glenn Gijsberts on 26/12/2022.
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard let loaded = try? decoder.decode(Type.self, from: data) else {
            fatalError("Failed to decode")
        }
        
        return loaded
    }
}
