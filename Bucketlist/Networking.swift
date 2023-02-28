//
//  Networking.swift
//  Bucketlist
//
//  Created by Glenn Gijsberts on 08/07/2023.
//

import Foundation

class Networking {
    static func fetchData<T: Codable>(_ endpoint: String) async -> T? {
        guard let url = URL(string: endpoint) else {
            print("Bad url: \(endpoint)")
            
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(T.self, from: data)
            
            return items
        } catch {
            return nil
        }
    }
}
