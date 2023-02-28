//
//  File.swift
//  CupcakeCorner
//
//  Created by Glenn Gijsberts on 18/01/2023.
//

import Foundation

extension String {
    func isEmptyWithoutTrimmedSpaces() -> Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
