//
//  FileManager.swift
//  BucketList
//
//  Created by Glenn Gijsberts on 14/02/2023.
//

import Foundation

extension FileManager {
    func writeAndRead(_ content: String, file: String) {
        let path = self.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let url = path.appendingPathComponent(file)
        
        do {
            try content.write(to: url, atomically: true, encoding: .utf8)
            
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print("Failed")
        }
    }
}
