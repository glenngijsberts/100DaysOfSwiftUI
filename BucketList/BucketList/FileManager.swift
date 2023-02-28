//
//  FileManager.swift
//  Bucketlist
//
//  Created by Glenn Gijsberts on 05/07/2023.
//

import Foundation

extension FileManager {
    static var documentsDirecotry: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
