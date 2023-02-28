//
//  Color.swift
//  Moonshot
//
//  Created by Glenn Gijsberts on 30/12/2022.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkbackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    
    static var foregroundColor: Color {
        Color(red: 0.2, green: 0.6, blue: 0.4)
    }
}
